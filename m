From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Port to HP NonStop
Date: Wed, 19 Sep 2012 19:54:41 +0200
Message-ID: <001601cd968f$d8d91ed0$8a8b5c70$@schmitz-digital.de>
References: <000101cd964e$06a255d0$13e70170$@schmitz-digital.de> <alpine.LNX.2.01.1209191945160.19536@nerf07.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
To: "'Jan Engelhardt'" <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:55:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOUC-0006AU-1P
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859Ab2ISRyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:54:47 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:49274 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932718Ab2ISRyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:54:46 -0400
Received: from DualCore (dsdf-4d0a1993.pool.mediaWays.net [77.10.25.147])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MbxjC-1SxPIT3iyc-00IunW; Wed, 19 Sep 2012 19:54:44 +0200
In-Reply-To: <alpine.LNX.2.01.1209191945160.19536@nerf07.vanv.qr>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQFMdLLbfkMGN4L+ay/JCcMH3R8/WwGpV7cXmIbrdbA=
Content-Language: de
X-Provags-ID: V02:K0:0Rzv+3pM1ck3hE20+yU1iNvUbS0F/PE5qpPQGC4UTWE
 7JMdxtQ7Vxo54zLMve0N3FeQyEDL4SoNtKdYcatpGZgQCbnvg7
 30QbiAwXRx4LiQd2rdnYChNwWY6yLR0ptqUPtbUEi7hauv1Vzl
 Kkg9O7CI69Us698yNoZOJhSOiZabFu8ithY6VXzXXU7Zp77jRN
 y8E1cmHZadSJfU0NKDM81Ys72kP4c1AEGV4xfAzrTC75yEUqux
 +H7ODLQoK/3qdONA5ydFWNtOStTrfq9L4P6FNh+NOGTRof2Tfw
 NZlm0e5LxgTsN/Mkw7JIPsNyu2PKfHVcGgDb6hN0rG6s5oy+MG
 8scAhYM08u5ZNyG97ZaA+oECwnLLfautiVNQDQksm9Axqfza3W
 fFqWk1GWsyCaA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205962>

> From: Jan Engelhardt [mailto:jengelh@inai.de]
> Sent: Wednesday, September 19, 2012 7:48 PM
> To: Joachim Schmitz
> Cc: 'Junio C Hamano'; git@vger.kernel.org
> Subject: Re: [PATCH] Port to HP NonStop
> 
> 
> On Wednesday 2012-09-19 12:03, Joachim Schmitz wrote:
> >+#ifdef NO_INTPTR_T
> >+/*
> >+ * On I16LP32, ILP32 and LP64 "long" is the save bet, however
> >+ * on LLP86, IL33LLP64 and P64 it needs to be "long long",
> >+ * while on IP16 and IP16L32 it is "int" (resp. "short")
> >+ * Size needs to match (or exceed) 'sizeof(void *)'.
> >+ * We can't take "long long" here as not everybody has it.
> 
> Are you trying to port git to DOS or why would you mention IP16? :-)

Just for completness, nothing else ;-)
