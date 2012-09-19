From: Jan Engelhardt <jengelh@inai.de>
Subject: RE: [PATCH] Port to HP NonStop
Date: Wed, 19 Sep 2012 22:34:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1209192232590.19536@nerf07.vanv.qr>
References: <000101cd964e$06a255d0$13e70170$@schmitz-digital.de> <alpine.LNX.2.01.1209191945160.19536@nerf07.vanv.qr> <001601cd968f$d8d91ed0$8a8b5c70$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 22:34:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEQyW-00045Z-No
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 22:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784Ab2ISUeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 16:34:16 -0400
Received: from ares07.inai.de ([5.9.24.206]:52689 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab2ISUeP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 16:34:15 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id E267F96A1092; Wed, 19 Sep 2012 22:34:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id C0A4D96A108C;
	Wed, 19 Sep 2012 22:34:13 +0200 (CEST)
In-Reply-To: <001601cd968f$d8d91ed0$8a8b5c70$@schmitz-digital.de>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205996>

On Wednesday 2012-09-19 19:54, Joachim Schmitz wrote:

>> From: Jan Engelhardt [mailto:jengelh@inai.de]
>> Sent: Wednesday, September 19, 2012 7:48 PM
>> To: Joachim Schmitz
>> Cc: 'Junio C Hamano'; git@vger.kernel.org
>> Subject: Re: [PATCH] Port to HP NonStop
>> 
>> 
>> On Wednesday 2012-09-19 12:03, Joachim Schmitz wrote:
>> >+#ifdef NO_INTPTR_T
>> >+/*
>> >+ * On I16LP32, ILP32 and LP64 "long" is the save bet, however
>> >+ * on LLP86, IL33LLP64 and P64 it needs to be "long long",
>> >+ * while on IP16 and IP16L32 it is "int" (resp. "short")
>> >+ * Size needs to match (or exceed) 'sizeof(void *)'.
>> >+ * We can't take "long long" here as not everybody has it.
>> 
>> Are you trying to port git to DOS or why would you mention IP16? :-)
>
>Just for completness, nothing else ;-)

The problem would be that some, if not most, C environments in DOS offer 
a P16P32 model - thanks to (near void *) and (far void *).
