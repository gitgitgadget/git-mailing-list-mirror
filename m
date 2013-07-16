From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Tue, 16 Jul 2013 07:57:20 +0200
Message-ID: <51E4E0C0.3060604@viscovery.net>
References: <51E431F1.6050002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jul 16 07:57:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyyGX-0008Lx-AO
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 07:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab3GPF5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 01:57:33 -0400
Received: from so.liwest.at ([212.33.55.13]:18472 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409Ab3GPF5d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 01:57:33 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UyyGN-00050d-13; Tue, 16 Jul 2013 07:57:27 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 88AE21660F;
	Tue, 16 Jul 2013 07:57:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51E431F1.6050002@ramsay1.demon.co.uk>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230540>

Am 7/15/2013 19:31, schrieb Ramsay Jones:
> Sparse issues three "Using plain integer as NULL pointer" warnings.
> Each warning relates to the use of an '{0}' initialiser expression
> in the declaration of an 'struct object_info'.

I question the value of this warning. Initialization with '= {0}' is a
well-established idiom, and sparse should know about it. Also, plain 0
*is* a null pointer constant.

-- Hannes
