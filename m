From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently
 processed
Date: Thu, 20 Jun 2013 08:56:04 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1306200853250.7267@ds9.cixit.se>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr> <alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se> <c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr> <alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se>
 <0b88af05ea8d4723a870476036992abc@ensibm.imag.fr> <51BF26F9.1080900@viscovery.net> <7vvc5cg0i8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?Mathieu_Li=E9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>, git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 09:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpZjB-00050l-7I
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 09:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab3FTH4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 03:56:17 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:47788 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753085Ab3FTH4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 03:56:16 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r5K7u4oo009996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 20 Jun 2013 09:56:04 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r5K7u4CE009992;
	Thu, 20 Jun 2013 09:56:04 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7vvc5cg0i8.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 20 Jun 2013 09:56:04 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228447>

Junio C Hamano:

> But my understanding is that the reordering using printf() is the 
> mechanism we suggest l10n folks to use when the order of parameters 
> given to printf does not match the preferred word order in the 
> message in their language.

It's documented in the gettext manual, and seems to be used in the 
zh_CN.po to change the word order in quite a few places.

-- 
\\// Peter - http://www.softwolves.pp.se/
