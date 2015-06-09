From: Qb <tholag@gmail.com>
Subject: Re: Release candidate of Git for Windows 2.x is out
Date: Tue, 9 Jun 2015 01:43:24 -0700 (PDT)
Message-ID: <aa3467c7-bf83-4ccb-be64-929b944806ba@googlegroups.com>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_154_130913683.1433839404421"
Cc: git-for-windows@googlegroups.com, git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBDOKBSUU7UKRB5OO3KVQKGQEKRYKSVY@googlegroups.com Tue Jun 09 10:44:48 2015
Return-path: <msysgit+bncBDOKBSUU7UKRB5OO3KVQKGQEKRYKSVY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f190.google.com ([209.85.223.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDOKBSUU7UKRB5OO3KVQKGQEKRYKSVY@googlegroups.com>)
	id 1Z2F9C-0003Q0-8C
	for gcvm-msysgit@m.gmane.org; Tue, 09 Jun 2015 10:44:38 +0200
Received: by ierx19 with SMTP id x19sf3847149ier.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 09 Jun 2015 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=2VGjQ2uILbbylC+gpLG8UFCNwqJhXWlp3vmVsdcFGBs=;
        b=GZkOK/6u13aBCJ/O/41mX4Q2bweaSsX7ejEZLRP7E2K5ydyDMnj4o0QCLAsZQEJuAR
         WvLToaoqQnsPnvJwk9+owTpqWOwiV7/rnqZZV2+eHYvYPUmSrezBJUPurPkDydbVFOrQ
         0qfgBRHSLTBcVmjnfwfT3lj2raSmR0mxg6sofXdSOauHfvIt15m2ij2yAYMlR+KLxGsY
         8XpsA/Z1ieInHEWiVCqMUtPdqgCnInMBv6Wjf5U2GAw+bqlJH6nsql2PUs1kc+i76pcw
         jrR6fwH2fCnbkw5LgW19A7rfOiTu5s9n/sfu6ToFbUkcFCa0g6v2wdcDHbVxJAybv+Sx
         XTQQ==
X-Received: by 10.50.79.137 with SMTP id j9mr255073igx.15.1433839477439;
        Tue, 09 Jun 2015 01:44:37 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.66.147 with SMTP id f19ls1392073igt.43.canary; Tue, 09 Jun
 2015 01:44:37 -0700 (PDT)
X-Received: by 10.70.96.41 with SMTP id dp9mr29114207pdb.13.1433839477075;
        Tue, 09 Jun 2015 01:44:37 -0700 (PDT)
Received: by 10.50.225.2 with SMTP id rg2msigc;
        Tue, 9 Jun 2015 01:43:24 -0700 (PDT)
X-Received: by 10.140.18.194 with SMTP id 60mr245242qgf.12.1433839404602;
        Tue, 09 Jun 2015 01:43:24 -0700 (PDT)
In-Reply-To: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
X-Original-Sender: tholag@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271153>

------=_Part_154_130913683.1433839404421
Content-Type: multipart/alternative; 
	boundary="----=_Part_155_1243015653.1433839404421"

------=_Part_155_1243015653.1433839404421
Content-Type: text/plain; charset=UTF-8

Dear Johannes,
I'm trying the release candidate on Win 8.1. Everything's working now, but 
when I clone a repository

git clone http://...../name.git CustomFolder

it creates CustomFolder with the checkout files, but the .git folder is 
created inside CustomFolder\CustomFolder\

Dir layout
\
\CustomFolder
\CustomFolder\files.....
\CustomFolder\CustomFolder\.git  <---- wrong additional level
 
so any other command doesn't work because it cannot find the .git folder.
If I move the CustomFolder\CustomFolder\.git to CustomFolder\.git 
everything works correctly.

Let me know if it's enough data,
Qb

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

------=_Part_155_1243015653.1433839404421
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Johannes,<br>I'm trying the release candidate on Win =
8.1. Everything's working now, but when I clone a repository<br><br>git clo=
ne http://...../name.git CustomFolder<br><br>it creates CustomFolder with t=
he checkout files, but the .git folder is created inside CustomFolder\Custo=
mFolder\<br><br>Dir layout<br>\<br>\CustomFolder<br>\CustomFolder\files....=
.<br>\CustomFolder\CustomFolder\.git&nbsp; &lt;---- wrong additional level<=
br>&nbsp;<br>so any other command doesn't work because it cannot find the .=
git folder.<br>If I move the CustomFolder\CustomFolder\.git to CustomFolder=
\.git everything works correctly.<br><br>Let me know if it's enough data,<b=
r>Qb<br></div>

<p></p>

-- <br />
-- <br />
*** Please reply-to-all at all times ***<br />
*** (do not pretend to know who is subscribed and who is not) ***<br />
*** Please avoid top-posting. ***<br />
The msysGit Wiki is here: <a href=3D"https://github.com/msysgit/msysgit/wik=
i">https://github.com/msysgit/msysgit/wiki</a> - Github accounts are free.<=
br />
&nbsp;<br />
You received this message because you are subscribed to the Google<br />
Groups &quot;msysGit&quot; group.<br />
To post to this group, send email to msysgit@googlegroups.com<br />
To unsubscribe from this group, send email to<br />
msysgit+unsubscribe@googlegroups.com<br />
For more options, and view previous threads, visit this group at<br />
<a href=3D"http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den">http:=
//groups.google.com/group/msysgit?hl=3Den_US?hl=3Den</a><br />
<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;Git for Windows&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:msysgit+unsubscribe@googlegroups.com">msysgit+uns=
ubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_155_1243015653.1433839404421--
------=_Part_154_130913683.1433839404421--
