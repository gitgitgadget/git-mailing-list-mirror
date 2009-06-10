From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 10/11 v2] Fix warnings in nedmalloc when compiling with
 GCC 4.4.0
Date: Wed, 10 Jun 2009 11:27:28 +0200
Message-ID: <4A2F7C80.1090807@viscovery.net>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-4-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de> <1243786525-4493-6-git-send-email-prohaska@zib.de> <1243786525-4493-7-git-send-email-prohaska@zib.de> <1243786525-4493-8-git-send-email-prohaska@zib.de> <1243786525-4493-9-git-send-email-prohaska@zib.de> <1243786525-4493-10-git-send-email-prohaska@zib.de> <1243786525-4493-11-git-send-email-prohaska@zib.de> <7vhbz0mmai.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de> <7vr5y3lxrj.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302> <7viqjefxcv.fsf@alter.siame se.dyndns.org> <alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302> <7vprdl9qon.fsf@alter.siames
 e.dyndns.org> <alpine.DEB.1.00.0906081645490.4461@intel-tinevez-2-302> <7vzlcizn3w.fsf@a! lter.siamese.dyndns.org> <CD46A3E1-A85C-4D03-854C-973B91ACC506@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 11:27:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEK5u-0005ZQ-4j
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 11:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755766AbZFJJ1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 05:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbZFJJ1b
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 05:27:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12604 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753651AbZFJJ1b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 05:27:31 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MEK5h-00014P-VX; Wed, 10 Jun 2009 11:27:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id AC4F5C6C1; Wed, 10 Jun 2009 11:27:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <CD46A3E1-A85C-4D03-854C-973B91ACC506@zib.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121265>

Steffen Prohaska schrieb:
> 
> On Jun 8, 2009, at 6:50 PM, Junio C Hamano wrote:
> 
>> Steffen, can we move the series, with this patch replaced, to 'next' now?
>> I think it looks good (thanks!) but again it would not hurt to ask
>> just to
>> make sure ;-).
> 
> I agree, it looks good.  Thanks.

Please don't advance this series to master just yet: I see severe breakage
with the nedmalloc patch on one of my systems, but I ran out of time to
investigate further. (And I'm afraid I can continue only next Monday.)

-- Hannes
