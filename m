From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git-1.6.0.2-preview20080921 on Windows
Date: Sun, 21 Sep 2008 12:07:48 -0700 (PDT)
Message-ID: <m3od2hl3lv.fsf@localhost.localdomain>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de>
Reply-To: jnareb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysGit <msysgit@googlegroups.com>, Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sun Sep 21 21:09:09 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f60.google.com ([209.85.217.60])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhUIo-0001mG-1I
	for gcvm-msysgit@m.gmane.org; Sun, 21 Sep 2008 21:09:02 +0200
Received: by gxk20 with SMTP id 20so4705722gxk.21
        for <gcvm-msysgit@m.gmane.org>; Sun, 21 Sep 2008 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:received
         :received:x-authentication-warning:to:cc:subject:references:from
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :date:reply-to:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=Rst/X1edKbm3RiLGVbK696CnIeBeZgtK5wze9CK6pEE=;
        b=W++p2BygjPt7+g/apr4UzCLhqNv3RHHpwSTme/YgoDnyp9kvFmfjneYLbSDByGtfHe
         bA66fVowNwz8VL6nMDziDuOP3AGFALAQ1MAIWrtD27czPeq+HTE5lDcZfZZN8jmGZuZ8
         Mf0eObtxYFGPbXQ4Oq1i7HbrVVRS7SSVNFbPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:x-authentication-warning:to:cc
         :subject:references:from:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:date:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=cmj3woY2YxHkeWabrnAksJCI3jjqZMen4nh7eRybH73mgxiToVY1YHj5uGoNTU1mfJ
         K16v6uohyipPQLX4i21zWhQ1ethIV0/7Gc/aJ2kl4BGkHh1tQkVpJOCDf8JVIvgQf9O0
         9yTVLED1ZafRzK7iYRrGHSTLyuo6r8zIHwl1g=
Received: by 10.100.229.14 with SMTP id b14mr152342anh.17.1222024071919;
        Sun, 21 Sep 2008 12:07:51 -0700 (PDT)
Received: by 10.44.74.68 with SMTP id w68gr2944hsa.0;
	Sun, 21 Sep 2008 12:07:51 -0700 (PDT)
X-Sender: jnareb@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.90.117.17 with SMTP id p17mr2088365agc.27.1222024071020; Sun, 21 Sep 2008 12:07:51 -0700 (PDT)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154]) by mx.google.com with ESMTP id 22si6543688yxr.1.2008.09.21.12.07.49; Sun, 21 Sep 2008 12:07:51 -0700 (PDT)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 72.14.220.154 as permitted sender) client-ip=72.14.220.154;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 72.14.220.154 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by fg-out-1718.google.com with SMTP id l26so1178292fgb.26 for <msysgit@googlegroups.com>; Sun, 21 Sep 2008 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:received:received :x-authentication-warning:to:cc:subject:references:from:in-reply-to :message-id:lines:user-agent:mime-version:content-type:date; bh=dnOPpp7VdJDLS2+nDzTGJ58EyJz5XqoCOr5BgP4iMx4=; b=g4jtrNYifzDTg7XcdDj55EGduvbsoUr823offewNanaHQQ4AbVM88yVP7xll7RT5z/ 3BcIf0OS/V5+KsP5yVlMK/2M8ONf6fzfEXPeZDVhG7how4FYlXUDJEAjbLk49UgeOw8H zybkSfIvQCIg0RpSVFwkikJLnmvIhOXhxHATs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=x-authentication-warning:to:cc:subject:references:from:in-reply-to :message-id:lines:user-agent:mime-version:content-type:date; b=bkgS83LPQeOAqIvz9VgORvN+IKLQkDDIrI3iBLaNz/7nq8KZ8a/EQlh4ZfCoSzSXnK 0Jy2zrjw1uC0TRKarzxahOOD6gsmfCClAsmma+pYgFaW1NJuZf9vrh++0j+QYurloMvJ DZIBTZenfVO2m2l3EpNc5OE6NQn+5cyCmfazQ=
Received: by 10.86.79.19 with SMTP id c19mr4126621fgb.5.1222024069279; Sun, 21 Sep 2008 12:07:49 -0700 (PDT)
Received: from localhost.localdomain (abvi218.neoplus.adsl.tpnet.pl [83.8.206.218]) by mx.google.com with ESMTPS id l12sm5357879fgb.6.2008.09.21.12.07.45 (version=TLSv1/SSLv3 cipher=RC4-MD5); Sun, 21 Sep 2008 12:07:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1]) by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8LJ7gLp025337; Sun, 21 Sep 2008 21:07:43 +0200
Received: (from jnareb@localhost) by localhost.localdomain (8.13.4/8.13.4/Submit) id m8LJ7fbO025334; Sun, 21 Sep 2008 21:07:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96425>


Steffen Prohaska <prohaska@zib.de> writes:

> Git-1.6.0.2-preview20080921 for Windows is available at
> 
>      http://code.google.com/p/msysgit/downloads

Wouldn't it be better if this email had [ANNOUNCE] in the subject, to
be catched by mail2rss thingy that feeds Ohloh page for Git?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
