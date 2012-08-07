From: =?UTF-8?Q?jbialobr?= <jbialobr@o2.pl>
Subject: Re: Re: Re: Re: File path not escaped in warning message
Date: Tue, 07 Aug 2012 10:20:23 +0200
Message-ID: <3bc6610e.6355e5e2.5020cfc7.c1687@o2.pl>
References: <2783325c.512962ce.501f69dd.5711e@o2.pl> <OF9C260C14.7F8DC09D-ONC1257A52.005D3AD5-C1257A52.005F222E@dcon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: gitster@pobox.com,
	msysgit@googlegroups.com
To: git@vger.kernel.org,
	=?UTF-8?Q?Junio_C_Hamano?=<gitster@pobox.com>
X-From: msysgit+bncCOXE2IOTBRDJn4OBBRoEq8Giug@googlegroups.com Tue Aug 07 10:20:26 2012
Return-path: <msysgit+bncCOXE2IOTBRDJn4OBBRoEq8Giug@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f186.google.com ([74.125.82.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOXE2IOTBRDJn4OBBRoEq8Giug@googlegroups.com>)
	id 1Syf1d-0003ro-Qt
	for gcvm-msysgit@m.gmane.org; Tue, 07 Aug 2012 10:20:25 +0200
Received: by weyr1 with SMTP id r1sf1538191wey.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 07 Aug 2012 01:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:subject:from:to:cc:in-reply-to:references
         :mime-version:message-id:date:x-originator:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=jS8o733LrwmCQ5LL+25oqbOHdfVwgWZNsbZ+dYjZpn8=;
        b=pz4WuFHAzwONYkaCYf2fuR/g4jorHt/HS0PTR3o7dszYwCY7sL4eyGkAsETmuHwATD
         LqIDH4yGvH23i25awiV6jktj0ZaAi3HxbVS2UiyZlB0vIsOe/Dl0CIgOPv6IN8ZeVp8b
         jb5/PEWVg6Anli3PKppi5dmmd8WnxSJcjBMog=
Received: by 10.180.87.229 with SMTP id bb5mr856418wib.0.1344327625107;
        Tue, 07 Aug 2012 01:20:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.212.2 with SMTP id x2ls191880weo.2.gmail; Tue, 07 Aug 2012
 01:20:24 -0700 (PDT)
Received: by 10.180.24.165 with SMTP id v5mr1612820wif.1.1344327624089;
        Tue, 07 Aug 2012 01:20:24 -0700 (PDT)
Received: by 10.180.24.165 with SMTP id v5mr1612819wif.1.1344327624080;
        Tue, 07 Aug 2012 01:20:24 -0700 (PDT)
Received: from moh2-ve3.go2.pl (moh2-ve3.go2.pl. [193.17.41.208])
        by gmr-mx.google.com with ESMTP id cx9si2406894wib.0.2012.08.07.01.20.24;
        Tue, 07 Aug 2012 01:20:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of jbialobr@o2.pl designates 193.17.41.208 as permitted sender) client-ip=193.17.41.208;
Received: from moh2-ve3.go2.pl (unknown [10.0.0.208])
	by moh2-ve3.go2.pl (Postfix) with ESMTP id D4BF44802B;
	Tue,  7 Aug 2012 10:20:23 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.146])
	by moh2-ve3.go2.pl (Postfix) with SMTP;
	Tue,  7 Aug 2012 10:20:23 +0200 (CEST)
In-Reply-To: <OF9C260C14.7F8DC09D-ONC1257A52.005D3AD5-C1257A52.005F222E@dcon.de>
X-Originator: 89.206.14.43
X-Original-Sender: jbialobr@o2.pl
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of jbialobr@o2.pl designates 193.17.41.208 as permitted sender) smtp.mail=jbialobr@o2.pl
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203023>

Hi Karsten,

Thanks, you helped me a lot. I see now, that logoutputencoding=20
is for commit header data, not for whole log output. The name
is little missleading, so do description:
i18n.logOutputEncoding
   Encoding to use when displaying logs.

Regarding git-log / git-diff output, there are basically three different

character set encodings involved:
1. commit log messages: re-coded to i18n.logoutputencoding (usually
UTF-8)

also commiter and author fields.

2. file content: printed verbatim (no re-coding); gui tools such as gitk

may decode this based on gui.encoding or .gitattributes settings
3. everything else (file names, diff headers, error / warning messages):

always UTF-8 (at least in Git for Windows)

It is more like git encoding than UTF-8.=20


Gui tools such as gitk decode this output line by line using the=20
appropriate encoding.

It would be easier to do it if output was displayed in consistent way. I
see no reason why one part of output is quoted and other is not. Another
example:

$ git status
warning: LF will be replaced by CRLF in 1=C4=85.txt.
The file will have its original line endings in your working directory.
# On branch master
# Your branch and 'origin/master' have diverged,
# and have 2 and 2 different commit(s) each, respectively.
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   "1\261.txt"
#

Git doesn't recode commit header when --pretty is set to format,
but recodes when --pretty is set to full, raw, etc. Do you know if it is
done by mistake or by design?

Thanks again,
Janusz Bia=C5=82obrzewski.


--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
