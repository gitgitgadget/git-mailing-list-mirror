From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] git-tag: Document that -m/-F create tag objects, too
Date: Mon, 9 Apr 2007 15:58:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0704091554330.32490@beast.quantumfyre.co.uk>
References: <E1Hash0-0004rN-Mu@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Apr 09 18:14:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HavMw-0005ig-Bz
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 17:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933847AbXDIO65 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 10:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933826AbXDIO6j
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 10:58:39 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:41274 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933840AbXDIO6e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 10:58:34 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 31EC8C6657
	for <git@vger.kernel.org>; Mon,  9 Apr 2007 15:58:32 +0100 (BST)
Received: (qmail 32026 invoked by uid 103); 9 Apr 2007 15:58:11 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.90/3050. spamassassin: 3.1.8. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.032356 secs); 09 Apr 2007 14:58:11 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 9 Apr 2007 15:58:11 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <E1Hash0-0004rN-Mu@mid.deneb.enyo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44054>

On Mon, 9 Apr 2007, Florian Weimer wrote:

> And warn about the fact that lightweight tags are not normally
> transferred by clone/fetch.

Um ... yes, they are (in v1.5.1 at least).

>
> Signed-off-by: Florian Weimer <fw@deneb.enyo.de>
> ---
> Documentation/git-tag.txt |   16 +++++++++-------
> 1 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 70235e8..fc5f4e3 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -20,13 +20,15 @@ Adds a 'tag' reference in `.git/refs/tags/`
> Unless `-f` is given, the tag must not yet exist in
> `.git/refs/tags/` directory.
>
> -If one of `-a`, `-s`, or `-u <key-id>` is passed, the command
> -creates a 'tag' object, and requires the tag message.  Unless
> -`-m <msg>` is given, an editor is started for the user to type
> -in the tag message.
> -
> -Otherwise just the SHA1 object name of the commit object is
> -written (i.e. a lightweight tag).
> +If one of `-a`, `-m <msg>`, `-F <file>`, `-s`, or `-u <key-id>` is
> +passed, the command creates a 'tag' object.  Unless `-m <msg>` or `-F
> +<file>` is given, an editor is started for the user to type in the tag
> +message.
> +
> +Otherwise just the SHA1 object name of the commit object is written
> +(i.e. a lightweight tag).  Note that such tags are not automatically
> +copied by "git-clone" and "git-fetch", so you want to use them for
> +local tags only.
>
> A GnuPG signed tag object will be created when `-s` or `-u
> <key-id>` is used.  When `-u <key-id>` is not used, the
>

-- 
Julian

  ---
"But as a result of evil, there's some amazing things that are taking place in
America."

George W. Bush
Daytona Beach, Florida.
