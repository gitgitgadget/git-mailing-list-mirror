From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2 0/2] improve-wincred-compatibility
Date: Tue, 26 Feb 2013 17:55:20 +0100
Message-ID: <CABPQNSZSv71_W6Y5rxo0nSBAemiiuTOyB=1Ag6txLy56BEbMFQ@mail.gmail.com>
References: <50E73B80.4070105@gmail.com> <CABPQNSYcOrOZJd0vK=4ESC4qPpcj7RRdhVt3R0dAE-ouhOb5YA@mail.gmail.com>
 <50EC473A.6060203@gmail.com> <CABPQNSb7MjTKgmeB9TcUV0+-FfjPZ1sgKPsfVDg6+uaw2f_azQ@mail.gmail.com>
 <50EEAF9A.6020302@gmail.com> <CABPQNSaUizZPVOeeuEyb=o-Qmm4mYCRxV27qkmp62cSpFkinqA@mail.gmail.com>
 <7vsj4k3nbu.fsf@alter.siamese.dyndns.org> <512BF61B.4020708@dcon.de> <7vip5gne96.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>, git@vger.kernel.org, msysgit@googlegroups.com, 
	Jeff King <peff@peff.net>, patthoyts@gmail.com, Johannes.Schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDR53PPJ7YHRBIOSWOEQKGQEACD3BAI@googlegroups.com Tue Feb 26 17:56:26 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBIOSWOEQKGQEACD3BAI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f58.google.com ([209.85.216.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBIOSWOEQKGQEACD3BAI@googlegroups.com>)
	id 1UANpH-0008Be-On
	for gcvm-msysgit@m.gmane.org; Tue, 26 Feb 2013 17:56:24 +0100
Received: by mail-qa0-f58.google.com with SMTP id g10sf2151638qah.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 26 Feb 2013 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=RWiuYVld46+LLS7xgtPtV2txDitVG8Xr/QWZlqq/Fjs=;
        b=evG4RC9nPaofZNKrEO+wONhRlhe1K6Eji4vtLK8xxQ/BDPVM0+QvAISrw7IF4PMJ65
         v3Jd9dhFb5U/YMjGSzstJNcFHmz9+uLVVd2hwwWRglXfknr2w/kN6fjcGWzlvJbCX12u
         TFjJK1F6oJCcCJ0piDCzzGUUNMTkrCRzhOw6QjMmnxH9q4apUB93qMcO52Jf+aCOx+BJ
         D7lqGRDbkGGIpNu/dr/RF93/vbRadQvr8ix1r4yH/22nkJagSvzBk6K20F1kFZ5tQs4Y
         nvYZtfWBxM++bpvEEU66f0To4XisdOZ2 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:x-beenthere:x-received:x-received:received-spf
         :x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=RWiuYVld46+LLS7xgtPtV2txDitVG8Xr/QWZlqq/Fjs=;
        b=GJykaRh+BHvg9UdJLoYxAwO3ZQXqdDhEUEyUpdHxKrvyxWft+rBsK0VPn+/vhEV5xE
         I6wxQz1uWiN0pQLXOlRlcuD0Jxc/qpTfXGxrFDUkBFdjI+GYDkB3wou2yqioBxzUSF6p
         KX1/z9da5GXyVV/IMpH7/GqWZLS6PQyQIqg1A2UX1dzgevVOBiHC36ivb0rEThWqRsOp
         wcO9USr2pDKr+OfE8ZIgV6IaYD4A1bgbOfAtMcTzH/EtspvgGAbomv0JXtD3SRUFxpeF
         DiY9AtVvCAOlJBjTJjJ50summGYTZRqpdFEomlU 
X-Received: by 10.50.87.198 with SMTP id ba6mr1705638igb.0.1361897762207;
        Tue, 26 Feb 2013 08:56:02 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.135.67 with SMTP id pq3ls587784igb.25.canary; Tue, 26 Feb
 2013 08:56:01 -0800 (PST)
X-Received: by 10.42.38.76 with SMTP id b12mr11934870ice.30.1361897761138;
        Tue, 26 Feb 2013 08:56:01 -0800 (PST)
X-Received: by 10.42.38.76 with SMTP id b12mr11934869ice.30.1361897761125;
        Tue, 26 Feb 2013 08:56:01 -0800 (PST)
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com [2607:f8b0:4001:c03::22d])
        by gmr-mx.google.com with ESMTPS id m3si179135iga.2.2013.02.26.08.56.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Feb 2013 08:56:01 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22d as permitted sender) client-ip=2607:f8b0:4001:c03::22d;
Received: by mail-ie0-x22d.google.com with SMTP id 9so4724889iec.18
        for <msysgit@googlegroups.com>; Tue, 26 Feb 2013 08:56:01 -0800 (PST)
X-Received: by 10.50.88.228 with SMTP id bj4mr5661384igb.85.1361897760943;
 Tue, 26 Feb 2013 08:56:00 -0800 (PST)
Received: by 10.64.48.193 with HTTP; Tue, 26 Feb 2013 08:55:20 -0800 (PST)
In-Reply-To: <7vip5gne96.fsf@alter.siamese.dyndns.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22d
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217147>

On Tue, Feb 26, 2013 at 12:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> My question was if msysgit folks
> want me to take your patch (which I cannot test myself) and then
> merge my tree to the msysgit tree as part of their regular updates
> to catch up with 1.8.2 (and future releases), or they want to test
> your patches in their tree first, and then either throw me a pull
> request or send me a patch series with Acked-by:.

The following changes since commit 4dac0679feaebbf6545daec14480cf6b94cb74ed:

  Git 1.8.2-rc1 (2013-02-25 09:03:26 -0800)

are available in the git repository at:

  git://github.com/kusma/git.git for-junio

for you to fetch changes up to 8b2d219a3d6db49c8c3c0a5b620af33d6a40a974:

  wincred: improve compatibility with windows versions (2013-02-26
17:42:46 +0100)

----------------------------------------------------------------
Karsten Blees (2):
      wincred: accept CRLF on stdin to simplify console usage
      wincred: improve compatibility with windows versions

 .../credential/wincred/git-credential-wincred.c    | 206 ++++++++-------------
 1 file changed, 75 insertions(+), 131 deletions(-)

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
For more options, visit https://groups.google.com/groups/opt_out.
