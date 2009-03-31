From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add warning about known issues to documentation of
 cvsimport
Date: Tue, 31 Mar 2009 16:55:53 -0700
Message-ID: <7vljql4586.fsf@gitster.siamese.dyndns.org>
References: <20090323195304.GC26678@macbook.lan>
 <20090324031448.GA12829@coredump.intra.peff.net>
 <20090330223646.GC68118@macbook.lan>
 <20090331112812.GA2090@coredump.intra.peff.net>
 <20090331194056.GA23102@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Chris Johnsen <chris_johnsen@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 01 01:57:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lonpm-00089N-UK
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 01:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762774AbZCaX4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 19:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759816AbZCaX4H
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 19:56:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbZCaX4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 19:56:06 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 939FDA6DD7;
	Tue, 31 Mar 2009 19:56:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1633EA6DD5; Tue,
 31 Mar 2009 19:55:54 -0400 (EDT)
In-Reply-To: <20090331194056.GA23102@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 31 Mar 2009 15:40:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C6313C4-1E4F-11DE-A335-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115333>

Jeff King <peff@peff.net> writes:

> Going back to the original discussion, it looks like it is a workaround
> for docbook-xsl 1.69.0:
>
>   http://article.gmane.org/gmane.comp.version-control.git/32957
>
> Assuming that is correct, I think the sane choices are:
>
>   1. drop the workaround, as that version of docbook-xsl is now several
>      years old
>
>      or
>
>   2. turn the workaround off by default, but add a knob to turn it on
>      (DOCBOOK_XSL_1690?)
>
> Having it on by default and turning it off with a knob seems silly,
> since most versions don't need it. Debian stable is shipping 1.73 these
> days, which looks fine without 7ef0435. Are there other platforms still
> shipping 1.69.0? Is it too old for us to care?

I am very tempted to say 1. but we seem to have a track record of trying
to be nice to people.  How involved would 2 be compared to 1?
