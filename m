From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v4 07/10] send-email: reduce dependancies impact on parse_address_line
Date: Thu, 18 Jun 2015 13:39:20 +0200
Message-ID: <vpqh9q56yaf.fsf@anie.imag.fr>
References: <1434550720-24130-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1434550720-24130-7-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<xmqqioam58kz.fsf@gitster.dls.corp.google.com>
	<989982277.592587.1434584914349.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 18 13:40:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5YAR-0007mx-BL
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbbFRLjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:39:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59201 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754252AbbFRLj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:39:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5IBdJKE006403
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Jun 2015 13:39:21 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5IBdKXb030625;
	Thu, 18 Jun 2015 13:39:20 +0200
In-Reply-To: <989982277.592587.1434584914349.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Thu, 18 Jun 2015 01:48:34 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 18 Jun 2015 13:39:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5IBdJKE006403
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435232362.32029@1kshppg0FpmL+CCNWsdnNQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271998>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> I've some more tests, maybe I should put them all in this post ?

Yes, please post as much as you have. Ideally, this should be
automatically tested, but if you don't have time to write the automated
tests, at least having a track of what you did on the list archives can
help someone else to do it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
