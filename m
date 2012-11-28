From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 28 Nov 2012 03:09:12 +0100
Message-ID: <CAMP44s0UZ2yTKLkp51p9zqO4Quv9_WGO07P20eYeQesgXHxn3Q@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CACsJy8BbUjrJtfpEvbcK==Y2gFNsFhFBN93CL36J5uVe=Ca4wQ@mail.gmail.com>
	<20121125051809.GA3670@thyrsus.com>
	<CAMP44s0r1J=aOuEpKQ1+ew9FzODwLX-w5z9rG-WN6AjU0o97yw@mail.gmail.com>
	<20121125095429.GB22279@thyrsus.com>
	<CAMP44s1cG=5D9DppHmB9CpgkgdEzM72KhQ1Q-kWrrDo8ST+r_g@mail.gmail.com>
	<20121125175051.GD32394@thyrsus.com>
	<CAMP44s3QNG-sxcZsWmL3RYjXkzOwerj2774t7Abh04A7QR6TCA@mail.gmail.com>
	<20121125215635.GA6937@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org, 
	msysGit <msysgit@googlegroups.com>
To: esr@thyrsus.com
X-From: msysgit+bncBDBJVMGGZYNBBSHE2WCQKGQEPLNDUCA@googlegroups.com Wed Nov 28 03:09:27 2012
Return-path: <msysgit+bncBDBJVMGGZYNBBSHE2WCQKGQEPLNDUCA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f186.google.com ([209.85.220.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDBJVMGGZYNBBSHE2WCQKGQEPLNDUCA@googlegroups.com>)
	id 1TdX5a-0003cq-38
	for gcvm-msysgit@m.gmane.org; Wed, 28 Nov 2012 03:09:26 +0100
Received: by mail-vc0-f186.google.com with SMTP id fl17sf3575499vcb.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 27 Nov 2012 18:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=aaTsJ/umMik+//tmE3c7APSQiGswXV87hmf3bztgB6o=;
        b=thNPVHimI3WZlib+pcCxy1zWs6s+5efNiCdiD0wgQezucmlRNGWc3uKfkgP4k+KSZC
         tLIKwMdRAJNyCR7fz4oLg2MM8jmNfAhamlXEHjsYzubdDyMAzEWlaI3GjNYyXBFMrB48
         RhZH61FVpwAZUTjptT+TQwjbKdZZOwVctJCknv0LOGZBrzlhJJXw5ZVUx9m8QA3PWyLh
         VHax4ws6Yui6CHvduUqg7+ZYPA0Uf6CThCwkIUfB4R9uimPrcwfv+/tnWETSKYesbHMK
         I6h6/yBeJiRX/lc37IJzwwg/sXM417QsIVcDFY0NYe9+yqwo+HimupTA/2dcQ8fzcbfT
         HRJA==
Received: by 10.50.37.232 with SMTP id b8mr6585605igk.4.1354068554274;
        Tue, 27 Nov 2012 18:09:14 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.53.173 with SMTP id c13ls3885593igp.38.gmail; Tue, 27 Nov
 2012 18:09:12 -0800 (PST)
Received: by 10.42.55.66 with SMTP id u2mr12486794icg.33.1354068552772;
        Tue, 27 Nov 2012 18:09:12 -0800 (PST)
Received: by 10.42.55.66 with SMTP id u2mr12486793icg.33.1354068552761;
        Tue, 27 Nov 2012 18:09:12 -0800 (PST)
Received: from mail-oa0-f46.google.com (mail-oa0-f46.google.com [209.85.219.46])
        by gmr-mx.google.com with ESMTPS id ul6si346442igb.2.2012.11.27.18.09.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Nov 2012 18:09:12 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 209.85.219.46 as permitted sender) client-ip=209.85.219.46;
Received: by mail-oa0-f46.google.com with SMTP id h16so15408669oag.33
        for <msysgit@googlegroups.com>; Tue, 27 Nov 2012 18:09:12 -0800 (PST)
Received: by 10.182.21.175 with SMTP id w15mr1579744obe.28.1354068552502; Tue,
 27 Nov 2012 18:09:12 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 18:09:12 -0800 (PST)
In-Reply-To: <20121125215635.GA6937@thyrsus.com>
X-Original-Sender: felipe.contreras@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of felipe.contreras@gmail.com designates 209.85.219.46 as permitted
 sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210669>

On Sun, Nov 25, 2012 at 10:56 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com>:
>> And gitk is an integral part of git. But if you have different
>> numbers, what are they?

> Please don't waste further time on quibbling.  We all know that gitk is
> an uncomfortable special case and that the project would be far better
> off, maintainability-wise, if it were successfully ported to one if these
> other languages.  Trying to catch me out by triumphantly pointing at gitk
> is...juvenile.

Another bit of information I just realized, 'man git' lists gitk as a
'Main porcelain command' as high level as any git command can get.

-- 
Felipe Contreras

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
