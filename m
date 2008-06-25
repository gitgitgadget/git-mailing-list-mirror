From: "Craig L. Ching" <cching@mqsoftware.com>
Subject: RE: [PATCH] cmd_reset: don't trash uncommitted changes unless toldto
Date: Wed, 25 Jun 2008 09:49:16 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302389C2C@emailmn.mqsoftware.com>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <1214389498.6634.10.camel@localhost> <20080625104605.GA10322@atn.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Boaz Harrosh" <bharrosh@panasas.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, <git@vger.kernel.org>,
	<jeske@google.com>
To: "Anton Gladkov" <agladkov@parallels.com>,
	"Matthias Kestenholz" <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Wed Jun 25 16:51:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBWKA-0002h8-CG
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 16:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbYFYOtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 10:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbYFYOtV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 10:49:21 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:26531 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYFYOtV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 10:49:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20080625104605.GA10322@atn.sw.ru>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cmd_reset: don't trash uncommitted changes unless toldto
Thread-Index: AcjWsMjo+pbXYjayQlWaBUZfiQ8tPwAIUcHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86284>

 

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Anton Gladkov
> Sent: Wednesday, June 25, 2008 5:46 AM
> To: Matthias Kestenholz
> Cc: Johannes Schindelin; Boaz Harrosh; Junio C Hamano; Steven 
> Walter; git@vger.kernel.org; jeske@google.com
> Subject: Re: [PATCH] cmd_reset: don't trash uncommitted 
> changes unless toldto
> 
> Because 'checkout' in other SCMs like CVS or SVN means 'get 
> latest data from repo', i.e. it acts like 'pull' or 'fetch' in git.
> And 'branch' means branch manipulation: creating, deleting, 
> switching...
> 
Checkout, for me and a lot of people I work with, never meant "get
latest data from repo", it always meant "get me a workspace".  Anyway,
just sharing a dissenting opinion, I don't agree that the checkout verb
is used incorrectly in git.


> --
> Best regards,
> 		Anton
> mailto:agladkov@parallels.com
> --

Cheers,
Craig
