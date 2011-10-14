From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t1402-check-ref-format: skip tests of refs beginning
 with slash on Windows
Date: Fri, 14 Oct 2011 08:40:53 +0200
Message-ID: <4E97D975.6070305@viscovery.net>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu> <4E969BFC.50706@viscovery.net> <7vfwiw33bf.fsf@alter.siamese.dyndns.org> <7vbotk32zm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 08:41:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REbS9-0004iJ-Ql
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 08:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab1JNGlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 02:41:04 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8450 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1JNGlD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 02:41:03 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1REbRu-0005IZ-HR; Fri, 14 Oct 2011 08:40:54 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 28F8A1660F;
	Fri, 14 Oct 2011 08:40:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <7vbotk32zm.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183541>

Am 10/14/2011 1:07, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> +invalid_ref NOT_MINGW '/'
>>> ...
>>> +valid_ref_normalized '/heads/foo' 'heads/foo' NOT_MINGW
>>
>> The inconsistencies strikes me a bit.
> 
> Here is what I tentatively will queue.

The patch looks good, and the test cases pass as expected.

Thank you very much,
-- Hannes
