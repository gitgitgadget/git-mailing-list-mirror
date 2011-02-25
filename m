From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Fri, 25 Feb 2011 12:05:44 +0300
Organization: Marine Bridge & Navigation Systems
Message-ID: <20110225090544.GA3783@tugrik.mns.mnsspb.ru>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org> <AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com> <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncCM2jlMK5EBD45J3rBBoEktTtJA@googlegroups.com Fri Feb 25 10:12:51 2011
Return-path: <msysgit+bncCM2jlMK5EBD45J3rBBoEktTtJA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wy0-f186.google.com ([74.125.82.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCM2jlMK5EBD45J3rBBoEktTtJA@googlegroups.com>)
	id 1PstjG-00006s-I0
	for gcvm-msysgit@m.gmane.org; Fri, 25 Feb 2011 10:12:50 +0100
Received: by wyb29 with SMTP id 29sf1038300wyb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 25 Feb 2011 01:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:x-beenthere:received-spf:date:from:to:cc
         :subject:message-id:references:mime-version:in-reply-to:organization
         :user-agent:x-original-sender:x-original-authentication-results
         :x-google-group-id:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type:content-disposition:content-transfer-encoding;
        bh=N56bqlZSHhxNEWIkB+r/sMA+GSabnjWjSVpIilDK2sw=;
        b=pmghFukC0rpf8Z5qtvkZhU7iIxpOlaaY2/2LJH0Swxsgq385xGsCJxXvtR06Yb6VU2
         v61+DO91+BffnGGvPzFSE+c8HJa+Jdql5iYVYGgnZMSUVZ6ah8ZYfZ7yRudDcv4q0BnW
         7XLP3g5f9nF2/zIEZ4OFaAra7ahqg5QABBupk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:organization:user-agent
         :x-original-sender:x-original-authentication-results
         :x-google-group-id:precedence:mailing-list:list-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type:content-disposition:content-transfer-encoding;
        b=N2dE1JZ15nPUHgi9frGOtYdY7G+BzhfuQJ3E/jk8wev/XJVNSMZVDyccni5YiWXqGV
         ETRP4i3fy0mLgPdfIv2YtJm0sueA15bnP/zTYJfmzVpb5VOza+35tA5tvBdKA3E6+MhD
         lGUjeUTaNBV2/9X7VpKRsdat9so6cvPp9t4Co=
Received: by 10.216.179.137 with SMTP id h9mr322787wem.4.1298625144562;
        Fri, 25 Feb 2011 01:12:24 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.216.213.147 with SMTP id a19ls368907wep.2.p; Fri, 25 Feb 2011
 01:12:23 -0800 (PST)
Received: by 10.216.163.83 with SMTP id z61mr447384wek.8.1298625143585;
        Fri, 25 Feb 2011 01:12:23 -0800 (PST)
Received: by 10.14.37.79 with SMTP id x55mr183638eea.21.1298624686964;
        Fri, 25 Feb 2011 01:04:46 -0800 (PST)
Received: by 10.14.37.79 with SMTP id x55mr183637eea.21.1298624686953;
        Fri, 25 Feb 2011 01:04:46 -0800 (PST)
Received: from mail.mnsspb.ru (mail.mnsspb.ru [84.204.75.2])
        by gmr-mx.google.com with ESMTPS id p52si141391eeh.7.2011.02.25.01.04.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 01:04:45 -0800 (PST)
Received-SPF: pass (google.com: domain of kirr@mns.spb.ru designates 84.204.75.2 as permitted sender) client-ip=84.204.75.2;
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1PstbH-0000wO-8x; Fri, 25 Feb 2011 12:04:35 +0300
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1PstcO-0007rG-Dk; Fri, 25 Feb 2011 12:05:44 +0300
In-Reply-To: <AANLkTimWy+W+rcZHsac_n--y9iMeaoO66CPZVbN1VBp2@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Original-Sender: kirr@mns.spb.ru
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kirr@mns.spb.ru designates 84.204.75.2 as permitted sender) smtp.mail=kirr@mns.spb.ru
X-Google-Group-Id: 1910972674
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167892>

+Dscho

On Thu, Feb 24, 2011 at 10:45:33AM +0100, Erik Faye-Lund wrote:
> On Thu, Feb 24, 2011 at 1:32 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> > And then there's the issue that unlike the C patches these will not be
> > a no-op that'll be optimized away by the compiler. We'll be calling an
> > external program for displaying messages. While this is a trivial cost
> > on Unix (especially in the context we're using it, i.e. not in tight
> > loops) it's more expensive on Windows.
> >
> 
> Ouch. I remember this being brought up earlier, but I just assumed it
> had been fixed somehow. The shell-scripts are already pretty slow on
> Windows, and the overhead of starting a new process here is quite
> significant.

Johannes, can we please try my patch[1] for msys.dll not to load
user32.dll for every msys program (i.e. sh.exe too)? Combined together
with 3 clipboard functions removal (details in [2]) from sh.exe, I bet
this will result in significantly faster shell startup, configure runs,
etc...

This days I have lack of access to windows machines, only wine, so I
desperately need someones help to at least first rebuild msys.dll.


Thanks,
Kirill

[1] http://repo.or.cz/w/msys/kirr.git/commitdiff/f7d7efebd35e8e5bf6d685ff4f1197941984be04
[2] http://repo.or.cz/w/msys/kirr.git/commitdiff/a97bed5d22f9c05f39776d8ea7856db4ce572dc5
