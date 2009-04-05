From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mergetool-lib: make (g)vimdiff workable under
 Windows
Date: Sun, 5 Apr 2009 11:35:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904051134210.10279@pacific.mpi-cbg.de>
References: <200904041517.55890.markus.heidelberg@web.de>
Reply-To: Johannes.Schindelin@gmx.de
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,  David Aguilar <davvid@gmail.com>, Charles Bailey <charles@hashpling.org>,  msysgit@googlegroups.com
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Apr 05 11:34:43 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.27])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqOkL-0004PX-87
	for gcvm-msysgit@m.gmane.org; Sun, 05 Apr 2009 11:34:33 +0200
Received: by yw-out-2122.google.com with SMTP id 1so593051ywp.63
        for <gcvm-msysgit@m.gmane.org>; Sun, 05 Apr 2009 02:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:x-authenticated:x-provags-id:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=zYxa6j5v6sOub4EppMvR6MHCJyO2F6YvMdR77A5h/lo=;
        b=XFQqnMAlWD4Wx/jm9pbtAekk7xmQgNI78/V5lvp6UEsZp4JD4Qzf1jPRou5aVXtczH
         ahuwtEKLi1jWpmri9bGzcJUtQXcROAR52zC98/VcaKknAlV70iqsvCEQ4cDC+70KFEQS
         z5aG6Ds5QJAFmGBvmN5/7ZMQhkd965/GX7NDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :x-authenticated:x-provags-id:date:from:x-x-sender:to:cc:subject
         :in-reply-to:message-id:references:user-agent:mime-version
         :content-type:x-y-gmx-trusted:x-fuhafi:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=6TEP5tAK7Jopuzdgz96UKO+T3LUTmONoLrxcjN6qCWWaH7S+gHyLVNfcI7jRsDdoIt
         zFUZ1ZfXApIy4BHqZB9uw5YH38iZTsXc3VWQxqh7FqtpuUexu4h6OrjwkDqIkUkDjzXk
         B7355FTBdsTqoj9ngvb/kGan08j/TCiGVQenQ=
Received: by 10.90.35.9 with SMTP id i9mr473614agi.23.1238923976588;
        Sun, 05 Apr 2009 02:32:56 -0700 (PDT)
Received: by 10.177.2.5 with SMTP id e5gr4644yqi.0;
	Sun, 05 Apr 2009 02:32:56 -0700 (PDT)
X-Sender: Johannes.Schindelin@gmx.de
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.31.100 with SMTP id x36mr77933bkc.10.1238923975765; Sun, 05 Apr 2009 02:32:55 -0700 (PDT)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20]) by gmr-mx.google.com with SMTP id e3si148579fga.3.2009.04.05.02.32.55; Sun, 05 Apr 2009 02:32:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) client-ip=213.165.64.20;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.20 as permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
Received: (qmail invoked by alias); 05 Apr 2009 09:32:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38] by mail.gmx.net (mp048) with SMTP; 05 Apr 2009 11:32:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19owv03khpoSgrk7H3Zb9AVboPLpmVGvvhFuYJIn2 OtgI9CS3/0CD31
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200904041517.55890.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115641>


Hi,

On Sat, 4 Apr 2009, Markus Heidelberg wrote:

> Under Windows vimdiff and gvimdiff are not available as symbolic links, 
> but as batch files vimdiff.bat and gvimdiff.bat. These files weren't 
> found by 'type vimdiff' which led to the following error:
> 
>     The merge tool vimdiff is not available as 'vimdiff'
> 
> Even if they were found, it wouldn't work to invoke these batch files
> from git-mergetool.
> 
> To solve this, use vim and gvim (vim.exe and gvim.exe) and pass the -d
> command line switch over to them.
> 
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---
> 
> This patch goes on top of the current difftool/mergetool patches from David.

,.. which is a pity, because I could have applied them directly to 
msysGit's 'devel' branch otherwise.

Thanks,
Dscho
