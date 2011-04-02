From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] git-pack-objects.txt: fix grammatical errors
Date: Sat, 02 Apr 2011 12:03:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1104021155230.28032@xanadu.home>
References: <1301475606-11339-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 02 18:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q63IF-0000sn-CY
	for gcvg-git-2@lo.gmane.org; Sat, 02 Apr 2011 18:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab1DBQDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 12:03:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17001 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab1DBQDM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 12:03:12 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LJ100FDU8IU7R10@vl-mh-mrz25.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 02 Apr 2011 12:01:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <1301475606-11339-1-git-send-email-bebarino@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170653>

On Wed, 30 Mar 2011, Stephen Boyd wrote:

> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
> 
> This paragraph might need even more work. Paint away!
> 
>  Documentation/git-pack-objects.txt |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
> index a51071e..442018b 100644
> --- a/Documentation/git-pack-objects.txt
> +++ b/Documentation/git-pack-objects.txt
> @@ -190,9 +190,9 @@ self-contained. Use `git index-pack --fix-thin`
>  (see linkgit:git-index-pack[1]) to restore the self-contained property.
>  
>  --delta-base-offset::
> -	A packed archive can express base object of a delta as
> -	either 20-byte object name or as an offset in the
> -	stream, but older version of git does not understand the
> +	A packed archive can express the base object of a delta as
> +	either a 20-byte object name or as an offset in the
> +	stream, but older versions of git don't understand the
>  	latter.  By default, 'git pack-objects' only uses the
>  	former format for better compatibility.  This option
>  	allows the command to use the latter format for

This is misleading and not even true anymore if not using pack-objects.  
Most people are using either 'git repack' or even 'git gc', and the 
default is to use this parameter since commit 22c79eab.


Nicolas
