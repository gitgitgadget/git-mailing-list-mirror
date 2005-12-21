From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Problem with the dump HTTP transport
Date: Wed, 21 Dec 2005 08:26:38 -0800 (PST)
Message-ID: <20051221162638.32965.qmail@web31802.mail.mud.yahoo.com>
References: <1135166574.26233.64.camel@localhost>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Dec 21 17:29:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep6nq-000763-CB
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 17:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbVLUQ0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 11:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVLUQ0l
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 11:26:41 -0500
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:50840 "HELO
	web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932479AbVLUQ0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 11:26:41 -0500
Received: (qmail 32967 invoked by uid 60001); 21 Dec 2005 16:26:38 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=J6pX/XDZgRsEjnpCoG/Cas1bvvIufmF2FnmahCOozaEmjgIVJGy9qG4LKFHNNU29/qc+bSJBOLFIJAk5WMf3P/xSFUVAOAaG9UroDkCwBXKn682ok7YnBAFYS3nYOO8Uvs9Krmy6ZqYSpfInUZc7ZV986CV2i58yz6io31St51M=  ;
Received: from [68.221.74.68] by web31802.mail.mud.yahoo.com via HTTP; Wed, 21 Dec 2005 08:26:38 PST
To: Marcel Holtmann <marcel@holtmann.org>, git@vger.kernel.org
In-Reply-To: <1135166574.26233.64.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13878>

--- Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Junio,
> 
> after you released 1.0.0, I tried to pull it over HTTP, but it fails
> with the following output:
> 
> # cg-update
> Fetching head...
> Fetching objects...
> Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
> Getting pack list for http://www.kernel.org/pub/scm/git/git.git/
> error: Unable to find c2f3bf071ee90b01f2d629921bb04c4f798f02fa under
> http://www.kernel.org/pub/scm/git/git.git/
> 
> Cannot obtain needed object c2f3bf071ee90b01f2d629921bb04c4f798f02fa
> while processing commit 0000000000000000000000000000000000000000.
> cg-fetch: objects fetch failed
> 
> Both, git and cogito, are the latest versions from yesterday. So it
> seems every time you repack, you need to do something extra to keep the
> dump HTTP transport happy.

I'm seeing the same thing:

$git pull
Fetching refs/heads/master from http://kernel.org/pub/scm/git/git.git using http
Getting alternates list for http://kernel.org/pub/scm/git/git.git/
Getting pack list for http://kernel.org/pub/scm/git/git.git/
error: Unable to find c2f3bf071ee90b01f2d629921bb04c4f798f02fa under
http://kernel.org/pub/scm/git/git.git/

Cannot obtain needed object c2f3bf071ee90b01f2d629921bb04c4f798f02fa
while processing commit 0000000000000000000000000000000000000000.

   Luben
