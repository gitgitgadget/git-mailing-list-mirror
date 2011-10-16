From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 7/8] mergetools: use the correct tool for Beyond
 Compare 3 on Windows
Date: Sun, 16 Oct 2011 12:21:54 +0200
Message-ID: <CAHGBnuP_piC5J9MxcME5SwbDtiuQHOmh7A3kfiAfVMpD8+zcPg@mail.gmail.com>
References: <1318632815-29945-1-git-send-email-patthoyts@users.sourceforge.net>
	<1318632815-29945-8-git-send-email-patthoyts@users.sourceforge.net>
	<7vobxix0pk.fsf@alter.siamese.dyndns.org>
	<4E996012.8090002@gmail.com>
	<87fwiuig41.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: msysgit+bncCPLFkNe0FhDD4Or0BBoEufg4iA@googlegroups.com Sun Oct 16 12:22:26 2011
Return-path: <msysgit+bncCPLFkNe0FhDD4Or0BBoEufg4iA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qw0-f58.google.com ([209.85.216.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCPLFkNe0FhDD4Or0BBoEufg4iA@googlegroups.com>)
	id 1RFNrN-0003Vx-UU
	for gcvm-msysgit@m.gmane.org; Sun, 16 Oct 2011 12:22:26 +0200
Received: by qadb40 with SMTP id b40sf2890035qad.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 16 Oct 2011 03:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=e/VXtd7kk/HDHKYArnQ1HxL3YcRDtOe8wFrMDJGSR6M=;
        b=R0leg2vWSPDQRpULNllj2LFAMPGx4PDK58UBFtqqAcswLNQWDo/8L0IYYLE0HYglgc
         QToIuNXmgJw/Af2L+XHa++FmeBgPs5jZ8NLA38JUDIgbkXpbwE4KMnCg8uWBRuyDQ+iH
         ZrtF17jQdl/+pzfv5Co3xOX1FXDhlHAMRg9yE=
Received: by 10.224.187.203 with SMTP id cx11mr2746470qab.13.1318760515688;
        Sun, 16 Oct 2011 03:21:55 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.188.201 with SMTP id db9ls9568716qab.7.gmail; Sun, 16 Oct
 2011 03:21:55 -0700 (PDT)
Received: by 10.224.180.210 with SMTP id bv18mr9742143qab.3.1318760515174;
        Sun, 16 Oct 2011 03:21:55 -0700 (PDT)
Received: by 10.224.180.210 with SMTP id bv18mr9742141qab.3.1318760515166;
        Sun, 16 Oct 2011 03:21:55 -0700 (PDT)
Received: from mail-vx0-f176.google.com (mail-vx0-f176.google.com [209.85.220.176])
        by gmr-mx.google.com with ESMTPS id j6si5325588qct.1.2011.10.16.03.21.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Oct 2011 03:21:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 209.85.220.176 as permitted sender) client-ip=209.85.220.176;
Received: by vcdn13 with SMTP id n13so1944331vcd.21
        for <msysgit@googlegroups.com>; Sun, 16 Oct 2011 03:21:54 -0700 (PDT)
Received: by 10.220.152.193 with SMTP id h1mr1097821vcw.270.1318760514943;
 Sun, 16 Oct 2011 03:21:54 -0700 (PDT)
Received: by 10.220.188.69 with HTTP; Sun, 16 Oct 2011 03:21:54 -0700 (PDT)
In-Reply-To: <87fwiuig41.fsf@fox.patthoyts.tk>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of sschuberth@gmail.com designates 209.85.220.176 as permitted sender)
 smtp.mail=sschuberth@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183702>

On Sat, Oct 15, 2011 at 14:39, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:

> And checking the linux distribution shows only a bcompare executable so
> testing for the presence of 'bcomp' will be fine.

I was meaning to say the same thing, sorry for not being more clear. I
also checked the Linux version of BC3 and verified that there's only a
"bcompare" executable.

-- 
Sebastian Schuberth
