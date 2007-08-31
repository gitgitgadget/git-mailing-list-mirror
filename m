From: Johannes Sixt <j.sixt@telecom.at>
Subject: Re: [PATCH 1/2] Introduces xmkstemp()
Date: Fri, 31 Aug 2007 10:34:12 +0200
Message-ID: <46D7D284.30004@telecom.at>
References: <20070814164453.400b9c55@localhost> <46D7D0F7.1050302@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 10:35:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR1y9-0004bM-1u
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 10:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbXHaIfF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 04:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755142AbXHaIfF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 04:35:05 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58316 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755291AbXHaIfD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 04:35:03 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@telecom.at>)
	id 1IR1xz-0003kH-AN; Fri, 31 Aug 2007 10:34:59 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D883B4E4; Fri, 31 Aug 2007 10:34:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46D7D0F7.1050302@trolltech.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57134>

Marius Storm-Olsen schrieb:
> This functions needs to be further down in the file for
> MinGW builds, since mkstemp() is forward declared later
> in the file. So, something like this:

Please consider using the lates MinGW port. It's already fixed there.

-- Hannes
