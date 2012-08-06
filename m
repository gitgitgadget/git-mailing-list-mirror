From: =?UTF-8?Q?jbialobr?= <jbialobr@o2.pl>
Subject: Re: Re: File path not escaped in warning message
Date: Mon, 06 Aug 2012 08:53:17 +0200
Message-ID: <2783325c.512962ce.501f69dd.5711e@o2.pl>
References: <501D1BB5.6020200@o2.pl> <7v39429u58.fsf@alter.siamese.dyndns.org> <501E616E.6000907@o2.pl> <7v1ujl3ysi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com,
	git@vger.kernel.org
To: =?UTF-8?Q?Junio_C_Hamano?=<gitster@pobox.com>
X-From: msysgit+bncCOXE2IOTBRDf0_2ABRoEneH1_Q@googlegroups.com Mon Aug 06 08:53:21 2012
Return-path: <msysgit+bncCOXE2IOTBRDf0_2ABRoEneH1_Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ey0-f186.google.com ([209.85.215.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOXE2IOTBRDf0_2ABRoEneH1_Q@googlegroups.com>)
	id 1SyHBo-0002B5-7K
	for gcvm-msysgit@m.gmane.org; Mon, 06 Aug 2012 08:53:20 +0200
Received: by eaai13 with SMTP id i13sf1097409eaa.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 05 Aug 2012 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:subject:from:to:cc:in-reply-to:references
         :mime-version:message-id:date:x-originator:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=X7Kmwec/HY8vYAJ3bAnXEt6y5sGTHltusMaWYb7NLX8=;
        b=oXmqaVQXGDgkGOLqGT5tu+eYcxr+JsrAF3rGjKlJKnxakGNJ2IU2rky61uND9Z/6/+
         wuGjcc4oytUT9Mds96ml788vpjBVMeyWm4IJw5aiBTO8ax7ySrVxvZRYrNd4bo2APIDn
         kWviHH68jMRJAlRWbsA90OiD5oVkIOIVfWLCQ=
Received: by 10.180.96.129 with SMTP id ds1mr347083wib.2.1344235999427;
        Sun, 05 Aug 2012 23:53:19 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.212.2 with SMTP id x2ls5729252weo.2.gmail; Sun, 05 Aug
 2012 23:53:18 -0700 (PDT)
Received: by 10.216.192.22 with SMTP id h22mr493200wen.10.1344235998396;
        Sun, 05 Aug 2012 23:53:18 -0700 (PDT)
Received: by 10.216.192.22 with SMTP id h22mr493199wen.10.1344235998380;
        Sun, 05 Aug 2012 23:53:18 -0700 (PDT)
Received: from moh1-ve1.go2.pl (moh1-ve1.go2.pl. [193.17.41.131])
        by gmr-mx.google.com with ESMTP id em7si1612332wib.2.2012.08.05.23.53.18;
        Sun, 05 Aug 2012 23:53:18 -0700 (PDT)
Received-SPF: pass (google.com: domain of jbialobr@o2.pl designates 193.17.41.131 as permitted sender) client-ip=193.17.41.131;
Received: from moh1-ve1.go2.pl (unknown [10.0.0.131])
	by moh1-ve1.go2.pl (Postfix) with ESMTP id 22157928823;
	Mon,  6 Aug 2012 08:53:18 +0200 (CEST)
Received: from o2.pl (unknown [10.0.0.121])
	by moh1-ve1.go2.pl (Postfix) with SMTP;
	Mon,  6 Aug 2012 08:53:18 +0200 (CEST)
In-Reply-To: <7v1ujl3ysi.fsf@alter.siamese.dyndns.org>
X-Originator: 89.206.14.43
X-Original-Sender: jbialobr@o2.pl
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of jbialobr@o2.pl designates 193.17.41.131 as permitted sender) smtp.mail=jbialobr@o2.pl
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202958>

There is nothing said in the manual, that core.quotepath affects only heade=
r. But it is not the point. You don't know which part of git output will be=
 consumed by machine. Warning message is addressed to human, but it can be =
consumed by program in the same way as all other messages and output data.
Imho, since warning comes from git, path should be quoted to
make git behaviour consistent.=20
From git-log help:
> Note that we deliberately chose not to re-code the commit log message whe=
n a commit is made to force UTF-8 at the commit object level, because re-co=
ding to UTF-8 is not necessarily a reversible operation.

If re-coding from one encoding to other is not necessarily a reversible ope=
ration, and you can set logoutputencoding to any encoding you wish, you may=
 loose some charatcers while recoding file path in warning message. Quoting=
 it would be desired then.

Janusz Bia=B3obrzewski.

---- Wiadomo=B6=E6 Oryginalna ----
Od: Junio C Hamano <gitster@pobox.com>
Do: Janusz Bia=B3obrzewski <jbialobr@o2.pl>
Kopia do: msysgit@googlegroups.com,  git@vger.kernel.org
Data: 5 sierpnia 2012 21:48
Temat: Re: File path not escaped in warning message

> Janusz Bia=B3obrzewski <jbialobr@o2.pl> writes:
>=20
> > Here is output from linux:
> >
> > [janusz@mikrus JavaCommon]$ git config --add core.quotepath false
> > [janusz@mikrus JavaCommon]$ git diff  --unified=3D3 -- "1=B1.txt"
> > warning: LF will be replaced by CRLF in 1<B1>.txt.
> > The file will have its original line endings in your working directory.
>=20
> I do not know offhand if the literal <B1> is the byte value you want
> or not, but core.quotepath should not affect it.
>=20
> The configuration is primarily about quoting paths that appear in
> the header part in the diff output for machine readability.  In this
> output,
>=20
> > diff --git a/1<B1>.txt b/1<B1>.txt
> > index 281ad6f..9444a66 100644
> > --- a/1<B1>.txt
> > +++ b/1<B1>.txt
>=20
> the paths are not quoted because quotepath is set to false, but in
> the next example, it
>=20
> > ...
> > [janusz@mikrus JavaCommon]$ git config --unset core.quotepath
> > [janusz@mikrus JavaCommon]$ git config --add core.quotepath true
> > [janusz@mikrus JavaCommon]$ git diff  --unified=3D3 -- "1=B1.txt"
> > warning: LF will be replaced by CRLF in 1<B1>.txt.
> > The file will have its original line endings in your working directory.
> > diff --git "a/1\261.txt" "b/1\261.txt"
> > index 281ad6f..9444a66 100644
> > --- "a/1\261.txt"
> > +++ "b/1\261.txt"
>=20
> is quoted due to the configuration setting.
>=20
> Again, <B1> in the warning message is not affected, as the quotepath
> configuration is not meant to affect messages that are meant for
> human consumption.

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
