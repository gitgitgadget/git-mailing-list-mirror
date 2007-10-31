From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 15:31:20 -0700
Message-ID: <7vzlxygblz.fsf@gitster.siamese.dyndns.org>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de>
	<7vodefj2lk.fsf@gitster.siamese.dyndns.org>
	<20071031055303.GB3326@atjola.homenet>
	<20071031134358.GD15182@dpotapov.dyndns.org>
	<20071031140028.GA30207@diana.vm.bytemark.co.uk>
	<20071031143641.GF15182@dpotapov.dyndns.org>
	<20071031180557.GA12211@coredump.intra.peff.net>
	<7v8x5jgdck.fsf@gitster.siamese.dyndns.org>
	<20071031215625.GC14211@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 23:31:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InM6B-00066a-NV
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 23:31:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbXJaWba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 18:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753260AbXJaWba
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 18:31:30 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:46828 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbXJaWb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 18:31:29 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 186C92EF;
	Wed, 31 Oct 2007 18:31:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E41690D19;
	Wed, 31 Oct 2007 18:31:44 -0400 (EDT)
In-Reply-To: <20071031215625.GC14211@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 31 Oct 2007 17:56:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62891>

Jeff King <peff@peff.net> writes:

> ... I had one concern that
> I was tracking down: is the author name encoding necessarily the same as
> the commit text encoding?

The user is screwing himself already if that is the case and
uses -s to format-patch, isn't he?
