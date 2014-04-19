From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Sat, 19 Apr 2014 20:42:10 +0200
Message-ID: <20140419184210.GB3617@book-mint>
References: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBDVPBNNXUMFBBBMHZONAKGQE3C4ZACI@googlegroups.com Sat Apr 19 20:42:15 2014
Return-path: <msysgit+bncBDVPBNNXUMFBBBMHZONAKGQE3C4ZACI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f62.google.com ([209.85.215.62])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDVPBNNXUMFBBBMHZONAKGQE3C4ZACI@googlegroups.com>)
	id 1WbaDO-0005zR-Pl
	for gcvm-msysgit@m.gmane.org; Sat, 19 Apr 2014 20:42:14 +0200
Received: by mail-la0-f62.google.com with SMTP id ec20sf235496lab.27
        for <gcvm-msysgit@m.gmane.org>; Sat, 19 Apr 2014 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=/eD8mGa2D0T21EEsGywfrBEDL1r2oedNStffuz0Frhs=;
        b=i1rEw82m4O3Sez8/nCjm31o34/nU0LWSdZd/sTJ3nKZlt0rKv2qgWRBA0K71eLiU8z
         2QJbEx0Z9dWW5uV4WBBXOjkikYk1XzRtSbnA75m6SBDOvWIDZ5TSXH04FQKQmMNonHA4
         lXzAJFXhMkFGN59S4ikunxfMCkrxZLc9pnnFmIH+/ozCslXhV5k8nsgz5RMXbXasbifv
         jVb9YQY6i7gYID5cSG80kFuCH8UljAGr0BjycN7srqlTZyUlrAKUySjDu8RdOln1YLbx
         2rhBtgE340mRcYvnRaYzHvHaoHGm8kZH+h/YquzSSQNTVzx1XlwhFYPIHKXcCIMN1LHg
         EkqA==
X-Received: by 10.152.202.231 with SMTP id kl7mr322969lac.3.1397932934587;
        Sat, 19 Apr 2014 11:42:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.198.236 with SMTP id jf12ls308824lac.97.gmail; Sat, 19 Apr
 2014 11:42:13 -0700 (PDT)
X-Received: by 10.152.3.38 with SMTP id 6mr2396198laz.0.1397932933623;
        Sat, 19 Apr 2014 11:42:13 -0700 (PDT)
Received: from smtprelay01.ispgateway.de (smtprelay01.ispgateway.de. [80.67.31.39])
        by gmr-mx.google.com with ESMTPS id u49si7360eeo.1.2014.04.19.11.42.13
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 19 Apr 2014 11:42:13 -0700 (PDT)
Received-SPF: neutral (google.com: 80.67.31.39 is neither permitted nor denied by best guess record for domain of hvoigt@hvoigt.net) client-ip=80.67.31.39;
Received: from [80.228.206.6] (helo=book-mint)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1WbaDM-0002GY-EM; Sat, 19 Apr 2014 20:42:12 +0200
In-Reply-To: <rfujmbew27f1gaa6dbk706li.1397911737867@email.android.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
X-Original-Sender: hvoigt@hvoigt.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 80.67.31.39 is neither permitted nor denied by best guess record
 for domain of hvoigt@hvoigt.net) smtp.mail=hvoigt@hvoigt.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246523>

On Sat, Apr 19, 2014 at 05:35:07PM +0400, Marat Radchenko wrote:
> > there are no 64 bit binaries shipped with msysgit is that nobody
> > needed them
> 
> That's wrong. Google for 'windows x64 git' or 'msysgit x64'. People
> need it. There's even an issue [3] (stalled several years ago) in
> msysgit tracker.  After all, I needed it.

Do not get me wrong. I was saying until now nobody "needed" it in a way
that he/she would do something about it. Of course there are many people
requesting it, but I just do not count those people anymore. You are
clearly doing something about it and thats great, I like it.

What I am trying to achieve here is that you join the msysgit community.
There already is just a very small amount of developers on the windows
side (compared to upstream). We should try to all work together. I think
it will greatly add to confusion if we have another installer of Git for
Windows. I think the msysgit community is quite open for changes like
the ones you are trying to achieve.

Regarding mingwGitDevEnv[2]: That is a project started by Sebastian who
also contributes to msysgit (and Git for Windows). It eventually can
(and probably should) be a successor of the current situation where we
always manually patch, build and commit our binaries into a git
repository. A proper package management system would greatly help here.
But AFAIK its not ready for production use yet. I guess Sebastian would
not mind contributions.

Cheers Heiko

> [1] https://github.com/msysgit/msysgit/issues/31
> [2]: https://github.com/sschuberth/mingwGitDevEnv
> [3]: http://code.google.com/p/msysgit/issues/detail?id=396

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
