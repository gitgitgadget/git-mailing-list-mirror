From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Re: cosmetic improvements for "git show tag"
Date: Sun, 19 Jul 2009 11:05:16 -0700
Message-ID: <7v7hy4y2eb.fsf@alter.siamese.dyndns.org>
References: <20090717231622.GA13511@coredump.intra.peff.net>
 <20090718011006.GB12968@vidovic>
 <20090718014743.GA16381@coredump.intra.peff.net>
 <20090718101436.GA22535@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 19 20:05:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSalO-0003Y2-T5
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 20:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbZGSSFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 14:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755000AbZGSSFX
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 14:05:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833AbZGSSFX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 14:05:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BAE3F9A45;
	Sun, 19 Jul 2009 14:05:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 09A029A42; Sun,
 19 Jul 2009 14:05:17 -0400 (EDT)
In-Reply-To: <20090718101436.GA22535@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 18 Jul 2009 06\:14\:37 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B9B54B58-748E-11DE-A26F-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123558>

Jeff King <peff@peff.net> writes:

> The code calls into log_tree_commit, which uses the "shown_one" member
> of rev_info to determine. So we should be able to just use that for our
> tags, and everything will work fine.
>
> I think we can replace 2/2 with the patch below, which also covers the
> tree case neatly.

Ack.  Looks sane.

Thanks.
