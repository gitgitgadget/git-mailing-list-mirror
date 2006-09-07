From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Thu, 07 Sep 2006 09:53:50 +0200
Message-ID: <44FFD00E.5040305@innova-card.com>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>	<44FED12E.7010409@innova-card.com>	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com> <7v1wqo400b.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Sep 07 09:54:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLEhx-0002Zz-GK
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 09:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWIGHxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 03:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWIGHxr
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 03:53:47 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:55426 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751075AbWIGHxr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 03:53:47 -0400
Received: by py-out-1112.google.com with SMTP id n25so202790pyg
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 00:53:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=VG8uRfAOZ2Glbl39J8FMdaChUEh6IOMIm9JUTX9Zg9nJYVisP4XaMej2VXYXS/0bzupIoKaDk2FrgZgDiSWJDItvSazT1f9LMMc5taA2A4cd+5uNQv/ooQ18/wdVAorCUpY+WqKLDCUjYXqhRjAZJpxf4REAZcLDKDULDUobh4c=
Received: by 10.65.114.11 with SMTP id r11mr242232qbm;
        Thu, 07 Sep 2006 00:53:46 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id f18sm322294qba.2006.09.07.00.53.43;
        Thu, 07 Sep 2006 00:53:45 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wqo400b.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26611>

Junio C Hamano wrote:
> "Franck Bui-Huu" <vagabon.xyz@gmail.com> writes:
>> These alias would be internal to git (always defined)
> 
> You _could_ work things around by building special cases into
> the system, but I would rather avoid doing that unless
> necessary.
> 

yes that was not a great idea...

> Is there a reason that "git-upload-archive --format=tar" is not
> desirable at this point of the code?
> 

My first intention was to enable/disable specific archive format
through daemon service. But we could in an other way: send a 
"git-upload-archive --format=tar" request then in upload-archive
check that git-upload-tar service is enabled. This service would
exist even if git-upload-tar is not a valid command.

But Rene thinks that part should be in git-upload-archive. I dunno
what is the best direction. I have used git-daemon service because
the service infrastucture already allow us to achieve that.

I'm sorry to not make things faster. I'm new to git internals and
unfortunately I'm busy to do some other (crap) things. I'll send
a new patchset this morning and I'll sum up what's done and what
we still need to do.

Thanks
		Franck
