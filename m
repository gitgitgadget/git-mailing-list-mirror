From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [tools-dev] Re: Git benchmarks at OpenOffice.org wiki
Date: Thu, 3 May 2007 14:54:25 +0200
Message-ID: <81b0412b0705030554jd8628d1tde8f5c1135900c95@mail.gmail.com>
References: <200705012346.14997.jnareb@gmail.com>
	 <200705021624.25560.kendy@suse.cz>
	 <200705030130.44018.jnareb@gmail.com>
	 <200705031351.40548.kendy@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: dev@tools.openoffice.org, "Jakub Narebski" <jnareb@gmail.com>,
	git@vger.kernel.org
To: "Jan Holesovsky" <kendy@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 03 14:54:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjapL-0000Gu-Re
	for gcvg-git@gmane.org; Thu, 03 May 2007 14:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031203AbXECMy2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 08:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031195AbXECMy2
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 08:54:28 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:24123 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031203AbXECMy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 08:54:27 -0400
Received: by an-out-0708.google.com with SMTP id b33so475870ana
        for <git@vger.kernel.org>; Thu, 03 May 2007 05:54:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eajF+nZLod/3nTfaOKrduPpZbJMc8ZOxMRHIKApi3uBekqdH/LbVItuba7YJRCo76+VGBgbEwotL7mBxvgUrl83GIraV/aDJz4fG2xarB9viDtGXBCZ6ie8yAtlrG1Eapgzn7vos4TxonTFBPSThl4lJUlD+VdMMgXxeEPehH/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hXTSlmVPJ3wIvD13sfMBNdDVvfRUIFGWJNKRRWlrwojWTn206oqFyelXBCrbHnaNo6zwuF/GBtUV/U4GNSWthw89glfE+acZ5nDAICq1GWXd+GKuUFV7UWLZMPzkVYC6QVaoqXL1OJ4x3bXieTvL1WCuuoJ//9Un4aDHkhXMITI=
Received: by 10.100.166.14 with SMTP id o14mr1466580ane.1178196866377;
        Thu, 03 May 2007 05:54:26 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 3 May 2007 05:54:25 -0700 (PDT)
In-Reply-To: <200705031351.40548.kendy@suse.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46084>

On 5/3/07, Jan Holesovsky <kendy@suse.cz> wrote:
> Last question: what is the status of the Win32 support?

It kind of works. Performance is horrible, but still better
than almost everything comparable (and there isn't anything
comparable). You have to be very careful not to push it
(them, actually: cygwin and windows) too hard: it is quick
to fall over taking down the whole machine with it (yes,
avoid Ctrl-C at all costs).
The repos have always been recoverable for me, though.

> I got a full clone using the Cygwin git 1.5.0 [it took 6hrs 20min
> on a Xen virtual machine; I have to try it with real hardware],
> MinGW version did not work for me too well :-(
>  Are there any other options?

Avoid Win32 if possible, work somewhere in a sane environment,
using windows for testing, if you have to.

> Is http://git.or.cz/gitwiki/WindowsInstall up-to-date?

Yes.
