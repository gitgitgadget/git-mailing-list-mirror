From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Try harder in parse_tag; perhaps it was given ambiguous name
Date: Tue, 04 Dec 2007 23:01:34 -0800
Message-ID: <7v3auh1v75.fsf@gitster.siamese.dyndns.org>
References: <200712010245.29204.jnareb@gmail.com>
	<200712010247.25107.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Guillaume Seguin <guillaume@segu.in>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 08:02:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzoGf-0000Bi-I7
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 08:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbXLEHBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 02:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbXLEHBl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 02:01:41 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47495 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbXLEHBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 02:01:40 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C8F5F2F9;
	Wed,  5 Dec 2007 02:02:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 54F2199FF2;
	Wed,  5 Dec 2007 02:01:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67114>

I have these two patches still in my mailbox, unapplied:

[PATCH] gitweb: disambiguate heads and tags withs the same name
[PATCH] gitweb: Try harder in parse_tag; perhaps it was given ambiguous name

I am wondering if they should be part of 1.5.4.  They look Ok but it is
not very easy to pick up what the real breakage it is trying to fix from
Perl gibberish.

Can we have tests (not just "we do not spit out anything to stderr") for
gitweb so that each patch can demonstrate the existing breakage, to make
judging easier?
