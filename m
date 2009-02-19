From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Thu, 19 Feb 2009 07:49:18 +0100
Message-ID: <200902190749.19414.chriscool@tuxfamily.org>
References: <20090217060944.488184b0.chriscool@tuxfamily.org> <200902190632.50156.chriscool@tuxfamily.org> <43d8ce650902182202s4c06a261jd68a2f86607f00ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 07:51:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La2l2-00087e-V7
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 07:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbZBSGuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 01:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbZBSGuE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 01:50:04 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:54028 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbZBSGuD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 01:50:03 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 1B5934C80E7;
	Thu, 19 Feb 2009 07:49:53 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 1A2FA4C80B1;
	Thu, 19 Feb 2009 07:49:51 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <43d8ce650902182202s4c06a261jd68a2f86607f00ef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110632>

Le jeudi 19 f=C3=A9vrier 2009, John Tapsell a =C3=A9crit :
> 2009/2/19 Christian Couder <chriscool@tuxfamily.org>:
> > Le jeudi 19 f=C3=A9vrier 2009, Christian Couder a =C3=A9crit :
> >> But on Linux, log2 and exp2 are defined in "math.h" and available
> >> with:
>
> log2 in math.h is for doubles, when we only want an integer answer.
> There's no need for math.h here.

Yeah, you are right. Sorry about the noise. I will send a patch soon.

Thanks,
Christian.
