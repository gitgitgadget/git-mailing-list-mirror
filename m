From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW 
  and MSVC
Date: Thu, 17 Sep 2009 12:44:10 +0200
Message-ID: <4AB212FA.9080102@viscovery.net>
References: <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com> <1eeb32498237638df6d954dc65ab5372dd0f04c9.1253174364.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, gitster@pobox.com, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 12:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoETM-00059K-DZ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 12:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbZIQKoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 06:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbZIQKoL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 06:44:11 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:21515 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbZIQKoL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 06:44:11 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoETC-0001it-S1; Thu, 17 Sep 2009 12:44:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 88734BC81; Thu, 17 Sep 2009 12:44:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1eeb32498237638df6d954dc65ab5372dd0f04c9.1253174364.git.mstormo@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128742>

Marius Storm-Olsen schrieb:
> diff --git a/test-genrandom.c b/test-genrandom.c
> index 8ad276d..5849599 100644
> --- a/test-genrandom.c
> +++ b/test-genrandom.c
> @@ -6,6 +6,7 @@
>  
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include "git-compat-util.h"
>  
>  int main(int argc, char *argv[])
>  {

We usually #include *only* git-compat-util.h; you can remove stdio.h and
stdlib.h, as Alexey proposed.

-- Hannes
