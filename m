From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] Teach git fetch to verify signed tags
 automatically
Date: Thu, 27 Nov 2008 17:43:00 -0800
Message-ID: <7v63m8aamz.fsf@gitster.siamese.dyndns.org>
References: <1227497000-8684-1-git-send-email-deskinm@umich.edu>
 <alpine.DEB.1.00.0811241140280.30769@pacific.mpi-cbg.de>
 <20081128001825.GA29662@euler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Fri Nov 28 02:44:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5sPI-0003tP-VD
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 02:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbYK1BnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 20:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753208AbYK1BnQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 20:43:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbYK1BnP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 20:43:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0389882E61;
	Thu, 27 Nov 2008 20:43:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BD2CA82E5E; Thu,
 27 Nov 2008 20:43:02 -0500 (EST)
In-Reply-To: <20081128001825.GA29662@euler> (Deskin Miller's message of "Thu,
 27 Nov 2008 19:18:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EC60A0EC-BCED-11DD-8E54-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101856>

Deskin Miller <deskinm@umich.edu> writes:

> The user didn't ask to verify, as I see it; rather, they asked git to
> *try* to verify.

If that is your argument, I really do not see any point in your patch.
They asked git to fetch, and did not say anything about trying anything
else.
