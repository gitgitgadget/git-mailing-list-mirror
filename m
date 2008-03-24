From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Store autocrlf during init-db (was [msysGit] autocrlf
 problems with Git-preview20080301.exe)
Date: Mon, 24 Mar 2008 15:21:53 +0300
Message-ID: <20080324122153.GF25381@dpotapov.dyndns.org>
References: <alpine.LSU.1.00.0803230310500.4353@racer.site> <alpine.OSX.1.00.0803230943500.7541@cougar> <alpine.LSU.1.00.0803231200010.4353@racer.site> <alpine.OSX.1.00.0803231326290.11994@cougar> <alpine.LSU.1.00.0803231404390.4353@racer.site> <alpine.OSX.1.00.0803231428220.13789@cougar> <20080323235610.GB25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803240101220.4353@racer.site> <20080324002302.GD25381@dpotapov.dyndns.org> <alpine.LSU.1.00.0803241155300.4353@racer.site>
Reply-To: dpotapov@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, Junio C Hamano <junio@pobox.com>, tormod.hystad@gmail.com, msysGit <msysgit@googlegroups.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Mar 24 13:22:55 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdlhJ-0005hd-4n
	for gcvm-msysgit@m.gmane.org; Mon, 24 Mar 2008 13:22:41 +0100
Received: by wa-out-0708.google.com with SMTP id n36so2238405wag.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 24 Mar 2008 05:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=gamma;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=vkn/hRsXt1XAL0cds8O7sxWUH1kJeVjGJma+cEtbzbc=;
        b=2rLhyOuvaFxHlY4j2XxVSllW3DQt3NtkqR8mxCKw0seNUaZA2oDII5AfVWjlXPd/etMfSrOLPcEAIJ5Tz+LfsstQE5pRh7f/gvsq+bhmM/Y7YfkU5qazrKT6H1PrdklvEhs12bkidRE90Eq20iKs+gzSiP1DVmzEwLMsOzCw4Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=gamma;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=z9nrDEz5eLOBjwPeHwuIgqkMFAP6hiw5o8eedH2FaYFKPOm77MXBQPgJDyBRRXaAAIrNtr0pGv7UJDS924TOD21PIP1ViV3z+4b0iUodhr4NROfASvvga24wgB3PfNZPXt94SIiktjq6HRIgfWhTb4R1jTW5NZnoLyn0sdZBbzA=
Received: by 10.114.57.1 with SMTP id f1mr1445985waa.5.1206361320808;
        Mon, 24 Mar 2008 05:22:00 -0700 (PDT)
Received: by 10.44.190.49 with SMTP id n49gr2013hsf.0;
	Mon, 24 Mar 2008 05:22:00 -0700 (PDT)
X-Sender: dpotapov@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.35.14.4 with SMTP id r4mr7759323pyi.2.1206361320138; Mon, 24 Mar 2008 05:22:00 -0700 (PDT)
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185]) by mx.google.com with ESMTP id x46si9142737pyg.2.2008.03.24.05.21.58; Mon, 24 Mar 2008 05:22:00 -0700 (PDT)
Received-SPF: pass (google.com: domain of dpotapov@gmail.com designates 64.233.182.185 as permitted sender) client-ip=64.233.182.185;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of dpotapov@gmail.com designates 64.233.182.185 as permitted sender) smtp.mail=dpotapov@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by nf-out-0910.google.com with SMTP id c7so1104324nfi.35 for <msysgit@googlegroups.com>; Mon, 24 Mar 2008 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta; h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; bh=63yBZaI1RD2ipiZ+b3dL/8cYViSsexooyCX5cmP4Cpw=; b=AblyY4D2U1EqC4Xzwsws2/BIO6v8r2k/piIsxvXzl4cLgGczhOn9PaDY/iFjkSwt3AD+2noBrtjJtlkFRNYjG6vUDldfyMN7AAeWO7qVyvMBKOrTAiWx1BJ3h9r91aivITTlCRMes11JiZrgdTcm55sEhEHL8Rp0JZAoTWwpebw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=beta; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent; b=i5PfTmVatAH+JuzbedYbiHXx4ErWcmkd3xBVljXsG8MIzjHgTl+D4qJQ1QOfQ/Gj9+16FAvXAaRiAjgkGL/ATMn5KOiuggqXYFEhFPeqS1LAT9N5tUwLB2m+X5bCMeI76jIjGIlWQwDO4tr+3xfI9mn5slzItdI2zoV8aigoib4=
Received: by 10.78.139.14 with SMTP id m14mr20582402hud.40.1206361317312; Mon, 24 Mar 2008 05:21:57 -0700 (PDT)
Received: from localhost ( [85.140.170.114]) by mx.google.com with ESMTPS id e8sm26299434muf.8.2008.03.24.05.21.55 (version=TLSv1/SSLv3 cipher=OTHER); Mon, 24 Mar 2008 05:21:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803241155300.4353@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78027>


On Mon, Mar 24, 2008 at 11:57:19AM +0100, Johannes Schindelin wrote:
> 
> I think I actually suggested something like that.  But that gets only even 
> more complicated: if you have a template for .git/config in 
> $HOME/.gittemplates/, then the global template will be _disregarded_, even 
> if the administrator puts something vital in there.

Maybe, because I cannot imagine what so vital the administrator can put
in it, I really do not see that as a problem. I believe that any good
administrator should notify all users about any vital changes anyway, 
because if these changes are vital, it may be necessary not only change
templates in $HOME/.gittemplates/ (which very few users will probably
have), but perhaps also in existing repositories...

> 
> Maybe the best idea would be an "init" hook, settable from the config, 
> after all.

I agree that seems to be the best solution as it is more flexible than
having $HOME/.gittemplates/.

Dmitry
