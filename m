From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: resurrect the traditional empty "diff --git" behaviour
Date: Fri, 31 Aug 2007 14:16:24 -0700
Message-ID: <7vhcmfxv4n.fsf@gitster.siamese.dyndns.org>
References: <20070830072748.GF16312@mellanox.co.il>
	<7vmyw85uml.fsf@gitster.siamese.dyndns.org>
	<20070831080651.GA17637@mellanox.co.il>
	<7vabs82kcq.fsf@gitster.siamese.dyndns.org>
	<20070831081517.GB17637@mellanox.co.il>
	<7v4pig2j91.fsf@gitster.siamese.dyndns.org>
	<20070831152120.GC17637@mellanox.co.il>
	<7vr6lj1zg3.fsf@gitster.siamese.dyndns.org>
	<20070831160335.GA17761@coredump.intra.peff.net>
	<7vtzqfzcll.fsf_-_@gitster.siamese.dyndns.org>
	<20070831203250.GA19340@coredump.intra.peff.net>
	<Pine.LNX.4.64.0708312154530.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDr2-0001EL-GN
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761539AbXHaVQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761489AbXHaVQc
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:16:32 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761505AbXHaVQb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:16:31 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D462B12BF6F;
	Fri, 31 Aug 2007 17:16:47 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708312154530.28586@racer.site> (Johannes
	Schindelin's message of "Fri, 31 Aug 2007 21:57:29 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57213>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 31 Aug 2007, Jeff King wrote:
>
>> On Fri, Aug 31, 2007 at 01:13:42PM -0700, Junio C Hamano wrote:
>> 
>> > If you set diff.autorefreshindex configuration variable, it
>> > squelches the empty "diff --git" output, and at the end of the
>> > command, it automatically runs "update-index --refresh" without
>> > even bothering the user.  In other words, with the configuration
>> > variable set, people who do not care about the cache-dirtyness
>> > do not even have to see the warning.
>> 
>> Nice. This is much more sane behavior, IMHO, and I think it should make 
>> everyone happy.
>
> I could even imagine that this will eventually become the standard 
> behaviour.

You sound as if you _like_ that behaviour...
