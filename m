From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove the line length limit for graft files
Date: Fri, 27 Dec 2013 23:53:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1312272352290.1191@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1312272146590.1191@s15462909.onlinehome-server.info> <20131227210447.GE20443@google.com> <alpine.DEB.1.00.1312272208070.1191@s15462909.onlinehome-server.info> <20131227223240.GG20443@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBA4K7CKQKGQE7ZXFLNQ@googlegroups.com Fri Dec 27 23:53:57 2013
Return-path: <msysgit+bncBCZPH74Q5YNRBA4K7CKQKGQE7ZXFLNQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ea0-f183.google.com ([209.85.215.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBA4K7CKQKGQE7ZXFLNQ@googlegroups.com>)
	id 1VwgI0-0005Cm-In
	for gcvm-msysgit@m.gmane.org; Fri, 27 Dec 2013 23:53:56 +0100
Received: by mail-ea0-f183.google.com with SMTP id q10sf725502ead.0
        for <gcvm-msysgit@m.gmane.org>; Fri, 27 Dec 2013 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=VpUC2yU8FuJifZ92xgdIqp1RXuotZ0+hJsktVOGIFm8=;
        b=clnk3h9mHYbavvL0i9+7xYY+wCGxgglEJ6EU6fqRP0GoNei/Zb0KhcypGlMGCL5g8K
         3i5SmO6LbPl70PEQvjmFaevj1gSw+bvn806+j1dtWLeXNUuqXf7cTwFsAdEUBGNOal3i
         cx0mMTTzEPsFtdgcLM3g5CEHp6stRuyd+L///DwdC4SGC4XIge1dRQvF51grtrnwnsYE
         ybourRruwQVKHlmwaueZnNoGQ8/Goktk+JRspCa+qMcq2QAEiPOT1arlixsJuhHeSHhE
         g4L+n6djo3ULbPs/VJVvVugEwkewxmleeoFE99DH+ytxf9cOHlKP4D93S2qQEacxj+Wv
         8Huw==
X-Received: by 10.152.220.167 with SMTP id px7mr123lac.38.1388184836245;
        Fri, 27 Dec 2013 14:53:56 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.180.193 with SMTP id dq1ls473646lac.107.gmail; Fri, 27 Dec
 2013 14:53:55 -0800 (PST)
X-Received: by 10.152.87.104 with SMTP id w8mr20780132laz.8.1388184835502;
        Fri, 27 Dec 2013 14:53:55 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.18])
        by gmr-mx.google.com with ESMTPS id s42si1556105eew.1.2013.12.27.14.53.55
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2013 14:53:55 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.18 as permitted sender) client-ip=212.227.15.18;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MgsVY-1W9xz83ZzM-00M8E1
 for <msysgit@googlegroups.com>; Fri, 27 Dec 2013 23:53:55 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20131227223240.GG20443@google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:kognj3YdZgUwe6s9fwzNgex179rFORT+Jg+nsWomgMoFYh18/UY
 4186tzBPcP/ufELdLfZWzJF/5jV8HOi2qzpvKbP9TNMnRkQeAZx6GqA/0X+IJjcyf1ffm1E
 Zyxq5zNTYTAwNiWzSwFAX4cfuVd6WB++62i0a2Maqee2oTjrXSPh+1xqIi9CAG9rRStjszS
 w69axP3fbJya45BbvDxig==
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239756>

Hi Jonathan,

On Fri, 27 Dec 2013, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Fri, 27 Dec 2013, Jonathan Nieder wrote:
> 
> >> Is this easy to reproduce so some interested but lazy person could
> >> write a test?
> >
> > Yep. Make 25 orphan commits, add a graft line to make the first a merge of
> > the rest.
> 
> Thanks.  Here's a pair of tests doing that.

Thank you very much!

> +	for i in 0 1 2
> +	do
> +		for j in 0 1 2 3 4 5 6 7 8 9
> +		do

for the record, I usually prefer

	i=0
	while test $i -t 30
	do
		...
		i=$(($i+1))
	done

but your code is just as good!

Ciao,
Dscho

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
