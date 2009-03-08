From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: Git for Windows 1.6.2-preview20090308
Date: Sun, 8 Mar 2009 14:13:27 +0300
Organization: HOME
Message-ID: <200903081413.28354.angavrilov@gmail.com>
References: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
Reply-To: ANGavrilov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: msysgit@googlegroups.com, Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Mar 08 12:12:47 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgGvw-0000Y3-D3
	for gcvm-msysgit@m.gmane.org; Sun, 08 Mar 2009 12:12:40 +0100
Received: by yw-out-2122.google.com with SMTP id 1so736421ywp.63
        for <gcvm-msysgit@m.gmane.org>; Sun, 08 Mar 2009 04:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:from
         :organization:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=HeANlKTtXi73U7jQDNv5kCh9oUw+JqgU0DybAFOzRZc=;
        b=3NzvgSpoJLxp3+QbfPq2z7+Kg1GIre2d50BdWvW+JUw3+fE8XPC7ZFGBQLtLM3Xbs5
         a6RapAXpaBpb9CbB6NC7340UGXMVJpvu3pwt7i3dE0nsSaoNVDeeZ4Z/sl/9/Td/Bf7P
         j4oEXsDv5oALfc+/Q+FOxR225lzavlIrdVFr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:reply-to
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        b=D1lz/nc84u17DtYXjy5MoNBf70eLUMqyCkBpWS5/qTAbfUExJ/hEQO1jK7NhQPX8eH
         yOP5T8X8ttxq7F163i4a4AjVthsd9enQ3Ar4wwjjcGA2lf18vdpzCggjsIcEmW3nQKf7
         /5rFUR6sPflLCBbpYrfZQkEKKwfa3Cgi90IDg=
Received: by 10.90.72.3 with SMTP id u3mr823650aga.14.1236510667294;
        Sun, 08 Mar 2009 04:11:07 -0700 (PDT)
Received: by 10.176.150.42 with SMTP id x42gr3853yqd.0;
	Sun, 08 Mar 2009 04:11:07 -0700 (PDT)
X-Sender: angavrilov@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.180.220.13 with SMTP id s13mr116079bkg.0.1236510666306; Sun, 08 Mar 2009 04:11:06 -0700 (PDT)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154]) by gmr-mx.google.com with ESMTP id 15si248494bwz.2.2009.03.08.04.11.05; Sun, 08 Mar 2009 04:11:05 -0700 (PDT)
Received-SPF: pass (google.com: domain of angavrilov@gmail.com designates 72.14.220.154 as permitted sender) client-ip=72.14.220.154;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of angavrilov@gmail.com designates 72.14.220.154 as permitted sender) smtp.mail=angavrilov@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id l27so634130fgb.42 for <msysgit@googlegroups.com>; Sun, 08 Mar 2009 04:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:organization:to:subject :date:user-agent:cc:references:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:message-id; bh=DpXl4bUI84adEgoqWfwqxyHCyj8s3qbT8luJZQYyTPM=; b=AMf29m1cCIRhUxtAuv51Ugtsip2h2KXnR0+SDP8PR7FV+aE35Gacd9RoSCV4mingn2 bNZ+3TVfQHsPL/PCFTzIryBYD4rlqcqqQR/Yw1lAPLHnwAJ++EatBMq0Ez8vPThBduWQ S9NaEynkDm8q5StQQQUc9UuZMV9u3he5pl4KE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:organization:to:subject:date:user-agent:cc:references :in-reply-to:mime-version:content-type:content-transfer-encoding :content-disposition:message-id; b=qfA0ccpJ1xhz0KOXsAwVIcyk31sO2U8wFJvt97h2rD48RUtb7XoZCcrCADOVTQLgXT 6QlPENhr9NTCb73WVRmooQmmspyg4ByXE5IZMkvy/fbqlgspHjCjvZkKUWyNwQ1cXX3P tfEs26X91qzdVYjixK6lL73g2qRB/trW8x3Ns=
Received: by 10.86.80.5 with SMTP id d5mr112460fgb.19.1236510665116; Sun, 08 Mar 2009 04:11:05 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78]) by mx.google.com with ESMTPS id 3sm2073442fge.28.2009.03.08.04.11.04 (version=SSLv3 cipher=RC4-MD5); Sun, 08 Mar 2009 04:11:04 -0700 (PDT)
User-Agent: KMail/1.11.0 (Linux/2.6.27.19-170.2.35.fc10.i686; KDE/4.2.0; i686; ; )
In-Reply-To: <alpine.DEB.1.00.0903080132470.10279@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112616>


On Sunday 08 March 2009 04:10:21 Johannes Schindelin wrote:
> I just released a new version of Git for Windows (TAFKA WinGit).  It is 
> basically Git 1.6.2 plus a few patches.  Please find the installer here:
> 
> 	http://msysgit.googlecode.com/
> 
> Disclaimer: Git for Windows is still in a state where I do _not_ recommend 
> using it unless you have the means to fix issues.  Unlike git.git 
> developer community, the msysGit team is heavily undermanned.
> 
> Known issues

I've just noticed that the following git-gui fixes haven't been merged in 1.6.2:

  git-gui: Support more git version notations.
  git-gui: Avoid an infinite rescan loop in handle_empty_diff.
  git-gui: Fix post-commit status with subject in non-locale encoding

The second one is a fix for a rather important problem reported on the msysgit list.
The last one is msysgit bug #181.

Alexander
