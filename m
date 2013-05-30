From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t0008-ignores failure
Date: Wed, 29 May 2013 19:21:51 -0700
Message-ID: <7vzjvdp5q8.fsf@alter.siamese.dyndns.org>
References: <CABNJ2G+u96P+_=Q7it0KbK9E01qunz7XZ7e3zCZvaTaOUuTQqQ@mail.gmail.com>
	<51A6A7B7.4010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Pat Thoyts <patthoyts@gmail.com>,  msysGit <msysgit@googlegroups.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Sebastian Schuberth <sschuberth@gmail.com>,  Git List <git@vger.kernel.org>,  Adam Spiers <git@adamspiers.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBQXPTKGQKGQEH2WDLYY@googlegroups.com Thu May 30 04:21:57 2013
Return-path: <msysgit+bncBCG77UMM3EJRBQXPTKGQKGQEH2WDLYY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f190.google.com ([209.85.220.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBQXPTKGQKGQEH2WDLYY@googlegroups.com>)
	id 1UhsV2-0001Rb-DX
	for gcvm-msysgit@m.gmane.org; Thu, 30 May 2013 04:21:56 +0200
Received: by mail-vc0-f190.google.com with SMTP id hf12sf3036236vcb.17
        for <gcvm-msysgit@m.gmane.org>; Wed, 29 May 2013 19:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=+0PEWf2oQ7EIoe3R/WGvoxh2E8kivHKtqwGO57uVx1A=;
        b=TG90uSMqKVOYaw2rZKfIBboHMQ5BsxA9iTOswvVKegHjNUJNazBUdH4vlM5bSkOHhB
         hPqW0wjpC3LO9T73SSQo/wm7zU8BJYkrf9MZ+j8tkbOO0E/LWJZTS7+gk1MEE+2SoP9x
         aEoRocc/TBj0pfApy1bKEs/zYbhT+EdyI99vW6tVE9x7G840LE4+PYse72eaWwg7HoLT
         Qo/9tCzah0Oft8kmf6TQhazcwdXf1x34082fOffCVQ9jWjzkL2vkhkSfWTlVA+PdBFnz
         iUMXzEk/tk7PytP7nvscVJViYIic9rUeeyrKOU3TVQKXBHaA/hR4ykDX+nqBKockyygh
         1C 
X-Received: by 10.50.12.4 with SMTP id u4mr829571igb.5.1369880515396;
        Wed, 29 May 2013 19:21:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.77.34 with SMTP id p2ls3796370igw.23.canary; Wed, 29 May
 2013 19:21:54 -0700 (PDT)
X-Received: by 10.66.197.229 with SMTP id ix5mr882810pac.23.1369880514174;
        Wed, 29 May 2013 19:21:54 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id sj3si5978446pab.1.2013.05.29.19.21.53
        for <msysgit@googlegroups.com>;
        Wed, 29 May 2013 19:21:53 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 533E41A009;
	Thu, 30 May 2013 02:21:53 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 458CA1A007;
	Thu, 30 May 2013 02:21:53 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3AA71A006;
	Thu, 30 May 2013 02:21:52 +0000 (UTC)
In-Reply-To: <51A6A7B7.4010802@gmail.com> (Karsten Blees's message of "Thu, 30
	May 2013 03:13:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0FC9680-C8CF-11E2-8F34-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225908>

Karsten Blees <karsten.blees@gmail.com> writes:

> I realize colon was chosen to mimic git-check-attr, however,
> check-attr prints relative paths only (I think?).
>
> How about using TAB or '|' instead? AFAICT, these are typically
> not used in paths or glob patterns.

The primary reason to use ':' in "check-ignore -v" is to mimic the
output format of "grep -n".

Emacs users can then run the commands like check-attr/check-ignore
with "M-x find-grep" (or "M-x compile"), the output format is
recognized by the editor, and the user can jump around with \C-x` to
view hits.

I do not use vim myself, but I would be mildly surprised if there
isn't a similar feature there.

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
For more options, visit https://groups.google.com/groups/opt_out.
