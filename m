From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: 4th release candidate of Git for Windows 2.x, was Re:
 3rd release candidate of Git for Windows 2.x
Date: Mon, 29 Jun 2015 18:54:30 +0300
Message-ID: <20150629185430.5dfbab069b5dbdf32398d290@domain007.com>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
	<b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
	<8224736a18724f751312d57e67967d69@www.dscho.org>
	<55910AE7.3000206@atlas-elektronik.com>
	<426859781bd04ca4ebb13719350537ed@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan =?UTF-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
        Git
 Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
        git-for-windows@googlegroups.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBCWKX34CSUCBBSGUYWWAKGQE26D7LWQ@googlegroups.com Mon Jun 29 17:54:49 2015
Return-path: <msysgit+bncBCWKX34CSUCBBSGUYWWAKGQE26D7LWQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f60.google.com ([74.125.82.60])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCWKX34CSUCBBSGUYWWAKGQE26D7LWQ@googlegroups.com>)
	id 1Z9bOS-0003fU-UI
	for gcvm-msysgit@m.gmane.org; Mon, 29 Jun 2015 17:54:49 +0200
Received: by wggx12 with SMTP id x12sf47564654wgg.1
        for <gcvm-msysgit@m.gmane.org>; Mon, 29 Jun 2015 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=b6kshRcmdX7Dl0/zwgZMMRZjryhCF9kSeGkzhmUUxTY=;
        b=m8dk2+Yh9jx5wE2D7QuFBqg4aiJE8kaoSyNII17GWtuiXxbEDMR5VBwHuDNXDLOuAX
         1EjcUWlQcQc7NlvfjnL3U2aZte1zbuiPcm1P8HpnJdgbL8RSD6I7Zrj7C6+oMldu7hhq
         y6mPzRIrmeKW2vo296kbgH91wDt5i/mmI+qOX32I/qwcIvapneRNpbTEV/foPcSt2X3u
         dauQy0GC5L4rxMYBBcyB0yLRMJ0gP/FsM6dQKL8MFgCpJse267SQuwSs6xw3vFCl1Id4
         mlTbgr1NF35XsHfgVx8KGKEgAyBccDZN6U2AXmMf5SmcPJZdWgEnYaN329yuWpTW0FR/
         9DZQ==
X-Received: by 10.152.23.167 with SMTP id n7mr131604laf.36.1435593288587;
        Mon, 29 Jun 2015 08:54:48 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.115.204 with SMTP id jq12ls96071lab.4.gmail; Mon, 29 Jun
 2015 08:54:47 -0700 (PDT)
X-Received: by 10.112.200.163 with SMTP id jt3mr11209152lbc.17.1435593287448;
        Mon, 29 Jun 2015 08:54:47 -0700 (PDT)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id wf6si1493077lbb.2.2015.06.29.08.54.47
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jun 2015 08:54:47 -0700 (PDT)
Received-SPF: neutral (google.com: 84.204.203.130 is neither permitted nor denied by best guess record for domain of flatworm@users.sourceforge.net) client-ip=84.204.203.130;
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	(authenticated bits=0)
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id t5TFsU5P004544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 29 Jun 2015 18:54:31 +0300
In-Reply-To: <426859781bd04ca4ebb13719350537ed@www.dscho.org>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-Original-Sender: flatworm@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 84.204.203.130 is neither permitted nor denied by best guess
 record for domain of flatworm@users.sourceforge.net) smtp.mail=flatworm@users.sourceforge.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272967>

On Mon, 29 Jun 2015 16:37:54 +0200
Johannes Schindelin <johannes.schindelin@gmx.de> wrote:

> >> I just uploaded the 4th release candidate for the upcoming Git for
> >> Windows 2.x release. Please find the download link here:
> >>
> >> https://git-for-windows.github.io/#download
> >>
> >> The most important changes are the update to Git 2.4.5 and a fix
> >> for the crash when running Git Bash with a legacy `TERM` setting
> >> (this should help 3rd party software to upgrade to Git for Windows
> >> 2.x).
> > 
> > Thanks.
> > It seems that this link:
> > 
> >    https://github.com/git-for-windows/git/releases/latest
> > 
> > doesn't point to the latest release.
> > 
> > Might be because the tags have the same date ?
> 
> Wooops. Sorry for being so slow (been interviewing today). It should
> be correct now, can you verify, please?

Thanks for making all this real, Johannes!

I've finally took time to switch from my old "msys1" release to this
RC4, and immediately got hit by the fact Git is now speaking to me in
Russian, which is not what I want (previously this behaviour was only
exhibited by `git gui` and `gitk`).

Should I make Git see LC_MESSAGES=en (or other thing like LANG) in the
environment or is there some Git-local method to affect this behaviour?
I tried to grep the release notes using relevant keywords but was left
empty-handed.

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
