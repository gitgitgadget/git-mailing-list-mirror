From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 07:22:37 -0500
Message-ID: <eaa105841003100422h3aa273del1e7b77786d83a7e1@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
	 <46d6db661003092258t22f2ee5ga720f18a859db957@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, msysgit@googlegroups.com, 
	git@vger.kernel.org
To: Christian MICHON <christian.michon@gmail.com>
X-From: 3EI-XSw8JB4Ivkzkx.oy.g.mkkqmsgor.iussy4ymozmuumrkmxu0vy.ius@groups.bounces.google.com Wed Mar 10 13:23:05 2010
Return-path: <3EI-XSw8JB4Ivkzkx.oy.g.mkkqmsgor.iussy4ymozmuumrkmxu0vy.ius@groups.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-px0-f151.google.com ([209.85.216.151])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <3EI-XSw8JB4Ivkzkx.oy.g.mkkqmsgor.iussy4ymozmuumrkmxu0vy.ius@groups.bounces.google.com>)
	id 1NpKwL-0007sw-DJ
	for gcvm-msysgit@m.gmane.org; Wed, 10 Mar 2010 13:23:05 +0100
Received: by pxi15 with SMTP id 15sf2426097pxi.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 10 Mar 2010 04:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:mime-version:sender:received
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:list-subscribe:list-unsubscribe:content-type;
        bh=IMTHJBd9gxwJHWKi0q28q0wtDBdgS5/qd7j9TO/4VSY=;
        b=2KXMwMm0c1WPJAOmEe2PI+nW35fPktY6jOMNsjmGzM4ZDDp3mRHFJMO3nQz8e8p8Ul
         vLAcydG29JB5Pva6Bc0VK4k/byafIKujjYyIXWUOeYvyAftJNt/GGJ2Ej3QcOXfuXogz
         BepTsgLvNL7Goy9CCASLNq3ESPrSsobHyqLW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:sender:in-reply-to:references
         :date:message-id:subject:from:to:cc
         :x-original-authentication-results:x-original-sender:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:x-thread-url
         :x-message-url:list-subscribe:list-unsubscribe:content-type;
        b=Le3VWJUGw1AIAR5VIsIAQMtm/UMvLyRuV1kwLNL5Eh4yen4UEOJpuaW7xi9jHuuJwh
         zFDYnly6kM96T1NhM9vq9qkoF+88tCqdh44yOE0nvA6dbWESVt56uoT7ngoTo8QepQ17
         +0co5DveYlLKWvOF7zcfLdxv7Whmi7SJcGeVA=
Received: by 10.142.207.14 with SMTP id e14mr12246wfg.10.1268223760948;
        Wed, 10 Mar 2010 04:22:40 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.142.209.3 with SMTP id h3ls361428wfg.0.p; Wed, 10 Mar 2010 
	04:22:38 -0800 (PST)
Received: by 10.143.20.17 with SMTP id x17mr122284wfi.28.1268223758353;
        Wed, 10 Mar 2010 04:22:38 -0800 (PST)
Received: by 10.143.20.17 with SMTP id x17mr122283wfi.28.1268223758333;
        Wed, 10 Mar 2010 04:22:38 -0800 (PST)
Received: from mail-pz0-f193.google.com (mail-pz0-f193.google.com [209.85.222.193])
        by gmr-mx.google.com with ESMTP id 24si1963699pzk.9.2010.03.10.04.22.37;
        Wed, 10 Mar 2010 04:22:37 -0800 (PST)
Received-SPF: pass (google.com: domain of peter.is.a.geek@gmail.com designates 209.85.222.193 as permitted sender) client-ip=209.85.222.193;
Received: by pzk31 with SMTP id 31so4651687pzk.20
        for <msysgit@googlegroups.com>; Wed, 10 Mar 2010 04:22:37 -0800 (PST)
Sender: msysgit@googlegroups.com
Received: by 10.143.84.8 with SMTP id m8mr430729wfl.56.1268223757136; Wed, 10 
	Mar 2010 04:22:37 -0800 (PST)
In-Reply-To: <46d6db661003092258t22f2ee5ga720f18a859db957@mail.gmail.com>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of peter.is.a.geek@gmail.com designates 209.85.222.193 as permitted 
	sender) smtp.mail=peter.is.a.geek@gmail.com; dkim=pass (test mode) 
	header.i=@gmail.com
X-Original-Sender: peter.is.a.geek@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
X-Thread-Url: http://groups.google.com/group/msysgit/t/1a323b5ee3684208
X-Message-Url: http://groups.google.com/group/msysgit/msg/c65829de44efb43b
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141880>

On Wed, Mar 10, 2010 at 1:58 AM, Christian MICHON wrote:
> This one feels weird here on Vista: .gitignore or .gitattributes end
> up having no name visible at all on Explorer file view. I can only see
> their real names once I fire the editor, on the title bar of the
> editor. Is this expected ?

By default, XP and newer hide extensions. For security[1] and
usability reasons, the first thing any sane person does after
installing Windows is change explorer to show extensions.

So it's expected, but only if you're insane. :-)

Peter Harris

[1] Malware authors like to ship "trojan.exe" with an embedded icon
that looks like the one your text editor sets on text files. Or even
"trojan.txt.exe"
