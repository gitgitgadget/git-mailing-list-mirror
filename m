From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-commit: squelch needless message during an empty
 merge
Date: Thu, 13 Dec 2007 08:46:09 +0100
Message-ID: <4760E341.4070309@viscovery.net>
References: <20071022061115.GR14735@spearce.org>	<7vodeecyni.fsf@gitster.siamese.dyndns.org>	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org> <7v1w9r5m03.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 08:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2imB-00015x-Nb
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 08:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbXLMHqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 02:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755815AbXLMHqN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 02:46:13 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57039 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbXLMHqN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 02:46:13 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J2im5-0008Ah-HA; Thu, 13 Dec 2007 08:46:29 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8810969F; Thu, 13 Dec 2007 08:46:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v1w9r5m03.fsf_-_@gitster.siamese.dyndns.org>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68128>

Junio C Hamano schrieb:
> This introduces "nowarn" parameter to run_status() to avoid these
> useless messages.

Hmpf. We don't need no double negations, no?

-- Hannes
