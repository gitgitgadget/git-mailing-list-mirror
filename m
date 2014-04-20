From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Mon, 21 Apr 2014 00:12:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404210011290.14982@s15462909.onlinehome-server.info>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com> <20140419184210.GB3617@book-mint> <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org, 
    msysGit Mailinglist <msysgit@googlegroups.com>, 
    Sebastian Schuberth <sschuberth@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: msysgit+bncBCZPH74Q5YNRBOMM2GNAKGQE6HZYZQY@googlegroups.com Mon Apr 21 00:12:09 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBOMM2GNAKGQE6HZYZQY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBOMM2GNAKGQE6HZYZQY@googlegroups.com>)
	id 1Wbzy5-00060Q-LN
	for gcvm-msysgit@m.gmane.org; Mon, 21 Apr 2014 00:12:09 +0200
Received: by mail-lb0-f187.google.com with SMTP id n15sf288843lbi.24
        for <gcvm-msysgit@m.gmane.org>; Sun, 20 Apr 2014 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=RXBdgpZMwDbCIN1jZBSmgXfeKlOS0YpxxeGdoPjVSLA=;
        b=Rr2kKNXbl+tM2MEMI3W6+SYqd/TJpbKiQYxvOqvKgTtLZjAIt99qiRPINHXWbiaQfY
         mAptf+f9nywg6BZvipW0vTQD2Rr966i+hW5QiwVkd3vdxQPZpHKC8EC5n+FnSNhjt/Cz
         JEW8SerAsuo4njsvDzpjtcFm74s+4UFhhdmB1Mjt1PW7XK0OYmzpIVb7U48YjhiXArpV
         t8L/4FrxmPdNp7Hd0Vh3ES/aJcZwqT6chFliwPEbIb3oCchsRbXOwJN5GdBvPnRPP/Wa
         wpd8QY1bdRHllwJfBwzd+PcNg9UARHpJy0x9/Xu42V1USoPERZ8bRfzL6OK8Y0cA7gig
         Zhhw==
X-Received: by 10.152.202.231 with SMTP id kl7mr408782lac.3.1398031929462;
        Sun, 20 Apr 2014 15:12:09 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.196 with SMTP id y4ls378585lal.64.gmail; Sun, 20 Apr
 2014 15:12:08 -0700 (PDT)
X-Received: by 10.112.133.66 with SMTP id pa2mr2307339lbb.3.1398031928591;
        Sun, 20 Apr 2014 15:12:08 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id u49si1250017eeo.1.2014.04.20.15.12.08
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA bits=256/256);
        Sun, 20 Apr 2014 15:12:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LdHeL-1XKRaY0qv3-00iTif;
 Mon, 21 Apr 2014 00:12:07 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1404210003540.14982@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:v+/4/IncPT10VDLNBOkEVQFkOJLorWhbLHLfO306OMf1g7Y6YYg
 IanZpwrIcKcV3yfR+JdkYFfQqWDF/QrwszdnvuqqvOdxol60kiuM54eemPQmMP9v0upD3Tp
 dDQi5/sQSukfLpeex5NApWlBSNDIYllxIylVWdoIAWmjRGkrAMjIbwVz/mYG/4tc4utJW9I
 zrkEoX+qrzabwCtyqXqeQ==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246595>

On Mon, 21 Apr 2014, Johannes Schindelin wrote:

> (I also would like to look into getting the performance improvement
> Hannes Sixt achieved by his patch [*1*] into mingwGitDevEnv's Git
> installation, too.)

Whoops. Footnote *1*: https://github.com/msysgit/msysgit/commit/a0f5d4f

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
