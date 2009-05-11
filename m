From: MALET Jean-Luc <jeanluc.malet@gmail.com>
Subject: Re: merging multiple commit into one?
Date: Tue, 12 May 2009 00:11:24 +0200
Message-ID: <4A08A28C.3020202@gmail.com>
References: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com> <20090511212923.GA19844@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue May 12 00:12:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3djd-0005lv-V8
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 00:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbZEKWMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 18:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755314AbZEKWMZ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 18:12:25 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:47609 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbZEKWMY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 18:12:24 -0400
Received: by ewy24 with SMTP id 24so3807542ewy.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 15:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nJZdKqCAgxov/7kyl02XmiMs30nmf3KLv2sMQt7jOE8=;
        b=jSyLGKeXevdsS9PRNavBlFfrkLwR2BLOY+8V/iOC+LenFeYLxIXwls1zK0wRo+k2cT
         AVG4avdRTj64h2JeqnJd0SvuZoXz86JuJ/UI4DVuK93iMpexW4KKmHceH7WPh7A5LyzB
         vOAOJMDGG4KoA9C4pRF4s02th/nKcb21XZ2A4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=XJtUgTrm1/IxKSOzU7xOSyySE2hH6sSFT9Fa5AMVo2bPGWtxfRf3bptwhuFPLZy7IH
         ELkEdCcZPecb3Ehluh4s7aQrruDUhITgZ6Z9oQZSNMl5GmY8eAVUHLcpQunaaviCuYVG
         HWYX93aucoHHjzMaa3t+JrtBMValy/emSuhhE=
Received: by 10.210.79.3 with SMTP id c3mr9477520ebb.41.1242079944607;
        Mon, 11 May 2009 15:12:24 -0700 (PDT)
Received: from jlmport.sorcerer (124.115.97-84.rev.gaoland.net [84.97.115.124])
        by mx.google.com with ESMTPS id 24sm8779829eyx.53.2009.05.11.15.12.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 15:12:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.18 (X11/20090308)
In-Reply-To: <20090511212923.GA19844@macbook.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118855>

Heiko Voigt wrote:
> On Mon, May 11, 2009 at 03:21:27PM +0200, jean-luc malet wrote:
>   
>> according to my knowledge of git, removing the commit and rewriting
>> the last commit log so that it better reflect the modification will do
>> the job but I'm not sure git allow it...
>>     
>
> If you just want to get rid of the last commit
>
>   git reset HEAD^
>
> will remove the commit but keep your working directory untouched. In
> such a workflow I find it easier to start the new commit from zero than
> from the stashed stuff.
>
> By the way. You might also take a look at the command
>
>   git stash
>
> which is especially crafted for saving work in progress.
>
> cheers Heiko
>   
hi,
thanks, I know about git stash, the problem is that this command don't 
fits well when working on multiple copies of the sources on different 
locations, git stash is usefull for saving states before branching 
elsewhere and comming back to the branch and keep going on your work.... 
I use it in a different way since I  commit to continue work on a 
different pc, (so I commit, I push to some git archive, I pull from the 
other pc, and continue the work on the other pc, then commit push again 
and pull again on first pc....). As far as I know you can't push stashed 
information, I'm wrong?
thanks
JLM
