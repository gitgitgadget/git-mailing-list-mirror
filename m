From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Wed, 17 Jul 2013 07:47:32 +0200
Message-ID: <51E62FF4.60809@viscovery.net>
References: <51E431F1.6050002@ramsay1.demon.co.uk> <51E4E0C0.3060604@viscovery.net> <20130716062122.GA4964@sigill.intra.peff.net> <6BDA2E3E7318418BBB2C19B475B2B118@PhilipOakley> <51E5B8BD.8090202@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 07:47:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzKaV-0001Rq-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 07:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab3GQFrk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 01:47:40 -0400
Received: from so.liwest.at ([212.33.55.13]:46470 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751520Ab3GQFrj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 01:47:39 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UzKaL-0006YA-UR; Wed, 17 Jul 2013 07:47:34 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 763AE1660F;
	Wed, 17 Jul 2013 07:47:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51E5B8BD.8090202@googlemail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230600>

>>>> I question the value of this warning. Initialization with '=
>>>> {0}' is a well-established idiom, and sparse should know about
>>>> it.

Thanks everyone for your feedback. But I really wanted to call only the
warning in the case of the '= {0}' idiom into question, not about 0 vs.
NULL in general.

-- Hannes
