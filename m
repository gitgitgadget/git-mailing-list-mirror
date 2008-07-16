From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix buffer overflow in prepare_attr_stack
Date: Wed, 16 Jul 2008 17:21:27 +0200
Message-ID: <487E11F7.60601@viscovery.net>
References: <37fcd2780807160733o156e49c6m51314ff18764ccd5@mail.gmail.com> <1216220043-27678-1-git-send-email-dpotapov@gmail.com> <1216220043-27678-2-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 17:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ8qE-0004ui-ER
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 17:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759794AbYGPPVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 11:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760500AbYGPPVb
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 11:21:31 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:6485 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759794AbYGPPV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 11:21:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KJ8op-00038m-EY; Wed, 16 Jul 2008 17:21:27 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2E9DF6D9; Wed, 16 Jul 2008 17:21:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1216220043-27678-2-git-send-email-dpotapov@gmail.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88688>

Dmitry Potapov schrieb:
> +			pathbuf.len = 0;

+			strbuf_reset(&pathbuf);

-- Hannes
