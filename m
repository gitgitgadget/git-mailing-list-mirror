From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Sun, 18 Nov 2007 23:27:56 -0800
Message-ID: <7vejempudf.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site>
	<11954023881802-git-send-email-prohaska@zib.de>
	<119540238994-git-send-email-prohaska@zib.de>
	<7vwssfqb0w.fsf@gitster.siamese.dyndns.org>
	<EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Nov 19 08:28:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu13P-00014O-Ni
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 08:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbXKSH2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 02:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbXKSH2G
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 02:28:06 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45828 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXKSH2E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 02:28:04 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 61F3E2F0;
	Mon, 19 Nov 2007 02:28:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EF2C3958B9;
	Mon, 19 Nov 2007 02:28:19 -0500 (EST)
In-Reply-To: <EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de> (Steffen Prohaska's
	message of "Mon, 19 Nov 2007 07:41:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65407>

Steffen Prohaska <prohaska@zib.de> writes:

>> Together with your [PATCH 1/2], I like the general direction
>> these patckes are taking us, but it feels a bit too hasty.  I
>> personally am not convinced that switching to --current for
>> everybody is a good move.
>>
>>> ...
>>
> I think 3) is the interesting case.  "git push" should do
> nothing by default.

NO WAY.

Making things cumbersome to everybody does not achieve anything
useful except for a false sense of equality, does it?

Drop that step (3).  That is not useful to anybody.
