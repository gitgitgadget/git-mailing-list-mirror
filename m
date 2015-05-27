From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Release candidate of Git for Windows 2.x is out
Date: Thu, 28 May 2015 00:11:30 +0200
Organization: gmx
Message-ID: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
 git-for-windows@googlegroups.com
X-From: msysgit+bncBCZPH74Q5YNRBFUCTGVQKGQED66WHGA@googlegroups.com Thu May 28 00:11:37 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBFUCTGVQKGQED66WHGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBFUCTGVQKGQED66WHGA@googlegroups.com>)
	id 1YxjXz-0000NX-Jz
	for gcvm-msysgit@m.gmane.org; Thu, 28 May 2015 00:11:35 +0200
Received: by wibbw19 with SMTP id bw19sf10725227wib.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 27 May 2015 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to
         :subject:organization:message-id:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=QCWgdn8LKAlm3BBs3FQWVGgwMgRgOJR0TwCSrKkI3Yk=;
        b=U9CM6ovDqss3pmsg/nDmCVPAfwO19kqrTJS+rurnFM+edj8ewJbc4XWqBH1OYKKMqX
         4mQmRQO7TK+A38MH4Koy/9xhftHUU5JEyYnBqDTmoSSiWABP1mXeAhVghsW2taIm2EAm
         3iLJJZKI6dzX1YEnCuW2DU0/v4c3lPAa6vM07Nj3sQtcoO5v5+3YSlVi+PjYm66PP/0S
         kAKa+xKNxd3k7/8QzGsxBHXZ+25Dk3tENUBO4D6CAiXKLS0q/H5q34mLzhEIErsVuDqk
         8GZ8KIEex4dOG67qwkbznxYqDVA8ll2hWxTN6RqnXHuwhuF33JixXhhqmG9W6dfmPPFe
         X1kg==
X-Received: by 10.152.29.166 with SMTP id l6mr377718lah.25.1432764695256;
        Wed, 27 May 2015 15:11:35 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.120.71 with SMTP id la7ls116919lab.25.gmail; Wed, 27 May
 2015 15:11:33 -0700 (PDT)
X-Received: by 10.112.93.203 with SMTP id cw11mr33986952lbb.0.1432764693979;
        Wed, 27 May 2015 15:11:33 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id t6si766393wiz.0.2015.05.27.15.11.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 15:11:33 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LnwxU-1Zdh8M3oeu-00fx41; Thu, 28 May 2015 00:11:30
 +0200
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:x2R+wxG0oZfvC0LFH7P5Iyqtd3qPK7/ukUTdMZE8eZvlbpoMRM4
 Va3HEL2k5CKXVMZDQNrFiRO4gHjplVAHxCuvHBmKQPfQMBjFurYNXFgWtNchhn+iNUxpYXe
 Ck5n4toDmssumixnFGdZj/P7cljfDw1RfiwSxo5g2LQrr+cLF3dgt5NSyCfZGQPrqCdGYYG
 BDLlBwQ5PKC0sK08/YjoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WKHWwssp0ms=:Q6qsY+UPsvnaKDNLPyTDXp
 hp68YQJluURDs6iQGugtCPdAdEMmNaV7+uVQuY4q/02QY27NFH7wZ2a3Xe9IUFBMgDo51Jl+V
 Zj+GxbPC6Z/eqG6v6CqeC6n7ST2RAM1j6O+e01a5YgNfrTdiRbpX1mPdTXZlBmjK7To6hv39+
 oOqefwotdpPFu9zZsAFT1o3rwnaqDKXzzhlbla7DyHVb3UomPIOulO/ULSotnTXBqkKls0pto
 IkmbUVjCgcyucj6tm0BeRitjbiW618qtbUr/Vurs5/BSHV1L6kMmw8VSwyaSIlgaOuO8PuzhW
 mHozzsPcRDsU9DNU1V9VN0k2SoAp7o6ojkg6O2aKlHjfEHYsn9SpeZRSJNUiRY0jqMchiNr/1
 y5Bs8HjnQ3F3bsC6ZMVbh9zXXDHkDPU1sC49IlmgOE0wI6NUUtnmFYT7Mf7hIESljmrJBMeV+
 7JCtq1gLNIAgyXF991O0P9PO19jYHCBDRp66m8GPhAsOiMDUWpfrCDMrTG8axQ25c+rM3mDtc
 gX4XEq4y+oTKqwFUBG9FXT8blH/oCfZaL1Jn/lHL/sYOzTbCZGc1pUga8RK2cqOah0hcQNYLV
 X+TzTFSH/usLAUi1Ggjigh2JH+I9SOnjFAqnYmiyywvgnO2h5UV1WuIvHZpdzuruuwAUXLASR
 Vbut0Txxmrq0tfhhzbkaZMUf4v3JK/VUNL1iY659+/VHlFZkNvlbGcqwSeHu7hohs50M=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270108>

Hi all,

I just uploaded release candidates for the upcoming Git for Windows 2.x rel=
ease. Please find the download link here:

https://git-for-windows.github.io/#download

There are 32-bit and 64-bit versions both of regular installers and portabl=
e installers ("portable" meaning that they are .7z archives that can be unp=
acked anywhere and run in place, without any need for running an installer)=
.

My projected time line is to hammer out the last kinks until Friday, and th=
en continue after a one-week leave, if needed, and then finally retire msys=
Git and start the official 2.x release cycle of Git for Windows.

If you are running Windows and have a little time to spare, please test thi=
s release candidate thoroughly. If you find bugs, please first look at http=
s://github.com/git-for-windows/git/issues (even the closed ones), and comme=
nt either on existing tickets or open new ones. It would be even cooler, of=
 course, if you could open Pull Requests with fixes :-)

Ciao,
Johannes

--=20
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

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
