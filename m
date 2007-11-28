From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Replace instances of export VAR=VAL with VAR=VAL; export
 VAR
Date: Wed, 28 Nov 2007 15:39:14 +0100
Message-ID: <474D7D92.2000106@viscovery.net>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr> <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com> <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com> <474AC136.8060906@viscovery.net> <451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com> <Pine.LNX.4.64.0711261340470.27959@racer.site> <97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com> <7vir3m94ku.fsf@gitster.siamese.dyndns.org> <50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com> <7v1waa7lcv.fsf@gitster.siamese.dyndns.org> <1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com> <Pine.LNX.4.64.0711281355460.27959@racer.site> <474D7956.8050401@viscovery.net> <Pine.LNX.4.64.0711281428180.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 15:39:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxO4q-0003iA-NT
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 15:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759919AbXK1OjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 09:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759809AbXK1OjT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 09:39:19 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29058 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759833AbXK1OjS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 09:39:18 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IxO3c-00087I-Em; Wed, 28 Nov 2007 15:38:33 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DF4244E4; Wed, 28 Nov 2007 15:39:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711281428180.27959@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66347>

Johannes Schindelin schrieb:
> Hi,
> 
> On Wed, 28 Nov 2007, Johannes Sixt wrote:
> 
>> Johannes Schindelin schrieb:
>>> -			s/.*/export GIT_'$uid'_NAME='\''&'\''/p
>>> +			s/.*/GIT_'$uid'_NAME='\''&'\''\nexport
>>> GIT_'$uid'_NAME/p
>> Recently there was a report that \n in the substitution side of s/// is not
>> supported by all seds :-(
> 
> Okay, how about replacing the line with
> 
> +			s/.*/GIT_'$uid'_NAME='\''&'\''\
> +export GIT_'$uid'_NAME/p
> 
> Hmm?  (It works here.)

This looks good. The other case I'm refering to was also solved in this way.

-- Hannes
