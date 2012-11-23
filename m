From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Completion must sort before using uniq
Date: Fri, 23 Nov 2012 13:36:03 +0100
Message-ID: <003c01cdc977$1a8a60e0$4f9f22a0$@schmitz-digital.de>
References: <002201cdc952$00159c90$0040d5b0$@schmitz-digital.de> <CAFj1UpEMKq9zH3nbLwYrNZRmd52_KEcN5BBrzGg2jxCzd+fsbA@mail.gmail.com> <003b01cdc974$4cdd1900$e6974b00$@schmitz-digital.de> <2630847.8aaR79v5Od@blacky>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Marc Khouzam'" <marc.khouzam@gmail.com>, <git@vger.kernel.org>,
	<szeder@ira.uka.de>, <felipe.contreras@gmail.com>
To: "'Sascha Cunz'" <sascha-ml@babbelbox.org>
X-From: git-owner@vger.kernel.org Fri Nov 23 13:36:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbsUi-000767-2x
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 13:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab2KWMgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 07:36:17 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:58910 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896Ab2KWMgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 07:36:17 -0500
Received: from DualCore (dsdf-4db513fd.pool.mediaWays.net [77.181.19.253])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MFn1t-1TW53D41Dh-00FML5; Fri, 23 Nov 2012 13:36:15 +0100
In-Reply-To: <2630847.8aaR79v5Od@blacky>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHi9d0raPjCmP36XPHeqpAlu3F69wHEVUd4AV4PrmsBtr/hdZemORSg
Content-Language: de
X-Provags-ID: V02:K0:nLev4Orz8UuGx98TbZBhh0otc/IhT8ZK5POl4ZBPpMK
 4KnQl69xtSMimZ0meJH4M96SHrzbwgi+Ke45InFuLFrKuB81Eq
 O8DJBfiI9/JmzUmVEU5sZwtMrXIOYMSHi5JXLpCOpWSWN865hM
 o7KXSvdLjsDB3GaVBiqKZvEM4DyXJk3lNjQbcfwLNLD9eYPpJy
 tVIkFYOcdZf14kq+BFI4X0/wYOGGutCidoyvBu8XWamBeypQG3
 gXI0vM4GzHTW5GZneDwZLGPszTwcSS+k6AjP5tloP5vvhh+TEk
 i+AQJeEUZRsZv9+0mABE03lOxIrWH53wRe/ME1dIgIgUYNKcPE
 YGy7G5MBoHn6f5v6X65JOnSynHMwSYlPj0AWku6eyc6pU5QeB/
 4P/yMaWhrLozQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210255>

> From: Sascha Cunz [mailto:sascha-ml@babbelbox.org]
> Sent: Friday, November 23, 2012 1:26 PM
> To: Joachim Schmitz
> Cc: 'Marc Khouzam'; git@vger.kernel.org; szeder@ira.uka.de; felipe.contreras@gmail.com
> Subject: Re: [PATCH] Completion must sort before using uniq
> 
> > I can't see the difference and in fact don't understand uniq's -u option al
> > all Linux man pages say: "only print unique lines", but that is what uniq
> > does by default anyway?!?
> 
> From the german translation of uniq's man-page, you can deduct that "only
> print unique lines" actually means: "print lines that are _not repeated_ in
> the input".
> 
> A short test confirms that. i.e.:
> 
> 	printf "a\nb\nb\nc\n" | uniq -u
> 
> gives:
> 	a
> 	c

Ah, OK, then I rest my case. Sorry for the noise.
