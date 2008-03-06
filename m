From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The 8th airing of the msysGit herald
Date: Wed, 05 Mar 2008 16:41:59 -0800
Message-ID: <7vskz4heeg.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site> <m34pbok54h.fsf@localhost.localdomain> <alpine.LSU.1.00.0803030052450.22527@racer.site> <200803030210.02223.jnareb@gmail.com> <47CBE85B.6060702@imap.cc> <7vablfiv42.fsf@gitster.siamese.dyndns.org> <47CC432B.8060502@imap.cc> <7v1w6rh1ru.fsf@gitster.siamese.dyndns.org> <46a038f90803031458t2b404212t10f6e9ae710dc408@mail.gmail.com> <47CF2F61.5060208@imap.cc> <alpine.LSU.1.00.0803060121360.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tilman Schmidt <tilman@imap.cc>,  Martin Langhoff <martin.langhoff@gmail.com>,  Jakub Narebski <jnareb@gmail.com>,  msysgit@googlegroups.com,  git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Mar 06 01:42:59 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from ug-out-1516.google.com ([66.249.92.163])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX4CI-0000b0-Ry
	for gcvm-msysgit@m.gmane.org; Thu, 06 Mar 2008 01:42:58 +0100
Received: by ug-out-1516.google.com with SMTP id 1so3101067uga.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Mar 2008 16:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=nQCeOPNTTu0jo1ZOUdRThR3V9e/R4rJXwbXhaR9i/6w=;
        b=LysTVKP1+T5YZP6i3kp0uXd6cKHQaQPrhFLGKl9CCAzwYD9Vhc9ev16QNMNITzkuvohUHJMkjZk7JxICBuFUsPCPPBg/zFXZ2zXST4DgODhXNOKaClDcQBPkDcUu0eehrVtuehfVouRu1NJVoFRxA4nbmfe+OEp47YpDJgfXDaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=hEu01o47aEC4QsmcijdTyMkd1y5x9to0zYJIOjTtf3jvEpawpgvqK4buvo+tPUrOkrB40Bz5tXULBxjMq8GY8+C/lZrwfu6v8nQmqehGLMfuNXvpj5MuGgzQc8ReG+tG2SAygYGhUW0mAMLtgMQQfibCzRprxbjM/y0E5NQc/wE=
Received: by 10.141.98.13 with SMTP id a13mr125143rvm.22.1204764141325;
        Wed, 05 Mar 2008 16:42:21 -0800 (PST)
Received: by 10.107.119.35 with SMTP id w35gr1918prm.0;
	Wed, 05 Mar 2008 16:42:21 -0800 (PST)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.179.1 with SMTP id b1mr1631272waf.4.1204764139924; Wed, 05 Mar 2008 16:42:19 -0800 (PST)
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com [207.106.133.19]) by mx.google.com with ESMTP id v36si4944321wah.3.2008.03.05.16.42.18; Wed, 05 Mar 2008 16:42:19 -0800 (PST)
Received-SPF: pass (google.com: domain of gitster@pobox.com designates 207.106.133.19 as permitted sender) client-ip=207.106.133.19;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of gitster@pobox.com designates 207.106.133.19 as permitted sender) smtp.mail=gitster@pobox.com
Received: from localhost.localdomain (localhost [127.0.0.1]) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 62D6133E0; Wed,  5 Mar 2008 19:42:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CBEA33D9; Wed,  5 Mar 2008 19:42:07 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803060121360.15786@racer.site> (Johannes Schindelin's message of "Thu, 6 Mar 2008 01:26:58 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76302>


Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 6 Mar 2008, Tilman Schmidt wrote:
>
>> would it be possible to have separate mailing lists for usage topics and 
>> for discussions of ongoing development? I imagine that might help those 
>> who just want to use git (like me) to find their way around.
>
> AFAIAC you can have your "users-only" mailing list.  Personally, I will 
> never look at it, though, since all I am interested in is the development 
> of Git.  If that holds true for the majority of Git _developers_, it might 
> even be a bad idea to have a separate users' list, since then
>
> - no ideas from strictly-users would flow to the developers, and
>
> - new developments would not reach you, and
>
> - you would not get help by the people knowing the internals _deeply_.

Personally, I suspect I would end up subscribing to both, but
two mailing lists would make it much more cumbersome than
necessary to correlate the original user "itch" request that
triggered an enhancement, the discussion that clarified the
design constraints and requirements, and the patch and the
review comments that lead to the final implementation,
especially if you do not encourage cross posting to both lists.
And of course cross posting will make user-only list more
technical which would defeat the original point of having two
lists.

"users-only" list could probably created by readers' MUA, by
picking emails that do not have "diff --git" in its body; that
would probably be a good enough approximation for people who are
not interested in the technical discussions.
