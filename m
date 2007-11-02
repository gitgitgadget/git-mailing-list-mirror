From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict
 subset of remote ref
Date: Fri, 2 Nov 2007 12:14:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711021213370.4362@racer.site>
References: <1193593581312-git-send-email-prohaska@zib.de>
 <1193593581114-git-send-email-prohaska@zib.de> <1193593581486-git-send-email-prohaska@zib.de>
 <11935935812185-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de>
 <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de>
 <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de>
 <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org>
 <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org>
 <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org>
 <B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org>
 <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
 <0C176853-8848-46C8-AD7A-97F73274DC29@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 13:15:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InvQb-00044R-JU
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 13:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbXKBMOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 08:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbXKBMOw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 08:14:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:37373 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753018AbXKBMOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 08:14:51 -0400
Received: (qmail invoked by alias); 02 Nov 2007 12:14:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 02 Nov 2007 13:14:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GQuhbrKoGOspHzfxj15MO0S3d1VHizz6aDHKgMN
	oNi8qu39wO+xAh
X-X-Sender: gene099@racer.site
In-Reply-To: <0C176853-8848-46C8-AD7A-97F73274DC29@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63108>

Hi,

On Fri, 2 Nov 2007, Wincent Colaiuta wrote:

> Of course, it's too late too change now, but it would be nice if the 
> mirror of "fetch" were "send". (I know it's been commented in the past 
> that the fact that "push" and "pull" aren't mirror operations has 
> surprised quite a few people.)

Could you please just do

	git config --global alias.send push

and be done with it?

Hth,
Dscho
