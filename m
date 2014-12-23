From: Pat Tressel <ptressel@myuw.net>
Subject: Re: Announcing Git for Windows 1.9.5
Date: Tue, 23 Dec 2014 01:48:24 -0800 (PST)
Message-ID: <0e0bcbf8-6e05-422d-ad4a-a85b1134947b@googlegroups.com>
References: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1794_1794496347.1419328104603"
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncBCAOFIF5SYARB2PU4SSAKGQEPS6363I@googlegroups.com Tue Dec 23 10:48:32 2014
Return-path: <msysgit+bncBCAOFIF5SYARB2PU4SSAKGQEPS6363I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f192.google.com ([209.85.220.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCAOFIF5SYARB2PU4SSAKGQEPS6363I@googlegroups.com>)
	id 1Y3M4p-0005xs-7G
	for gcvm-msysgit@m.gmane.org; Tue, 23 Dec 2014 10:48:27 +0100
Received: by mail-vc0-f192.google.com with SMTP id ij19sf866293vcb.29
        for <gcvm-msysgit@m.gmane.org>; Tue, 23 Dec 2014 01:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:x-original-sender:precedence:mailing-list
         :list-id:list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=0MdUUonvEPDhu/SU+ZkSh3got4gnuCME9I1a+AYaW6c=;
        b=IswN63TqCll8+f0e2sttVk+CY7UaOyze8iKq/2oeH41ezs2VZ1y/ainpmL9a1CLs8g
         QNdkSUmqnlTxZ/xP2DOPh2fGHUHNYTamM62CfubAxMk12mKIwXp7BDfrX1vFlf1NvhU3
         +5B3g7x+BjXm7iFd+XbCSwl/soLsbcsa8b86oZ6e06jpjfCu4IxI2yDAw8yZ2mhls+wI
         wovWlZE4M3NONAQj0GiE/dv6sPIfir0Vl/2lPPWntfdqyWoJGDVFgk4nVSRzSDoSPEnm
         Zf0v0M/kYEup1w7pzKGbJYnbKZ2IO7u6uS4l77NPlIwOShi4FU3lVH0peLfNizMftX6p
         79fA==
X-Received: by 10.50.129.98 with SMTP id nv2mr318928igb.1.1419328106298;
        Tue, 23 Dec 2014 01:48:26 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.46.4 with SMTP id r4ls1149728igm.29.canary; Tue, 23 Dec
 2014 01:48:25 -0800 (PST)
X-Received: by 10.50.128.202 with SMTP id nq10mr316794igb.12.1419328105743;
        Tue, 23 Dec 2014 01:48:25 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1412181143570.13845@s15462909.onlinehome-server.info>
X-Original-Sender: ptressel@myuw.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261721>

------=_Part_1794_1794496347.1419328104603
Content-Type: multipart/alternative; 
	boundary="----=_Part_1795_839765561.1419328104603"

------=_Part_1795_839765561.1419328104603
Content-Type: text/plain; charset=UTF-8



>         Bugfixes 
>         - Safeguards against bogus file names on NTFS (CVE-2014-9390). 
>

Apologies, but...is it possible to get back an old version?  I installed 
this version, and it no longer recognizes non-English characters that 
appear in some file names we have in our repo.  I'm only guessing that this 
has to do with the vuln fix.

(If you want, I can file a bug report -- this should be easy to reproduce, 
as all that's needed should be to clone our repo 
(https://github.com/flavour/eden) and do "git status" -- two files will 
appear as deleted, but they're not.  Hmm, it may be necessary to do the git 
clone with an old version, if the new version is unable to handle those 
file names.)

Thanks!

-- Pat

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

------=_Part_1795_839765561.1419328104603
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><blockquote class=3D"gmail_quote" style=3D"margin: 0;m=
argin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bugfixes
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Safeguards against bo=
gus file names on NTFS (CVE-2014-9390).
<br></blockquote><br>Apologies, but...is it possible to get back an old ver=
sion?&nbsp; I installed this version, and it no longer recognizes non-Engli=
sh characters that appear in some file names we have in our repo.&nbsp; I'm=
 only guessing that this has to do with the vuln fix.<br><br>(If you want, =
I can file a bug report -- this should be easy to reproduce, as all that's =
needed should be to clone our repo (https://github.com/flavour/eden) and do=
 "git status" -- two files will appear as deleted, but they're not.&nbsp; H=
mm, it may be necessary to do the git clone with an old version, if the new=
 version is unable to handle those file names.)<br><br>Thanks!<br><br>-- Pa=
t<br></div>

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

------=_Part_1795_839765561.1419328104603--
------=_Part_1794_1794496347.1419328104603--
