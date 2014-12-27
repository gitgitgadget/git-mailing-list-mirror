From: "Philip Oakley" <philipoakley@iee.org>
Subject: Missing inversion in Makefile (ee9be06)
Date: Sat, 27 Dec 2014 18:49:05 -0000
Organization: OPDS
Message-ID: <E3DB9AD2A8914C379FB3371494B0B816@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=UTF-8; reply-type=original
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git MsysGit" <msysgit@googlegroups.com>
To: "Git List" <git@vger.kernel.org>
X-From: msysgit+bncBDSOTWHYX4PBBEX67OSAKGQEH3PZJ5I@googlegroups.com Sat Dec 27 19:48:55 2014
Return-path: <msysgit+bncBDSOTWHYX4PBBEX67OSAKGQEH3PZJ5I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDSOTWHYX4PBBEX67OSAKGQEH3PZJ5I@googlegroups.com>)
	id 1Y4wPz-0000MK-Pw
	for gcvm-msysgit@m.gmane.org; Sat, 27 Dec 2014 19:48:51 +0100
Received: by mail-la0-f63.google.com with SMTP id ms9sf1144001lab.28
        for <gcvm-msysgit@m.gmane.org>; Sat, 27 Dec 2014 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:reply-to:from:to:cc:subject:date:organization
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=/qqrxa7EVqTzQSlR5vyvR65yiJkF2ahXEderNiZjzoc=;
        b=AfKGfUI9hrZ5Y6Ir9ouqmReeew2u3ydZDwLPSlT6Sq7xiHwhsPGRthczRk7v7JvOju
         0kjCyUYa/jIFFYubYisDAIDjo0y+mpUe3Z2Yq5HAtKsfqPymorbTzm9W7dGXrF2pSs3V
         b5Vni0x+knoxPhcfAMUBouPuMw8Ii37DFxhlBtrtedMc36gNdqBXVjBXDbRIbciCEirq
         HgvbdyntVcL+atPjJKGkjGzNurgkC2Q8kjOQPWvUwarRNvK3w9HgcX+EJy5qgz+syw7Z
         IRPTeBOkPYFeL4uHUSR/47qlH3Fyh1CiX57BvxLfQALU18+u+f/4v2FktrHnEpzck/Qq
         WLig==
X-Received: by 10.152.27.38 with SMTP id q6mr65lag.24.1419706131477;
        Sat, 27 Dec 2014 10:48:51 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.205.38 with SMTP id ld6ls2011986lac.50.gmail; Sat, 27 Dec
 2014 10:48:49 -0800 (PST)
X-Received: by 10.152.37.193 with SMTP id a1mr279889lak.3.1419706129925;
        Sat, 27 Dec 2014 10:48:49 -0800 (PST)
Received: from out1.ip07ir2.opaltelecom.net (out1.ip07ir2.opaltelecom.net. [62.24.128.243])
        by gmr-mx.google.com with ESMTP id s6si170943wif.0.2014.12.27.10.48.49
        for <msysgit@googlegroups.com>;
        Sat, 27 Dec 2014 10:48:49 -0800 (PST)
Received-SPF: softfail (google.com: domain of transitioning philipoakley@iee.org does not designate 62.24.128.243 as permitted sender) client-ip=62.24.128.243;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjEyAG/+nlQCYJmQPGdsb2JhbABcgwUBAVGHc789EYU4MwQCgQgXAQEBAQEBBQEBAQE4IBuEBxQBAS4eAQEhCwIIAgEkOQEEGgYHAwYBExsCAQIDAYgfCakEjlWONQELARsEj3eDHYETBYkhhHRNgnKGQYoyhhGEED42gj4BAQE
X-IPAS-Result: AjEyAG/+nlQCYJmQPGdsb2JhbABcgwUBAVGHc789EYU4MwQCgQgXAQEBAQEBBQEBAQE4IBuEBxQBAS4eAQEhCwIIAgEkOQEEGgYHAwYBExsCAQIDAYgfCakEjlWONQELARsEj3eDHYETBYkhhHRNgnKGQYoyhhGEED42gj4BAQE
X-IronPort-AV: E=Sophos;i="5.07,652,1413241200"; 
   d="scan'208";a="125284120"
Received: from host-2-96-153-144.as13285.net (HELO PhilipOakley) ([2.96.153.144])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 27 Dec 2014 18:48:49 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Original-Sender: philipoakley@iee.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=softfail
 (google.com: domain of transitioning philipoakley@iee.org does not designate
 62.24.128.243 as permitted sender) smtp.mail=philipoakley@iee.org
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261837>

Hi,

In ee9be06 (perl: detect new files in MakeMaker builds, 2012-07-27) 
there is a step to detect if there has been an update to the PM.* files, 
however it appears that the logic is inverted in the comparison.

I need some extra eye's on this to be sure I have it right (I'm trying 
to debug an old Windows breakage...).

The resultant output of a make dry run included (on my m/c)..:

  find perl -type f -name '*.pm' | sort >perl/PM.stamp+ && \
   { cmp perl/PM.stamp+ perl/PM.stamp >/dev/null 2>/dev/null || mv 
perl/PM.stamp+ perl/PM.stamp; } && \
   rm -f perl/PM.stamp+
  make -C perl  PERL_PATH='/usr/bin/perl' prefix='/c/Documents and 
Settings/Philip' perl.mak

Shouldn't it be `{ ! cmp ` so that when the files are not identical, the 
move is performed?

https://github.com/git/git/blob/ee9be06770223238c6a22430eb874754dd22dfb0/Makefile#L2097

the code is now at https://github.com/git/git/blob/master/Makefile#L1697

I'd guess that this was something that was tricky to test as once it 
works it stays working.

On a clean Msysgit development install the PM.stamp file does not exist 
and the cmp exits with error code 2, while identical files return 0.

Msysgit list also copied should someone there have seen this before.
--
Philip 

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
