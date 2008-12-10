From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff: respect textconv in rewrite diffs
Date: Wed, 10 Dec 2008 12:27:18 -0800
Message-ID: <7vd4fzzsgp.fsf@gitster.siamese.dyndns.org>
References: <20081209081227.GA19626@coredump.intra.peff.net>
 <20081209081321.GA19707@coredump.intra.peff.net>
 <7v3agw2zu5.fsf@gitster.siamese.dyndns.org>
 <20081210090221.GA11367@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVfq-0006ES-68
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbYLJU12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbYLJU12
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:27:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbYLJU11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 15:27:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B4F685EC0;
	Wed, 10 Dec 2008 15:27:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 308B985EBE; Wed,
 10 Dec 2008 15:27:20 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F431895C-C6F8-11DD-9C95-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102716>

Jeff King <peff@peff.net> writes:

> But more importantly, the fixup you just pushed seems to have an extra
> ">dump":

Oops, sorry.
