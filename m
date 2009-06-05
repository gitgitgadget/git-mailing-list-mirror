From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] diesys calls die and also reports strerror(errno)
Date: Fri, 05 Jun 2009 08:25:02 +0200
Message-ID: <4A28BA3E.3090800@viscovery.net>
References: <20090603015503.GA14166@coredump.intra.peff.net> <1244081105-7149-1-git-send-email-aspotashev@gmail.com> <20090604205055.GB17478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alexander Potashev <aspotashev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 08:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCSrm-0006pd-Ei
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 08:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbZFEGZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 02:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbZFEGZH
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 02:25:07 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42514 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbZFEGZG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 02:25:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MCSrO-0006Qb-Hi; Fri, 05 Jun 2009 08:25:02 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3A9A54E4; Fri,  5 Jun 2009 08:25:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090604205055.GB17478@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120753>

Jeff King schrieb:
> On Thu, Jun 04, 2009 at 06:05:05AM +0400, Alexander Potashev wrote:
>> +void diesys(const char *err, ...)

Am I the only one who thinks that 'die_errno' would be a better name for
this function?

-- Hannes
