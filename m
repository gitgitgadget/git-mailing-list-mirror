From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 17:36:57 +0600
Message-ID: <200702141736.57521.litvinov2004@gmail.com>
References: <45CFA30C.6030202@verizon.net> <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 12:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHIS0-0000fl-MN
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 12:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbXBNLhH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 14 Feb 2007 06:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbXBNLhH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 06:37:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:7144 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932221AbXBNLhG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Feb 2007 06:37:06 -0500
Received: by ug-out-1314.google.com with SMTP id 44so154464uga
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 03:37:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qUmrqTdb21SYZkKpVOT3Mcx/FylH8oOvHUGnfjf3eMHImn2ACW1hhSV6XUI6eW5jwQbAv+VAzy4LtC3Kx/6yiY6dY2P8NGLHpue1rOakadcUyeV76P5AgeVomoLz1lhT8fDcphzpwzf15d9lgFDB/4gdGC9V1bBYc4vZH2isX4Y=
Received: by 10.67.22.14 with SMTP id z14mr272814ugi.1171453024627;
        Wed, 14 Feb 2007 03:37:04 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id o24sm747184ugd.2007.02.14.03.37.03;
        Wed, 14 Feb 2007 03:37:03 -0800 (PST)
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39637>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Wednesday 14 February 2007 01:07 Linus Torvalds =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB:
> Actually, I did it myself.
>
> This is a "lazy man's auto-CRLF", and it really is pretty simple.

Wow ! Thanks.=20

I just tried this patch and it works! From now I can use git-cvsimport =
under=20
Linux and then clone it to cygwin and work there with full history. Nic=
e,=20
very nice. In my case text file detection work well as far most of our =
files=20
are .cpp and .h
