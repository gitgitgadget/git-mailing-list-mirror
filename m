From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] merge: default to @{upstream}
Date: Fri, 28 Jan 2011 16:41:15 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101281633580.11103@debian>
References: <1296231457-18780-1-git-send-email-felipe.contreras@gmail.com> <AANLkTimc92giAAJnzjv5Bq4f853xqEfLrgB=j+iRXPaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 22:41:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Piw4U-0000DZ-UM
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 22:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1A1Vl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 16:41:26 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38660 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab1A1VlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 16:41:25 -0500
Received: by vws16 with SMTP id 16so1287425vws.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=tNfH0KlSK4thwh+E+ZJfh4cksigHH+dzjZFzyGtTRjI=;
        b=MQGCcLSnSWcozIyAL0oGHlmiZZwwm4ugRxLIuaO21KPfk9gxXQXkSGOdH/c2LQBEgn
         otrU/a6Yyc0BkoGoylYoKHWs7nUWRZ/tAsQVmvOXWiPPwMJe2oddndZJYwvefuRGtqoq
         A7DMC0HVTuwu3ldM7YgWqFnSyQmtF5RK0DHuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=a9Uu7ycEQTVDC4NQ9LVg31EdONfJ7j/r22HExJ5+LV0Jhiro/MO/wP6JBbw+JWlY0K
         Llzn6Y5DevSxemBfyelc0urPGpLBahNq6Yvp6hwtx64lX61qE9JE8KN+IYGzKJorxPeg
         RfsQai5sSSllFKJUQyLk/NoBYikjTXzryDc1E=
Received: by 10.220.71.81 with SMTP id g17mr697529vcj.184.1296250882003;
        Fri, 28 Jan 2011 13:41:22 -0800 (PST)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s6sm3657160vch.47.2011.01.28.13.41.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Jan 2011 13:41:20 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTimc92giAAJnzjv5Bq4f853xqEfLrgB=j+iRXPaf@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165642>

On Fri, 28 Jan 2011, Bert Wesarg wrote:

> On Fri, Jan 28, 2011 at 17:17, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > So 'git merge' is 'git merge @{upstream}' instead of 'git merge -h';
> > it's better to do something useful.
> 
> Nice idea. Could you have a look into git rebase, I think this could
> be applied there too.

I submitted an RFC patch for that a while ago [1]. I will soon send a
re-roll of some rebase refactoring patches I have been working on (I
have been busy at work and also waiting for 1.7.4 to be finished). I
will then send an updated "default upstream" patch again on top of the
refactoring patches.

And thanks for taking care of the merge case, Felipe. I'm still
struggling with the part of Git written in C, so I'm glad you took
that part.

> 
> Anyway, I think some high level sanity check won't harm. Ie. check if
> there is an upstream configured.

Will be done in the case of rebase at least (stolen from the
implementation in git pull).


[1] http://thread.gmane.org/gmane.comp.version-control.git/161382/
