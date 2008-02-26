From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for filesystem challenges (case and unicode
 normalization)
Date: Mon, 25 Feb 2008 16:28:20 -0800
Message-ID: <7vlk58ftnf.fsf@gitster.siamese.dyndns.org>
References: <7vlk5vjpi4.fsf@gitster.siamese.dyndns.org>
 <1203873549507-git-send-email-prohaska@zib.de>
 <7voda4hikx.fsf@gitster.siamese.dyndns.org>
 <FBFBA30A-0D44-4A2A-A693-EFF79218FCEB@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mitcht.git@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 01:29:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTnh2-0008AQ-V9
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 01:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802AbYBZA2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 19:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756760AbYBZA2g
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 19:28:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756143AbYBZA2f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 19:28:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F6941A17;
	Mon, 25 Feb 2008 19:28:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9129C1A15; Mon, 25 Feb 2008 19:28:28 -0500 (EST)
In-Reply-To: <FBFBA30A-0D44-4A2A-A693-EFF79218FCEB@zib.de> (Steffen
 Prohaska's message of "Tue, 26 Feb 2008 00:34:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75096>

Steffen Prohaska <prohaska@zib.de> writes:

> This is a sensible way of handling this.  It works for me,
> except for ...
> ...
> test_case (instead of test_camel).

Thanks for testing.  Fixed.
