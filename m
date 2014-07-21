From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] t4210: skip command-line encoding tests on mingw
Date: Mon, 21 Jul 2014 13:07:24 -0700
Message-ID: <xmqqoawiiigz.fsf@gitster.dls.corp.google.com>
References: <20140716092959.GA378@ucw.cz>
	<1405611425-10009-1-git-send-email-kasal@ucw.cz>
	<1405611425-10009-5-git-send-email-kasal@ucw.cz>
	<CABPQNSaiogqGryK8YOzQXs_z_syvXMBqvOpvGfMNdbLkNzRq_w@mail.gmail.com>
	<xmqqvbqqk5qu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  Karsten Blees <karsten.blees@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,  GIT Mailing-list <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: kusmabite@gmail.com
X-From: msysgit+bncBCG77UMM3EJRBBHGWWPAKGQERJGUAEQ@googlegroups.com Mon Jul 21 22:07:35 2014
Return-path: <msysgit+bncBCG77UMM3EJRBBHGWWPAKGQERJGUAEQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f191.google.com ([209.85.220.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBBHGWWPAKGQERJGUAEQ@googlegroups.com>)
	id 1X9Jrx-0005DM-VZ
	for gcvm-msysgit@m.gmane.org; Mon, 21 Jul 2014 22:07:34 +0200
Received: by mail-vc0-f191.google.com with SMTP id lf12sf2218595vcb.8
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Jul 2014 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=tUGmw/16+Vyvhx/Ep0H6qC4lKM/ZDl3npFzXEgzLMcQ=;
        b=l9yvz2Qxpjcu6EmnO3I0V5Unui3LQdqE/E0J4rQm4hJ1l7iwMssWIE6Np360LUq4lU
         /fAmKlAEr0J/NGsJsIEFUqS0DYl8hiFja8K7BBydVFmLl7eQuzANfAmyO/6dEz7LGB7C
         Cni/oSH02w9lTxNfoq2xXg8fvv4zkcD6+TfK4KSjIUqJS3CbBJZEjzZSVcUDlATzx+8H
         ApEQO19xV+t93uebfeFQsn33MdOyifubZJJ8R+beMqoDnO8zF/woFcnWF7qSzX7Yxir9
         jh+rry+DUQbT+07NqwSHceJDrPpBZnihdvJSbW4SOqTFJCwna/30PlsVdozfXeiih1Tf
         NJtw==
X-Received: by 10.50.18.105 with SMTP id v9mr129722igd.17.1405973253202;
        Mon, 21 Jul 2014 13:07:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.27.104 with SMTP id s8ls1789404igg.22.gmail; Mon, 21 Jul
 2014 13:07:32 -0700 (PDT)
X-Received: by 10.66.66.196 with SMTP id h4mr13452139pat.22.1405973252514;
        Mon, 21 Jul 2014 13:07:32 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id p3si1116059yho.7.2014.07.21.13.07.32
        for <msysgit@googlegroups.com>;
        Mon, 21 Jul 2014 13:07:32 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 168DF2B56F;
	Mon, 21 Jul 2014 16:07:32 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0CF372B56E;
	Mon, 21 Jul 2014 16:07:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 28EFE2B564;
	Mon, 21 Jul 2014 16:07:26 -0400 (EDT)
In-Reply-To: <xmqqvbqqk5qu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 21 Jul 2014 09:59:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A2907C24-1112-11E4-8D26-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253991>

Junio C Hamano <gitster@pobox.com> writes:

> Oh by the way, can somebody remind me why we spell these as
> NOT_MINGW,  instead of !MINGW?

Simple answer seems to be that !ANYTHING appeared only at bdccd3c1
(test-lib: allow negation of prerequisites, 2012-11-14) but at that
version already 5 test files use NOT_MINGW (and a few MINGW) as
prerequisites.  We can safely replace uses of NOT_MINGW prerequisite
with !MINGW, it seems.

Sorry for the noise.


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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
