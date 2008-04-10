From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Friendly refspecs
Date: Thu, 10 Apr 2008 00:51:08 -0700
Message-ID: <7vlk3mxi4z.fsf@gitster.siamese.dyndns.org>
References: <20080409101428.GA2637@elte.hu>
 <20080409145758.GB20874@sigill.intra.peff.net>
 <20080409200836.GA19248@mithlond>
 <20080409203453.GA10370@sigill.intra.peff.net>
 <20080409222500.GB19248@mithlond>
 <20080409225112.GB12103@sigill.intra.peff.net>
 <20080410000349.GA16800@sigill.intra.peff.net>
 <20080410001152.GB16800@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 09:52:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjrZp-0006Vy-5X
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 09:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYDJHvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 03:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbYDJHvZ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 03:51:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbYDJHvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 03:51:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 530E92B6C;
	Thu, 10 Apr 2008 03:51:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8A4D92B64; Thu, 10 Apr 2008 03:51:15 -0400 (EDT)
In-Reply-To: <20080410001152.GB16800@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 9 Apr 2008 20:11:52 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79189>

Thanks for bringing this issue up and proposing a pair of improvements.

I am very inclined to apply [1/2] to maint.  I am not convinced if [2/2]
is a good idea in general but if it is silent on pull and verbose on
one-off fetch without local store, it probably is an improvement.
