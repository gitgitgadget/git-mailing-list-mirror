From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2 v2] Add strbuf_vaddf(), use it in strbuf_addf(), and
 add   strbuf_initf()
Date: Thu, 06 Mar 2008 17:47:21 +0100
Message-ID: <47D02019.4000500@viscovery.net>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>  <alpine.LSU.1.00.0802281159550.22527@racer.site>  <200803052221.12495.johannes.sixt@telecom.at>  <alpine.LSU.1.00.0803052317350.15786@racer.site>  <7vir00lski.fsf@gitster.siamese.dyndns.org>  <alpine.LSU.1.00.0803052327570.15786@racer.site>  <alpine.LSU.1.00.0803060212170.15786@racer.site>  <20080306063331.GA7325@glandium.org>  <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>  <alpine.LSU.1.00.0803061153400.15786@racer.site> <3f4fd2640803060353w70651522w4b3896b8106b01c0@mail.gmail.com> <alpine.LSU.1.00.0803061319590.15786@racer.site> <alpine.LSU.1.00.0803061727120.3941@racer.site> <47D01E0D.1090801@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Reece Dunn <msclrhd@googlemail.com>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 17:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXJGK-00028C-4z
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 17:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764838AbYCFQr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 11:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764616AbYCFQrZ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 11:47:25 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40635 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762591AbYCFQrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 11:47:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JXJEw-0001gE-8k; Thu, 06 Mar 2008 17:46:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EB68C6D9; Thu,  6 Mar 2008 17:47:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47D01E0D.1090801@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76398>

Johannes Sixt schrieb:
> You did not cater for PRIuMAX, which is %llu except on Windows, where it
> is %I64u. We can make it %llu on Windows only if we can ensure that none
> of its uses ends up in a regular *printf function!

Oh, well, PRIuMAX is *only* used in regular *printf and in die() calls.
That's fine, too.

-- Hannes

