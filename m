From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git push origin error (1.6.3 new default functionality)
Date: Wed, 13 May 2009 10:44:33 +0200
Message-ID: <4A0A8871.6080107@viscovery.net>
References: <81bfc67a0905111826y779555cer6679da11db787ab1@mail.gmail.com> <4A09594F.4040603@drmicha.warpmail.net> <81bfc67a0905122226p113e4aa5y2a3523ac63de77fc@mail.gmail.com> <20090513083203.GA25058@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Caleb Cushing <xenoterracide@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 10:46:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4A6E-0007Ag-Vq
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 10:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758557AbZEMIog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 04:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757512AbZEMIof
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 04:44:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31223 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758523AbZEMIoe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 04:44:34 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M4A4n-0007RN-Tb; Wed, 13 May 2009 10:44:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 552A954D; Wed, 13 May 2009 10:44:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090513083203.GA25058@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119007>

Context: This is about the warning that a plain "git push" produces if no
push refspec are configured. The default behavior is to push matching
branches.

Jeff King schrieb:
> Or are you proposing to still change the default behavior, but drop the
> warning whose aim is to inform people about the impending change? In
> that case, I think you should address the concerns that arose from
> previous changes in default behavior (and which this warning is meant to
> address), and propose an alternate plan for making the transition more
> smooth.

Unfortunately, the case with this warning is not that "simple" because it
is not about a planned change of the default behavior, but about a default
behavior that may be unexpected for newbies (see the release notes of
1.6.3). I *can* understand that Caleb is upset by the warning, since he's
comfortable with the (current and future) default behavior. But I don't
know what to do in cases like these.

-- Hannes
