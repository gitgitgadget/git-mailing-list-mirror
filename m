From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [RF sanity check] send-email threading fixes (was Re: [PATCH 3/6] send-email: fix threaded mails without chain-reply-to)
Date: Thu, 11 Jun 2009 18:49:39 +0200
Message-ID: <200906111849.40232.markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de> <7vhbyo1vr7.fsf@alter.siamese.dyndns.org> <7v63f4v9sl.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 18:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEnT3-0002mt-Kz
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 18:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173AbZFKQtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 12:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760798AbZFKQtV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 12:49:21 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:58048 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757173AbZFKQtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 12:49:19 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id D2C0FFF76C14;
	Thu, 11 Jun 2009 18:49:21 +0200 (CEST)
Received: from [89.59.73.219] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MEnSr-0004ZR-00; Thu, 11 Jun 2009 18:49:21 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7v63f4v9sl.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18QHgkzFYZRNM/ZITswzG1siQTQgq8gNA/uZ1mM
	A3Kw8sABrS9gCuVHrCdTsS+XOUYsnr1Mu2t9rpqqpq9bL+Jmn8
	YUeCeNMQVpLgMt+4jZCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121349>

Junio C Hamano, 10.06.2009:
> In any case, here is what I came up with by reshuffling your six patches.
> 
> [PATCH 1/6] add a test for git-send-email for non-threaded mails
> [PATCH 2/6] send-email: fix non-threaded mails
> [PATCH 3/6] doc/send-email: clarify the behavior of --in-reply-to with --no-thread
> [PATCH 4/6] send-email: fix threaded mails without chain-reply-to
> [PATCH 5/6] add a test for git-send-email for threaded mails without chain-reply-to
> [PATCH 6/6] send-email: fix a typo in a comment
> 
> Patch 4/6 applies on top of 15da108 to fix a breakage introduced by that
> commit.  Together with the result of applying the first three patches to
> maint, they fix --no-thread and --thread (without --chain-reply-to) cases.
> The result can be verified by applying Patch 5/6 on top of them.

Out of curiosity: why are 4/6 and 5/6 applied on different branches
without the usual commits first "test with test_expect_fail" then "fix +
test changed to test_expect_success"?
