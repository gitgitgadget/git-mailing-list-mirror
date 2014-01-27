From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How to get notified of new releases?
Date: Mon, 27 Jan 2014 08:38:33 -0800
Message-ID: <20140127163833.GD27577@google.com>
References: <CAHd499C-BJJA6oPd5UcOqL8m8xGeL5GoAMtfF90AdKVvayTc7g@mail.gmail.com>
 <1316300317.564216.1390810770505.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>,
	msysgit@googlegroups.com
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: msysgit+bncBD6LRKOE4AIRBD4XTKLQKGQEZZJ5YOQ@googlegroups.com Mon Jan 27 17:38:41 2014
Return-path: <msysgit+bncBD6LRKOE4AIRBD4XTKLQKGQEZZJ5YOQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f191.google.com ([74.125.82.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBD4XTKLQKGQEZZJ5YOQ@googlegroups.com>)
	id 1W7pCr-0007QL-2P
	for gcvm-msysgit@m.gmane.org; Mon, 27 Jan 2014 17:38:41 +0100
Received: by mail-we0-f191.google.com with SMTP id u57sf932090wes.18
        for <gcvm-msysgit@m.gmane.org>; Mon, 27 Jan 2014 08:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=lleG4R937x4d8qrBNs4IME/tCYvKOoyKKAONpR/AAwE=;
        b=ayXK8VhmVSmcO2Ft6n8DetfCjMSU7xBBBCvFgBZwvKuPLSlMm9Su58gsPZqMuy8Jsp
         RcyoQxoYkozjsEH/YrUZ5g6U+G8HEKSVQrawh1EN+I3Ykt2/na6gkNLMBoPAaPjv+uUu
         YtCrUlMSTN6yYweiMZJsAYXV+dWaJ8VG4B+7YMnj0/vDguibXRQr76neGxp0ib6uGpF9
         1vTrd62EMN2gkxkx0tRuv2LHndp8eZpi8Cvl1yspyrWx9KpSDqNSaITJTmPKVAjY71ff
         qC7PzNzfGVG80hQEmMBCR1cm6J6o2JnefMHYzsZpg/5EVuI/17w4akU6c867gQ4yBJCv
         +a/Q==
X-Received: by 10.152.19.98 with SMTP id d2mr67199lae.19.1390840720565;
        Mon, 27 Jan 2014 08:38:40 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.45.6 with SMTP id i6ls358584lam.106.gmail; Mon, 27 Jan
 2014 08:38:39 -0800 (PST)
X-Received: by 10.112.185.6 with SMTP id ey6mr4411002lbc.22.1390840719361;
        Mon, 27 Jan 2014 08:38:39 -0800 (PST)
Received: from mail-bk0-x22f.google.com (mail-bk0-x22f.google.com [2a00:1450:4008:c01::22f])
        by gmr-mx.google.com with ESMTPS id th6si1076511bkb.1.2014.01.27.08.38.39
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 08:38:39 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2a00:1450:4008:c01::22f as permitted sender) client-ip=2a00:1450:4008:c01::22f;
Received: by mail-bk0-f47.google.com with SMTP id d7so2914346bkh.6
        for <msysgit@googlegroups.com>; Mon, 27 Jan 2014 08:38:39 -0800 (PST)
X-Received: by 10.204.51.8 with SMTP id b8mr23178283bkg.19.1390840719211;
        Mon, 27 Jan 2014 08:38:39 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dg4sm14009364bkc.10.2014.01.27.08.38.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jan 2014 08:38:38 -0800 (PST)
In-Reply-To: <1316300317.564216.1390810770505.JavaMail.zimbra@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2a00:1450:4008:c01::22f
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241147>

Matthieu Moy wrote:
> Robert Dailey wrote:

>> Are there any dedicated mailing lists for git releases, or RSS feeds?
>
> Not sure if there's a Windows-dedicated list, but there's this:
>
>   http://gitrss.q42.co.uk/
>
> It filters the mailing-list posts starting with eg. [ANNOUNCE] and turns it into an RSS feed.

There's also https://github.com/msysgit/msysgit/commits/master.atom,
though that might be more activity than you're looking for (it would
be the feed to follow if you want to build your own snapshots of git
on Windows and try every change).

Perhaps https://github.com/msysgit/msysgit/tags.atom would do the
trick.

Jonathan

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
