From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 0/4] Fix the Visual Studio 2008 .sln generator
Date: Fri, 21 Nov 2014 10:38:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411211032060.13845@s15462909.onlinehome-server.info>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GitList <git@vger.kernel.org>, Marius Storm-Olsen <mstormo@gmail.com>, 
    Ramsay Jones <ramsay@ramsay1.demon.co.uk>, 
    Jonathan Nieder <jrnieder@gmail.com>, 
    Michael Wookey <michaelwookey@gmail.com>, 
    Msysgit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBCZPH74Q5YNRBAMQXSRQKGQE2A55Q6Q@googlegroups.com Fri Nov 21 10:38:12 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBAMQXSRQKGQE2A55Q6Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f183.google.com ([209.85.223.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBAMQXSRQKGQE2A55Q6Q@googlegroups.com>)
	id 1XrkfL-0000Kf-8H
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 10:38:11 +0100
Received: by mail-ie0-f183.google.com with SMTP id x19sf619651ier.10
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 01:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=u/fE7FqpoIkXHYCJvWH5QUHQDmUfr3YmM6Vm3hOYTps=;
        b=GeRUrH7sQ29+nuAlOuqZKxQmqq9Ps6DiYyjOqJw+R7ZDnrjgLryNJiGlyU6636k7HO
         JnGiRON/dV6a5Qv8resJjuw7fyGO/T1pTllZ0aNAC7XxEqocs8q+k1lpr8DKz1wR6WiI
         g0XhkAKk08cKXMtAV5LHYjVbDSBiHg71aovGWuBEBkHsVW8eXAOf5i/7/1nOLXyzgvCY
         egeMSSg3JvqXC9hw9n0EWr6ame4XF+r2KSMAmGkg7OMvyaM/MVb34/1cafxCZHWopszV
         tpNk+ap1184s/I/Zo+iqKQlTCytbapSiZDQJ51shDcvdVBwcLmahIVEdg5/gu835F9pP
         liCw==
X-Received: by 10.50.134.135 with SMTP id pk7mr493769igb.6.1416562690534;
        Fri, 21 Nov 2014 01:38:10 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.128.107 with SMTP id nn11ls515139igb.23.gmail; Fri, 21 Nov
 2014 01:38:09 -0800 (PST)
X-Received: by 10.42.67.11 with SMTP id r11mr7803268ici.24.1416562689762;
        Fri, 21 Nov 2014 01:38:09 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id o6si702810igv.0.2014.11.21.01.38.09
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Nov 2014 01:38:09 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0M6Ana-1YBEHc40KY-00yD2H;
 Fri, 21 Nov 2014 10:38:07 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1416526682-6024-1-git-send-email-philipoakley@iee.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:RBdtBHjT1dyEd5Tmw3leYFz2TGB+Box6oxJgbwa03j8vHtfhn3P
 CeH2185M5se3bEwsIiAMlVaSkcfuL5FACJlxDMGfNMmYPK5oWNyES2zfn+RQj8/BJwRSnMp
 X92CYGWmSiT2+GHTArm9AWHfPngzWGU8GwqGSmAgiOMM6yrWg3wnclrS7GndqWXOuwblcPT
 8hDGVV74j4+6yn83ZDXLQ==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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

Hi Philip,

On Thu, 20 Nov 2014, Philip Oakley wrote:

> Are the patches going in the right direction?

Yes.

A couple of general comments:

- please do not comment out code. Just remove it.

- the first three commit messages look funny, being indented by 4
  spaces... unintentional?

> Is the processing of the .obj file in engine.pl sensible?

Yes, but instead of adding dead code, it would be better to use the
comment "# ignore". I would also strongly suggest to hard-code the
complete file name instead of just the extension. We know exactly which
file name we want to ignore, and if there should be another .obj file
eventually, it would be wrong to ignore it, too.

> and the extra care with s/\.o$/.c/ avoiding s/obj/cbj/.

Technically, you need to use a group \($\|[ \t]\), but I think that that
would be overkill.

> Does it affect the Qmake capability? (I've no idea)

Frankly, neither do I ;-) But since you touched only engine.pl, I would
expect Qmake not to be affected at all, right?

> Is the quoting of filenames correct? (my perl foo is cargo cult!)

IANAPME (I am not a Perl Monk either), but it looks good to me.

> I've also updated the vcbuild/README to mention Msysgit (which
> will be replaced soon by the newer/better Git-for-windows/SDK
> (https://github.com/git-for-windows/sdk), but the benefits still
> apply.

The path you used is /msysgit/bin/msvc-build, but the real path would be
/bin/msvc-build.

> Obviously, the patches will need squashing together,

To the contrary, I like the current separation of concerns.

Ciao,
Johannes
