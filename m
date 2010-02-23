From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Fix a signal handler
Date: Tue, 23 Feb 2010 10:10:29 +0100
Message-ID: <4B839B85.4040608@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net> <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net> <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de> <7veikib96d.fsf@alter.siamese.dyndns.org> <4B82744B.4060805@web.de> <7v1vgdgm02.fsf@alter.siamese.dyndns.org> <4B839811.6040109@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 10:10:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njqmr-0007hE-6t
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 10:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254Ab0BWJKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 04:10:30 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:59696 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124Ab0BWJK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 04:10:29 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 59601148A35DA;
	Tue, 23 Feb 2010 10:10:28 +0100 (CET)
Received: from [78.49.33.20] (helo=[192.168.1.202])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Njqmi-00065v-00; Tue, 23 Feb 2010 10:10:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <4B839811.6040109@web.de>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX190rariLVOBBsr/qzkW9AuCmf5nYBkW3B778uXJ
	EdooREvipg+wF98DqV3/pFROwOLka8Pbycxpbi7o+LNB2DBaof
	i7rBv/VVFznReu/nUDDA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140779>

> Other means would be needed to transfer corresponding state changes to the function "path_name".

I'm sorry for a potential confusion. - The function "limit_list" is the intended
call site so far.

Regards,
Markus
