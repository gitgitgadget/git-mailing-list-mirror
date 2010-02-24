From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Fix a signal handler
Date: Wed, 24 Feb 2010 12:08:32 +0100
Message-ID: <4B8508B0.8070706@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net> <4B71A2EE.8070708@web.de> <4B72E81B.3020900@web.de> <20100210173348.GA5091@coredump.intra.peff.net> <4B76A985.9070809@web.de> <20100214064745.GC20630@coredump.intra.peff.net> <7vsk94qfuy.fsf@alter.siamese.dyndns.org> <4B7D6B7A.1090004@web.de> <7veikib96d.fsf@alter.siamese.dyndns.org> <4B82744B.4060805@web.de> <7v1vgdgm02.fsf@alter.siamese.dyndns.org> <4B839811.6040109@web.de> <7vmxyzfwt7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 12:08:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkF6c-0000P0-Pb
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 12:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688Ab0BXLIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 06:08:34 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:38725 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab0BXLId (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 06:08:33 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7E8D7148DD0A6;
	Wed, 24 Feb 2010 12:08:32 +0100 (CET)
Received: from [78.48.224.82] (helo=[192.168.1.202])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NkF6W-0003qY-00; Wed, 24 Feb 2010 12:08:32 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <7vmxyzfwt7.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+scyyb5xd445zstFUO6+daHNnq4LLLtHF4mtJs
	tkdYhJrsol4weyhrlciJrtbvVM5sdNHMmqFobrjmW7ZNg5mxSd
	aMOVjIeuqSYKbmh5yzVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140927>

> Just name one.

I do not know a concrete software platform so far where the misused assignment
of the function pointer in the signal handler implementation results in
unexpected effects that are directly noticeable like segmentation faults.

Regards,
Markus
