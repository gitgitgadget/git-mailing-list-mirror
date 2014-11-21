From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC 4/4] Improve layout and reference msvc-build script
Date: Fri, 21 Nov 2014 10:51:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411211049100.13845@s15462909.onlinehome-server.info>
References: <1416526682-6024-1-git-send-email-philipoakley@iee.org> <1416526682-6024-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GitList <git@vger.kernel.org>, Marius Storm-Olsen <mstormo@gmail.com>, 
    Ramsay Jones <ramsay@ramsay1.demon.co.uk>, 
    Jonathan Nieder <jrnieder@gmail.com>, 
    Michael Wookey <michaelwookey@gmail.com>, 
    Msysgit <msysgit@googlegroups.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: msysgit+bncBCZPH74Q5YNRBNMWXSRQKGQELOREPIQ@googlegroups.com Fri Nov 21 10:51:51 2014
Return-path: <msysgit+bncBCZPH74Q5YNRBNMWXSRQKGQELOREPIQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f61.google.com ([209.85.215.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBNMWXSRQKGQELOREPIQ@googlegroups.com>)
	id 1XrksY-0006iT-Qv
	for gcvm-msysgit@m.gmane.org; Fri, 21 Nov 2014 10:51:50 +0100
Received: by mail-la0-f61.google.com with SMTP id gm9sf84081lab.6
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Nov 2014 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=p0anszsFAepz8aY4RyuMm2GMid3fKDnCIGMrj1LLRQQ=;
        b=V1u0qfEmfKnlS53D67Pb/t1ipCbywv7fBG7xUxd7H3fPr74cN0lnEbEvKL/QaeOAdc
         O3fWVz56tI7eqfstz8Ne2gKvkn8v1s5VRZgAg0jI5kT1Hqf7928uYI0mkSWa0Jw84oXR
         J423Fkrgn+rWRLxiQHqFoL+WYCfvKhcMkx46ir2nUhmyuT5RrNAjaqAYtdXF3qnAdiKb
         dXvdUkJYtVB0p3QhsJ3WAGVL3jVwzb81zTmOjrGcdThmycNa0AUn7q9fyQ+a5lKjiyJT
         Xnw01wMr/IsVNOtVH3MHbJxL+C/PTXGsoKi7RHTqnSIRPxvenVf2h8hjvqBfB0qiI+3Z
         X0VQ==
X-Received: by 10.152.5.194 with SMTP id u2mr62817lau.3.1416563510613;
        Fri, 21 Nov 2014 01:51:50 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.23.229 with SMTP id p5ls181604laf.4.gmail; Fri, 21 Nov
 2014 01:51:48 -0800 (PST)
X-Received: by 10.112.32.163 with SMTP id k3mr504110lbi.17.1416563508602;
        Fri, 21 Nov 2014 01:51:48 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.20])
        by gmr-mx.google.com with ESMTPS id l4si344922wif.2.2014.11.21.01.51.48
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Nov 2014 01:51:48 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as permitted sender) client-ip=212.227.17.20;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0LzpWx-1Y4NuE1S6N-0150rI;
 Fri, 21 Nov 2014 10:51:37 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1416526682-6024-5-git-send-email-philipoakley@iee.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:EUSl120WAVYMGjB21r2xy2kRI3eT/yq4+sDS3R9lN5W+fSVlqKS
 oWRq4CmyGPDxLMMSMTb6MW1EDQ+z6BFkiDeHZ7NMM6eAmI5e+dxeTGTA2KgljPbOvh5dc6S
 664HvkJixRNpzvorjynOg9oIit+dzkn9jwVJZuC+V8yLXDKuyV6nAKfORehOU7HDCrC+6xn
 HSUiyGx+moHrh3AStUCiA==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.17.20 as
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

> [...]
> +Or, use the msvc-build script; also in /msysgit/bin/msvc-build

As I mentioned before, from a Git Bash on Windows, the path is
/bin/msvc-build (no /msysgit/). That is quite likely to stay the same with
the upcoming Git for Windows SDK, too (once I add the file to the SDK).

By the way, I think we should also start thinking about a Jenkins job to
verify that upstream changes such as invalidcontinue.obj do not break the
MSVC build. Please let me know if you want to give it a try, I have a
Windows Azure instance with a Jenkins instance, sponsored by Microsoft.

Ciao,
Johannes
