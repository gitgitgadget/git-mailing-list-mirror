From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Mon, 21 Apr 2014 13:56:41 -0500
Message-ID: <535569e92cbcc_32c48493101f@nysa.notmuch>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
 <20140419184210.GB3617@book-mint>
 <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info>
 <53556579.3050709@gmail.com>
 <alpine.DEB.1.00.1404212053420.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>, 
 Marat Radchenko <marat@slonopotamus.org>, 
 git@vger.kernel.org, 
 msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBDBJVMGGZYNBBWGY2WNAKGQEP3TFENY@googlegroups.com Mon Apr 21 21:07:06 2014
Return-path: <msysgit+bncBDBJVMGGZYNBBWGY2WNAKGQEP3TFENY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f55.google.com ([209.85.213.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBBWGY2WNAKGQEP3TFENY@googlegroups.com>)
	id 1WcJYX-0000BE-W7
	for gcvm-msysgit@m.gmane.org; Mon, 21 Apr 2014 21:07:06 +0200
Received: by mail-yh0-f55.google.com with SMTP id f10sf1260272yha.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Apr 2014 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=A/6YrBz5X4DHtJpHiGJKGyqtfa8a4S7BB68bmPMBipo=;
        b=GeKuzu5qd/xBGbt1dcIH63zfZxGkWplCW1JArMrERWrxrd15j46tHk2XTnqDceOBii
         rQGzRplM64N5pbxiHBKAhb/pGQrq+XeVM8HtuizcSCVxemNlLUNXR8nuetcakfv9YKdo
         fPjHb9i5syTThUgWe6zFxDoOR7kp4mjehdWKMcmQoPblqRgLDBbzZqs6/gF++wFzzijc
         3I09VQwQhYckM4W9nrh95DAWJ6VWxd7bQXzi5AEpGyYMiSvsRTtsIH9z0I7/5gd+sGeA
         +nki6sEQsInnVOfUvJXcSt8O28HoVUxNoSEalUWGxgWh5U+BBPQzlkxUNC+gdR+J+Jp3
         cxlg==
X-Received: by 10.140.36.6 with SMTP id o6mr41163qgo.26.1398107224788;
        Mon, 21 Apr 2014 12:07:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.19.115 with SMTP id 106ls2519248qgg.75.gmail; Mon, 21 Apr
 2014 12:07:04 -0700 (PDT)
X-Received: by 10.236.141.11 with SMTP id f11mr19488755yhj.54.1398107224381;
        Mon, 21 Apr 2014 12:07:04 -0700 (PDT)
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com [2607:f8b0:4002:c07::231])
        by gmr-mx.google.com with ESMTPS id y50si1814845yhk.4.2014.04.21.12.07.04
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 12:07:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 2607:f8b0:4002:c07::231 as permitted sender) client-ip=2607:f8b0:4002:c07::231;
Received: by mail-yk0-f177.google.com with SMTP id q200so3719136ykb.36
        for <msysgit@googlegroups.com>; Mon, 21 Apr 2014 12:07:04 -0700 (PDT)
X-Received: by 10.236.142.204 with SMTP id i52mr54417000yhj.6.1398107224283;
        Mon, 21 Apr 2014 12:07:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id m26sm42537641yha.5.2014.04.21.12.07.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 12:07:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1404212053420.14982@s15462909.onlinehome-server.info>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of felipe.contreras@gmail.com designates
 2607:f8b0:4002:c07::231 as permitted sender) smtp.mail=felipe.contreras@gmail.com;
       dkim=pass header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246621>

Johannes Schindelin wrote:
> Now, clearly you have all the motivation that is needed to get 64-bit
> builds of Git for Windows going, and all the motivation required to make
> sure that the MSVC support of the msysGit project works.

s/msysGit/Git/

Personally I don't see why ideally I shouldn't be able to build upstream Git
for Windows with mingw without leaving my Linux system.

-- 
Felipe Contreras

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
