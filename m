From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC (amend)] autoconf: Add test for OLD_ICONV (squelching compiler warning)
Date: Wed, 05 Dec 2007 15:27:24 -0800
Message-ID: <7vd4tklo2r.fsf@gitster.siamese.dyndns.org>
References: <7vd4tkn5mk.fsf@gitster.siamese.dyndns.org>
	<1196895948-25115-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pascal Obry <pascal@obry.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:27:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J03ei-0000IZ-AW
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 00:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbXLEX1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 18:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752247AbXLEX1e
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 18:27:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36727 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbXLEX1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 18:27:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CBA982F0;
	Wed,  5 Dec 2007 18:27:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 362099C2E2;
	Wed,  5 Dec 2007 18:27:48 -0500 (EST)
In-Reply-To: <1196895948-25115-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Thu, 6 Dec 2007 00:05:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67211>

Jakub Narebski <jnareb@gmail.com> writes:

>> Which means the real-life compilation will get the warning on type
>> mismatch.  Wasn't OLD_ICONV about squelching that?
>
> Gah, I don't know why I though OLD_ICONV was about compile errors, and
> not about compile warnings. This version uses -Werror to check for
> warnings; I hope it doesn't give false positives...

But use of -Werror means you are married to gcc, doesn't it?

How important is it to detect OLD_ICONV anyway, I have to wonder?

> On Wed, 5 Dec 2007, Pascal Obry wrote:
> ...
>> Note also that you should remove all the hard-coded settings
>> in Makefile anyway.
>
> No, I should not. ./configure script is purely optional in git,

Correct.  Thanks.
