From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Fix $((...)) coding style
Date: Thu, 4 Feb 2016 13:38:51 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602041334450.2964@virtualbox>
References: <cover.1454587284.git.johannes.schindelin@gmx.de> <20160204121437.GF29880@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Elia Pinto <gitter.spiros@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Feb 04 13:39:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRJBe-0006eJ-Ey
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 13:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbcBDMjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 07:39:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:56869 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932604AbcBDMi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 07:38:57 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LoVBq-1ZpWS63ODi-00gV0U; Thu, 04 Feb 2016 13:38:52
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160204121437.GF29880@serenity.lan>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:0686XWmkCBBl7a8rr0Fg2JEPjAJjKPrXjfv5Is5rKff55hycD5o
 xUHPlxCo/0h/3Ri0zamhXFPAcXRIh4mXgDhV8KwqIMnBwWNbNm+NzXm7oQA2Yhn4Qph855P
 qxPPUcLEuwHoahF4MU69imasngOc08+Hk9rD6koUx2U0QwW9F3s3pJV9h7juft7nbAeOJrk
 W8cseFUD/9+Va2OBdsB1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cudTxXIMubs=:rgw4faA6V63b6SijAELK/M
 ThLUJ9cfFP+ymamCnfxPfmRiQUpPcmRW7M+0/CUz+XU9HYmdtvIRNXsHg/mA7KdlIGi+lgpxm
 h5ix7TBRBiYcGrsCSsdvFNqHJF1YZnwriOzhl/W9h8gWASG6c8LAhTYIVacdLFFi/y1G0jR+z
 ATdQHCRn+BXTPYZkm7OLhzEYTbkF7Qc/fKWL+s40YB/X0HGQawD7Tkb0/ZD/T88OU7/5I8j7e
 Jy+v4wVuPcq8pRsybaeEObvJfH9vJH9+JhpMAPLorC8CndSb0PD1YUfyCd6yB9Q5WdZ0YXAD+
 ZTNa8TlolGKVgwz0MvfXx0B/qPl/KU/iVMV+3yHq/czJ5/NQfOtGBLMFtZjSYwwatcMgwb1hM
 TMMB6R4qRA6Hvu9huzTlYFqG4LdHo23K7mwiS5GuehNXxxF9Djq216w/YXzNBggmGLVQYj0iI
 gXctPzVg2Vpi2bxbyHgC822XdAeL0nSYvzlDbNBbkFiHMwUKo3JDRKKhEiCfEUY16P0NHL7ka
 Na4BFsM0JAs2VMhsQmEoy51ccYz1X6+Vto+Zx81swoMLXLUXT5jAx1QY6s9PD/T5CMCZ03eNg
 WZwoehUB1RHBpd54n2Sum5Sk0y+lqBSjxxgF4srdYrGGqt+ZF6IOMI3FtAdlEi9xtE+kb3dTh
 mVIK0UoOyxPk/P5eLrdOAogXGH4lYxh7MdloLjWx4tZV0k+SXHNQ6B2M5IDIovHC0nbqCx4ux
 jYa+hCK9XPhDMVkCmCRBAV/4j3RLg350u7TWbPzubptF/rLaKRPLH37BPFjdKlBuTTSnJp4O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285460>

Hi John,

On Thu, 4 Feb 2016, John Keeping wrote:

> Using spaces around operators also matches our C coding style.

Well, by that reasoning you should go the whole nine yards and write

	lineno = $(( $lineno + 1 ))

Except you can't. Because shell code is inherently not like C code.

What I found particularly interesting about 180bad3 (rebase -i: respect
core.commentchar, 2013-02-11) was that it *snuck in* that coding style: it
*changed* the existing one (without rationale in the commit message, too).

Ciao,
Johannes
