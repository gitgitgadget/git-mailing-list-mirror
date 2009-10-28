From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 0/3] fix "git diff --color-words -U0"
Date: Wed, 28 Oct 2009 23:21:45 +0100
Message-ID: <200910282321.46585.markus.heidelberg@web.de>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de> <7v7hufo07i.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 23:24:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Gwr-0006eB-2t
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 23:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbZJ1WYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbZJ1WYq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 18:24:46 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:53549 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbZJ1WYp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 18:24:45 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 27573133F2744;
	Wed, 28 Oct 2009 23:21:40 +0100 (CET)
Received: from [89.59.65.242] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1N3Gtf-0001Dn-00; Wed, 28 Oct 2009 23:21:39 +0100
User-Agent: KMail/1.9.10
In-Reply-To: <7v7hufo07i.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/XRRM+RYeMmPTWpPtIWumjwnRsifhTguWxoAW6
	a4qLhVXC124nCJeR6afRgXPghIMuBArp/JWLgS0TtdGJ+LDbPu
	c68GvzGz24l57wp/z4aw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131504>

Junio C Hamano, 28.10.2009:
> Is this a serious enough breakage that deserves to be fixed in the
> maintenance track (1.6.5.X)?

This problem exists since the introduction of this feature over three
years ago and apparently nobody complained so far. So I don't think it's
overly serious.

OTOH, depending on the change the produced diff can be totally wrong.
Found a good example: c5022f576aa583429c245054d8600564b788ff33
Compare "--color-words -U0" with "--color-words -U1".
