From: Junio C Hamano <gitster@pobox.com>
Subject: Re: input validation in receive-pack
Date: Wed, 02 Jan 2008 00:01:13 -0800
Message-ID: <7v63yc3bcm.fsf@gitster.siamese.dyndns.org>
References: <20080101213451.GA26772@auto.tuwien.ac.at>
	<7vzlvp3oya.fsf@gitster.siamese.dyndns.org>
	<20080102075152.GA24401@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mkoegler@auto.tuwien.ac.at (Martin Koegler)
X-From: git-owner@vger.kernel.org Wed Jan 02 09:01:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9yXw-0001D2-Er
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 09:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbYABIBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 03:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbYABIBT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 03:01:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbYABIBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 03:01:19 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A339FAC4E;
	Wed,  2 Jan 2008 03:01:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BE84AC4D;
	Wed,  2 Jan 2008 03:01:15 -0500 (EST)
In-Reply-To: <20080102075152.GA24401@auto.tuwien.ac.at> (Martin Koegler's
	message of "Wed, 2 Jan 2008 08:51:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69462>

mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:

> Are there more refs outside "refs/", which somebody would want to push to?

As anything outside refs/ and not HEAD are subject to gc, I do
not think it should even be allowed.

But this is, as everybody should be aware, very late in 1.5.4
cycle, so I'd rather avoid bahviour change to tighten things
before post-1.5.4 opens.
