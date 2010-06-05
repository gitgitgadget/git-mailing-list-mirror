From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Installing on AIX fails
Date: Sat, 05 Jun 2010 04:44:47 -0700 (PDT)
Message-ID: <m3631xr9bm.fsf@localhost.localdomain>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<AANLkTik_FI0CETWZZcu8O8MQQx5oV6YAbt5-X0ozbVmw@mail.gmail.com>
	<AANLkTikkGtRmbsKD3JnQEWrhXQexH7J6SWEd9Aq3iQU_@mail.gmail.com>
	<AANLkTilnFXUI9hnVJlAylCzTUqOStZAFvtgvNrh8Kisj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dario Rodriguez <soft.d4rio@gmail.com>, git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Sat Jun 05 13:45:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKro7-0006rv-0I
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 13:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933181Ab0FELou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 07:44:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39988 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119Ab0FELot (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 07:44:49 -0400
Received: by fxm8 with SMTP id 8so1261411fxm.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 04:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=rhRTgqbJ01MCz2eG8v50gkh4vWo5H2YeR1FvG/lUBG0=;
        b=jEiA4zNzAf5GkuO2T30e+317wSu2aWyeI9iL8e3R6qJkA5QLUI6Ruj451XgoDHpiu6
         4HQKaa3MgkpuDviBrYUjsD97wJYLc9nmGtsIBtztqdpgn6rrC64gd/+V6QStYMGtNY82
         SiPo7E8u6WNoCCsxOHLRSddqiNiylriV/ZnPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vr6mkfw/fxtGLG98dOV6b3McnDyMuNygeQGeV+NLwP16E0Q1KY7gTZyRJydywmIIdx
         D/sWngx3sCj4GlenkDnH0r5oAgpvBo5XDoGrbCysi8fEjmyR/N3zlxZD3omZFL/cGFwX
         /ZCpQv6i2Acfj+fS5o20cCVYH8BIBuSrHFB7Y=
Received: by 10.223.24.85 with SMTP id u21mr697099fab.8.1275738287752;
        Sat, 05 Jun 2010 04:44:47 -0700 (PDT)
Received: from localhost.localdomain (aehn204.neoplus.adsl.tpnet.pl [79.186.195.204])
        by mx.google.com with ESMTPS id 2sm10031606fav.1.2010.06.05.04.44.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 04:44:47 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o55BkXIh004387;
	Sat, 5 Jun 2010 13:46:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o55BkL9s004381;
	Sat, 5 Jun 2010 13:46:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTilnFXUI9hnVJlAylCzTUqOStZAFvtgvNrh8Kisj@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148468>

Tor Arntsen <tor@spacetec.no> writes:
> On Fri, Jun 4, 2010 at 16:22, Dario Rodriguez <soft.d4rio@gmail.com> wrote:

> > I'ill try compiling 'install' (i don't know where the sources are)
> 
> It's in 'coreutils' these days, but that package includes a lot of stuff.
> 
> Maybe you could get away with just using the script-version of install
> which comes with coreutils itself (because it'll need an install tool
> to use before 'install' itself is installed..).
> 
> I'm attaching a copy. To use it it should be sufficient to use
> INSTALL=path-to/install-sh make install
> or something like that.

I wonder if it would be better to simply include fallback portable
install-sh in git sources.

BTW. shouldn't we define and use INSTALL_D in Makefile?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
