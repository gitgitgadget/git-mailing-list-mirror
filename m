From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Funky] "git -p cmd" inside a bare repository
Date: Thu, 13 Dec 2007 22:07:21 -0800
Message-ID: <7vabodvmg6.fsf@gitster.siamese.dyndns.org>
References: <20071129122139.GA11176@laptop>
	<7vmysexdvw.fsf@gitster.siamese.dyndns.org>
	<20071214051223.GD10169@sigill.intra.peff.net>
	<20071214051434.GE10169@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:08:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33iK-0006R9-NJ
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758202AbXLNGHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 01:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758191AbXLNGHj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:07:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59609 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176AbXLNGHi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:07:38 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E6F3F8149;
	Fri, 14 Dec 2007 01:07:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D73248144;
	Fri, 14 Dec 2007 01:07:24 -0500 (EST)
In-Reply-To: <20071214051434.GE10169@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 14 Dec 2007 00:14:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68232>

Jeff King <peff@peff.net> writes:

> On Fri, Dec 14, 2007 at 12:12:23AM -0500, Jeff King wrote:
>
>> -- >8 --
>> delay "git -p" page spawning until command runtime
>
> Hrmph. Bad timing. :)
>
> Your patch is much nicer, though, so please ignore mine.

It may look nicer, but I do not know if it is correct, though.  I do not
do much "work tree" stuff, and would really appreciate testing by people
who are more involved in that part of the system.
