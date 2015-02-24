From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Tue, 24 Feb 2015 18:32:39 +0100
Message-ID: <vpqioerz03s.fsf@anie.imag.fr>
References: <20150218191417.GA7767@peff.net> <20150218193234.GA8298@peff.net>
	<5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
        msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBC3OZIEKVABBBPXLWKTQKGQELXGWBII@googlegroups.com Tue Feb 24 18:32:49 2015
Return-path: <msysgit+bncBC3OZIEKVABBBPXLWKTQKGQELXGWBII@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f183.google.com ([74.125.82.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBC3OZIEKVABBBPXLWKTQKGQELXGWBII@googlegroups.com>)
	id 1YQJLj-0000uV-Qb
	for gcvm-msysgit@m.gmane.org; Tue, 24 Feb 2015 18:32:47 +0100
Received: by wevl61 with SMTP id l61sf4711612wev.8
        for <gcvm-msysgit@m.gmane.org>; Tue, 24 Feb 2015 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:mailscanner-null-check
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=k4vcJbjeiryzSyruZDnAMhEFYuIGwyg+JFVT8L2eZe4=;
        b=qRpw43uWBWgLiQRG0LPMFpOxb68VOX+vsO++Cdb37EtkXmESwKzXb3/MIGlzjsQ3gW
         DKL91oLxCRyKHrO6TA2CUGfmHeigLizBQHgJn9ku7MDY1aAFdCJZ1/NvSho+36U2o9dY
         fr4MHjx4fQOm2kwAUCB7eso5SKpneKlSCq7o/t/lh7rQkTUG2eguLXheVs7I5/t+bo8l
         1DsMi0NyYA0lJGAfzl6yQFHTw8b/DEvsmvxq+9lyWFiZsd0CbS4SwvNtbIqQ8fdqBk6A
         mIYXTAu/qqOaGmNgNWBHAiyK9cz7uQV638bbiHKVK9QEouRKcux1nYICc3cw7nPG//sO
         dOSw==
X-Received: by 10.180.106.135 with SMTP id gu7mr112661wib.7.1424799167506;
        Tue, 24 Feb 2015 09:32:47 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.126.68 with SMTP id mw4ls825272wib.12.canary; Tue, 24 Feb
 2015 09:32:45 -0800 (PST)
X-Received: by 10.180.91.76 with SMTP id cc12mr2285779wib.7.1424799165684;
        Tue, 24 Feb 2015 09:32:45 -0800 (PST)
Received: from shiva.imag.fr (mx1.imag.fr. [2001:660:5301:6::5])
        by gmr-mx.google.com with ESMTPS id l8si1123879wia.0.2015.02.24.09.32.45
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 24 Feb 2015 09:32:45 -0800 (PST)
Received-SPF: pass (google.com: domain of Matthieu.Moy@grenoble-inp.fr designates 2001:660:5301:6::5 as permitted sender) client-ip=2001:660:5301:6::5;
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1OHWbpW000995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Feb 2015 18:32:37 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1OHWd82024924;
	Tue, 24 Feb 2015 18:32:39 +0100
In-Reply-To: <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org> (Johannes
	Schindelin's message of "Tue, 24 Feb 2015 13:01:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 24 Feb 2015 18:32:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1OHWbpW000995
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1425403961.73579@hSQ7QPaSVPFSZN0tPHwNjA
X-Original-Sender: matthieu.moy@grenoble-inp.fr
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Matthieu.Moy@grenoble-inp.fr designates
 2001:660:5301:6::5 as permitted sender) smtp.mail=Matthieu.Moy@grenoble-inp.fr
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264334>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> After considerable consideration, I am offering to mentor
> Windows-related projects (into which I count conversion of scripts
> into builtins).

Good news!

About the proposal:

  The idea of this project is to dive into the Git source code and
  convert, say, git-add--interactive.perl and/or git stash into proper C
  code, making it a so-called "built-in".

My advice would be to try converting several small scripts, and avoid
targetting a big one. This way, you can have a first patch series
reviewed on-list, and merged in pu rather soon. From my experience, an
early review is very important to get the student on track, and
splitting the GSoC into multiple related projects avoids the situation
where you have the feature "95% completed" at the end of the GSoC, but
nothing merged.

add--interactive and stash are relatively complex beasts, perhaps
git-pull.sh would be easier to start with.

OTOH, you know which script would be most useful to be converted into a
builtin much better than me!

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

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
