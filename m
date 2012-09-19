From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH] Port to HP NonStop
Date: Wed, 19 Sep 2012 19:48:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1209191945160.19536@nerf07.vanv.qr>
References: <000101cd964e$06a255d0$13e70170$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 19:48:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOO0-0002ut-7P
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 19:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775Ab2ISRsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 13:48:23 -0400
Received: from ares07.inai.de ([5.9.24.206]:51978 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932715Ab2ISRsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 13:48:22 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id B806296A108F; Wed, 19 Sep 2012 19:48:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id 94BB096A108C;
	Wed, 19 Sep 2012 19:48:21 +0200 (CEST)
In-Reply-To: <000101cd964e$06a255d0$13e70170$@schmitz-digital.de>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205960>


On Wednesday 2012-09-19 12:03, Joachim Schmitz wrote:
>+#ifdef NO_INTPTR_T
>+/*
>+ * On I16LP32, ILP32 and LP64 "long" is the save bet, however
>+ * on LLP86, IL33LLP64 and P64 it needs to be "long long",
>+ * while on IP16 and IP16L32 it is "int" (resp. "short")
>+ * Size needs to match (or exceed) 'sizeof(void *)'.
>+ * We can't take "long long" here as not everybody has it.

Are you trying to port git to DOS or why would you mention IP16? :-)
