From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Missing inversion in Makefile (ee9be06)
Date: Sat, 27 Dec 2014 20:07:01 +0100
Message-ID: <549F0355.5020805@kdbg.org>
References: <E3DB9AD2A8914C379FB3371494B0B816@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>, Junio C Hamano <gitster@pobox.com>, 
 Git MsysGit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>, Git List <git@vger.kernel.org>
X-From: msysgit+bncBCJYV6HBKQINRBX4UQCRUBA76HR6Q@googlegroups.com Sat Dec 27 20:07:07 2014
Return-path: <msysgit+bncBCJYV6HBKQINRBX4UQCRUBA76HR6Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQINRBX4UQCRUBA76HR6Q@googlegroups.com>)
	id 1Y4whe-0001Wi-Td
	for gcvm-msysgit@m.gmane.org; Sat, 27 Dec 2014 20:07:06 +0100
Received: by mail-la0-f63.google.com with SMTP id ms9sf1103478lab.18
        for <gcvm-msysgit@m.gmane.org>; Sat, 27 Dec 2014 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=uVMAkqrTdLLhNf7L9khT4ioDnmYZ5kpSb1n8KCWji3Q=;
        b=y5DaWLwEGs2IqqrT4Eyw1oOOJ9YGdr8E0q5U1fcSOdKev1l+i8VAMV5TvU5I5bquEa
         J/Y9VY40/7iF91kam/1FXZYmSMlpSRZZDhHwnuF+5fW4thDTVRx6zGnWQyoSXkKhWw8Q
         vCZxg9mbrDWsqtf2IFflXPRdY8AOvKA+4Jt+y9luAVIGDg/0JmmkwtnCaHziw2jK6rJt
         0+1acNNitLTB2fVYhzG3IQ5/TyT2Rlhc0C8tNN03+XfRzEF1R3Cu5ZkoarcPvkEjsTbz
         2a9IiqBJ91kxsaUaQfknr7mhXsl/LAJqnaXcfTGCt/ApFi0b7Ka1liOTpsda7JPHHbOi
         lOtA==
X-Received: by 10.152.2.169 with SMTP id 9mr661689lav.1.1419707226637;
        Sat, 27 Dec 2014 11:07:06 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.23.71 with SMTP id k7ls1394553laf.9.gmail; Sat, 27 Dec
 2014 11:07:04 -0800 (PST)
X-Received: by 10.112.141.98 with SMTP id rn2mr2873350lbb.2.1419707224172;
        Sat, 27 Dec 2014 11:07:04 -0800 (PST)
Received: from bsmtp.bon.at (bsmtp7.bon.at. [213.33.87.19])
        by gmr-mx.google.com with ESMTPS id d18si100822wiv.0.2014.12.27.11.07.04
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Dec 2014 11:07:04 -0800 (PST)
Received-SPF: none (google.com: j6t@kdbg.org does not designate permitted sender hosts) client-ip=213.33.87.19;
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3k8vdz00Gjz5tlB;
	Sat, 27 Dec 2014 20:07:02 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E08CC19F7D7;
	Sat, 27 Dec 2014 20:07:01 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <E3DB9AD2A8914C379FB3371494B0B816@PhilipOakley>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=none
 (google.com: j6t@kdbg.org does not designate permitted sender hosts) smtp.mail=j6t@kdbg.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261838>

Am 27.12.2014 um 19:49 schrieb Philip Oakley:
> Hi,
> 
> In ee9be06 (perl: detect new files in MakeMaker builds, 2012-07-27)
> there is a step to detect if there has been an update to the PM.* files,
> however it appears that the logic is inverted in the comparison.
> 
> I need some extra eye's on this to be sure I have it right (I'm trying
> to debug an old Windows breakage...).
> 
> The resultant output of a make dry run included (on my m/c)..:
> 
>  find perl -type f -name '*.pm' | sort >perl/PM.stamp+ && \
>   { cmp perl/PM.stamp+ perl/PM.stamp >/dev/null 2>/dev/null || mv
> perl/PM.stamp+ perl/PM.stamp; } && \
>   rm -f perl/PM.stamp+
>  make -C perl  PERL_PATH='/usr/bin/perl' prefix='/c/Documents and
> Settings/Philip' perl.mak
> 
> Shouldn't it be `{ ! cmp ` so that when the files are not identical, the
> move is performed?
> 
> https://github.com/git/git/blob/ee9be06770223238c6a22430eb874754dd22dfb0/Makefile#L2097

The existing code looks correct to me. cmp succeeds when the files are
identical and fails when they are different: When it succeeds (files are
equal), the mv is not executed. When it fails, either because a file
does not exist or they are different, the mv is executed.

-- Hannes

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
