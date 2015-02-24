From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Tue, 24 Feb 2015 13:02:54 -0800
Message-ID: <xmqqwq37owe9.fsf@gitster.dls.corp.google.com>
References: <20150218191417.GA7767@peff.net> <20150218193234.GA8298@peff.net>
	<5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
	<vpqioerz03s.fsf@anie.imag.fr>
	<CAPc5daXTLRZW-uk++ZjbtafbR6SB41dyc0Cu1gN=Qy7CEhOq-A@mail.gmail.com>
	<c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,  Jeff King <peff@peff.net>,  Git Mailing List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBCG77UMM3EJRBBGOWOTQKGQEOB5NBHA@googlegroups.com Tue Feb 24 22:03:02 2015
Return-path: <msysgit+bncBCG77UMM3EJRBBGOWOTQKGQEOB5NBHA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f192.google.com ([209.85.216.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBBGOWOTQKGQEOB5NBHA@googlegroups.com>)
	id 1YQMdB-0001FK-P5
	for gcvm-msysgit@m.gmane.org; Tue, 24 Feb 2015 22:03:01 +0100
Received: by qcwb13 with SMTP id b13sf6103309qcw.6
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Feb 2015 13:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=rb8cdo338V+SGTdxsHRf+kNS9tqwa2HCfF1szjYjD9Y=;
        b=CVqVLvZ48MarrEAS+fNt9UdWObvjWlmzHgVB0vJHEHeLjZsbN93S86aaUGvUSvCAlN
         6tuUoAL/0Ixaq2Ni0iO8oNUieWGjSXCXioClIcFOkTb+HXR+mUXbGfVFgPI0u5iSnIzA
         qxMrCJxeTAPvZnPtisykzmCkA4i5Cj3oksmBloPnkyhp6CW1Q4OSu0FmeSv67pZDS9M1
         v7+WS7MjrT2QVWLQXiAV1k+8Mw1WsPCHKU8vWzsVp6rxT2ln9ED6eCqg3dDyByvBvZed
         ZgwQkj8q0bGEm73U6KXnApO4fMVXgw/5ic3B5GMqUZ7bNid5OhmJYNAq2+ViNKBRzfpT
         CNlA==
X-Received: by 10.50.60.71 with SMTP id f7mr317285igr.10.1424811781111;
        Tue, 24 Feb 2015 13:03:01 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.107.164.93 with SMTP id n90ls1930240ioe.7.gmail; Tue, 24 Feb
 2015 13:03:00 -0800 (PST)
X-Received: by 10.68.241.163 with SMTP id wj3mr3467562pbc.8.1424811780333;
        Tue, 24 Feb 2015 13:03:00 -0800 (PST)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ba9si6638910qcb.0.2015.02.24.13.03.00
        for <msysgit@googlegroups.com>;
        Tue, 24 Feb 2015 13:03:00 -0800 (PST)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2FDB3AFA5;
	Tue, 24 Feb 2015 16:02:59 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D89C93AFA4;
	Tue, 24 Feb 2015 16:02:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D9413AF9B;
	Tue, 24 Feb 2015 16:02:56 -0500 (EST)
In-Reply-To: <c9ff859363d2d637b3607aaf6cb9295d@www.dscho.org> (Johannes
	Schindelin's message of "Tue, 24 Feb 2015 21:33:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8163C036-BC68-11E4-BB7A-A4119F42C9D4-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264346>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> Also drop "proper" as if scripted Porcelains are second class citizens ;-)
>
> If you had to deal with the portability/performance issues of the
> shell scripts I am frequently faced with, you would not call them
> first class citizens, either.

Perhaps that might be the case.

But I am polite enough to refrain from calling that "not a problem
on 'proper' platforms".  I expect the same courtesy from others ;-).

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
