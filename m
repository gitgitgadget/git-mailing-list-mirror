From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Added options NO_TCLTK, WITH_P4IMPORT and --with-tcltk/--without-tcltk.
Date: Mon, 26 Mar 2007 09:30:49 +0100
Message-ID: <200703261030.49382.jnareb@gmail.com>
References: <etpuen$2uo$2@sea.gmane.org> <20070326073143.GB44578@codelabs.ru> <20070326073250.GC44578@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Mon Mar 26 10:28:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVkZ3-0004RK-Op
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 10:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbXCZI1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 04:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbXCZI1v
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 04:27:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:35833 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbXCZI1u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 04:27:50 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1527253uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 01:27:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bR6jQkETZNtRP7IAd47W+u28EI5HaqgMWEUS2rcFz3yVfQbGYnJ4JH6I5w37npyyZNBWXKaBWopQi3TSlcuIOny4aZdrlfls4CWNaq/ysiQ0MlTDtRkNWY/YA79JqdAgo4aJdj9OhJ0Icqqct5xAzshm5T5v8Jpqf0weNsjO4Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kFX8MCoPAw5gXaLiMeBfaXu0uc8JL3iYbTXpnfqaZhjGb79baZYEjaCdjDD/VVRIT0V/PFJBP+Sjt1AsWR5Ra3KHM/FhJvappsKbb1952zyn0Kt+7pI1bTTKYdTZoNIWdnkvDn+HSySpHlzGodR5GlivkGJUQywMDiaEP5UzI+k=
Received: by 10.66.219.11 with SMTP id r11mr11774381ugg.1174897669272;
        Mon, 26 Mar 2007 01:27:49 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y6sm20470802mug.2007.03.26.01.27.47;
        Mon, 26 Mar 2007 01:27:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070326073250.GC44578@codelabs.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43129>

Thanks a lot for the patch, but...

Eygene Ryabinkin wrote:

> Internal make option TCLTK was added: it governs the location of
> the Tcl/Tk interpreter, so user can specify its own binary location
> either with './configure --with-tcltk=/path/to/binary' or
> 'TCLTK=/path/to/binary make'.

...shouldn't it be TCLTK_PATH?
-- 
Jakub Narebski
Poland
