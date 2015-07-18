From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: 5th release candidate of Git for Windows 2.x, was Re: 4th
 release candidate of Git for Windows 2.x
Date: Sat, 18 Jul 2015 20:48:46 +0200
Organization: gmx
Message-ID: <4956050f57cf294d404d3abe9ed1c53b@www.dscho.org>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
 <8224736a18724f751312d57e67967d69@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
 git-for-windows@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRBE57VKWQKGQECRARPBY@googlegroups.com Sat Jul 18 20:48:53 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBE57VKWQKGQECRARPBY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBE57VKWQKGQECRARPBY@googlegroups.com>)
	id 1ZGXAL-0000Ur-8M
	for gcvm-msysgit@m.gmane.org; Sat, 18 Jul 2015 20:48:53 +0200
Received: by wilh8 with SMTP id h8sf26891237wil.0
        for <gcvm-msysgit@m.gmane.org>; Sat, 18 Jul 2015 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:date:from:to:subject:organization
         :in-reply-to:references:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=LJjVamrd+T/+0XlCQPMzYycE/6Bw6uqMFINvr8m1seg=;
        b=JwHtaEKSpi+J78EJCY+Qe/gpybHs8bWb/iBrBoe2pasge864y1ziZsaQSq7hX53UID
         GiMEdsiPtpUVV9dfzIvClzcvrpO+bzD5SJ55CIbYuTA1XwBKW7Je214Dg24vSNUSS69G
         cn8StmqXtEATSnzzqpDfSHfYn+Cxxf7t/OHTT1iFVIFP0VMrUIECe52VZsa3/dkIVHJT
         c/ZY7uDw1LR/YUFrFoolBjUYmyUHH2CPRSyCjG1GOXtG4RS2el0XF1z7XIRel1KNh2YM
         Ax+ReZNr8PqxhNOagtnp1JuPbR2S8OyIL3pUqfkNqDDjuF7sFAgAaKMkOz45UrlPVr1y
         CgcA==
X-Received: by 10.180.206.84 with SMTP id lm20mr17309wic.13.1437245332863;
        Sat, 18 Jul 2015 11:48:52 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.95.201 with SMTP id dm9ls554424wib.41.gmail; Sat, 18 Jul
 2015 11:48:51 -0700 (PDT)
X-Received: by 10.180.205.202 with SMTP id li10mr1978376wic.5.1437245331406;
        Sat, 18 Jul 2015 11:48:51 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id c3si126395wiz.2.2015.07.18.11.48.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2015 11:48:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MgKoE-1Zd7zC0AHG-00NeaF; Sat, 18 Jul 2015 20:48:48
 +0200
In-Reply-To: <8224736a18724f751312d57e67967d69@www.dscho.org>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:vQ/eL4AXk7lnqOIgVdBklvCjDrmSHI63hgAqJ2Cd9VSWtjXQfUV
 T16daSoSw55x43tJvXuFbarHj/O8Z/pfn6wLuxrAZlvjHmJLEWWkpemStkGXO6XLd4lw0M8
 tQFPr6/8sF4/qXR3pWxVJE70YOdVaLOdO34lKG94+T/I7DzA4O97e9WGQBicQVCTnVYQN1w
 TYtRw2bEFeQYIACyQmxqw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AYfOi6jwHyY=:E71VFT3GEXQE7ildJDH30Y
 u2Az91rtVhhRaS9Nq45Axws+9BqbQW3dvOuyJsZtlxZ+GZ078UvqLpB7uiIlvkHyHjMZ5oq4f
 nFaRxu6xIRYKewHQbWvRBzYfYBq/uyVQ72SN+LKT3OWwi839wdLY576/FfDDstEaYgnCXJJ8l
 P6ldREMRPdQhgNjgWfvQeGSVNr8hn3RURVZ0OCy8twDhzeJvOE7/udK0DPcM69x8vWjNyoJx0
 Xpo5Pj+LSrnx+gQgQbmVjRSWXh6UwTp1E++3mrkioPxjIshU6A7WFS/sw1sZct8zMOGWCJy6j
 6U//rv0//0SeQEPw0zWYR4Zpt/1yFGms7afDLnDfZqmbHtUAld5pMllLG9CvzU5xmMA5CTTmj
 LRorbCe2QU/pyDGQGpJpYplLz85L2s0XO56WZG9i/x/5JJtV2OfPS3xcXXrH8cJl1xkYUdcxx
 p74YOvZJ3x+GCYgFJaeFgRlq1Mkm3+WUMaVo1l52kMiu9Layefn+l67Ymo902W68V+kgz+0a+
 OL+Rm1Z0BDR3XcFHlV531HrsyR8Z6NKN/45CTf7wi/H7asOF6BFc8SVVUn4HybK09zHFq6ITP
 oBkxxWglmiTVNx+2x34yIlhxlAChdcLGQuxoFnLzR8H7OEChg5fXwGQMh/bXlt8r15H6SVfBW
 aW+kA278HfUlkVPYMezQozsEyAZFc2Z0csxDYy2dZ/0Wy5KZJM9SblGjNR4J/SjaH5hE=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274167>

Hi all,

I just uploaded the 5th release candidate for the upcoming Git for
Windows 2.x release. Please find the download link here:
 
https://git-for-windows.github.io/#download



Apart from synchronizing with Git 2.4.6, this version brings the following fixes:

*   Git for Windows handles symlinks now, even if core.symlinks does not tell Git to generate symlinks itself.
*   git svn learned not to reuse incompatible on-disk caches left over from previous Git for Windows versions.

Please find the release notes here:

https://github.com/git-for-windows/build-extra/blob/master/installer/ReleaseNotes.md

There is at least one bigger issue I still want to address, therefore there will most likely be another release candidate soon, but I simply did not want to force the fans to wait for 2.4.6 and the two bug fixes.

Ciao,
Johannes

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
