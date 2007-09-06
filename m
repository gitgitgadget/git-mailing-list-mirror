From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 06 Sep 2007 17:45:22 +0200
Message-ID: <46E02092.9020805@eudaptics.com>
References: <20070902224213.GB431@artemis.corp>	<11890776114037-git-send-email-madcoder@debian.org>	<118907761140-git-send-email-madcoder@debian.org>	<Pine.LNX.4.64.0709061506330.28586@racer.site>	<20070906142155.GB3002@coredump.intra.peff.net>	<857in3dfad.fsf@lola.goethe.zz>	<20070906145035.GA3546@coredump.intra.peff.net> <85tzq7bzoz.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 17:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITJXx-00050v-EV
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 17:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019AbXIFPp2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 11:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757015AbXIFPp2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 11:45:28 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:29315 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757019AbXIFPp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 11:45:27 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ITJXm-0000fQ-TX; Thu, 06 Sep 2007 17:45:23 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 79DFD4E4; Thu,  6 Sep 2007 17:45:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <85tzq7bzoz.fsf@lola.goethe.zz>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.374, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57892>

David Kastrup schrieb:
> Jeff King <peff@peff.net> writes:
>> See ISO 9899:1999, section 6.7.8.
>>
>> Paragraph 10:
>>
>>   If an object that has automatic storage duration is not initialized
>>   explicitly, its value is indeterminate. If an object that has static
>>   storage duration is not initialized explicitly, then:
>>
>>   -- if it has pointer type, it is initialized to a null pointer;
> 
> That's actually a new one to me.  I don't think that it has been
> always the case in ANSI C.

AFAIR, this has always been the case.

-- Hannes
