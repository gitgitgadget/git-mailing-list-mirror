From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push.txt: describe how to default to pushing only
 current branch
Date: Sun, 15 Mar 2009 21:51:24 -0700
Message-ID: <7v4oxu135f.fsf@gitster.siamese.dyndns.org>
References: <20090313164941.GA16504@sigill.intra.peff.net>
 <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com>
 <7vd4cjc3da.fsf@gitster.siamese.dyndns.org>
 <20090313164941.GA16504@sigill.intra.peff.net>
 <1236994051-27346-1-git-send-email-chris_johnsen@pobox.com>
 <20090314203434.GA15444@coredump.intra.peff.net>
 <7veiwzajbc.fsf@gitster.siamese.dyndns.org>
 <20090314214603.GA20418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Johnsen <chris_johnsen@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 16 05:53:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lj4pO-0000by-5C
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 05:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbZCPEvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 00:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbZCPEvd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 00:51:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZCPEvd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 00:51:33 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C9F376DC3;
	Mon, 16 Mar 2009 00:51:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2409A6DBE; Mon,
 16 Mar 2009 00:51:26 -0400 (EDT)
In-Reply-To: <20090314214603.GA20418@sigill.intra.peff.net> (Jeff King's
 message of "Sat, 14 Mar 2009 17:46:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1D39D84E-11E6-11DE-BE51-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113307>

Jeff King <peff@peff.net> writes:

> On Sat, Mar 14, 2009 at 02:25:11PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Actually, looking closer, the information seems to be lost entirely.
>> > Asciidoc renders this to <literal> in the XML, but docbook seems to
>> > throw it away when converting to a manpage. In theory it's possible to
>> > apply our own xsl style to turn this into something else, and I think
>> > that is a better solution than just trying to fix this one spot.
>> 
>> When I check the asciidoc output for manpages (which I rarely do), I often
>> render it to Postscript to see the typesetting.  I guess not many people
>> consider manpages are for printing anymore but are solely for monospaced
>> terminal consumption these days.
>
> How do you render it? From the XML, or from the roff? Because if I am
> reading it right (which it is entirely possible that I am not), the
> information is lost in the roff version. And that is the version I would
> expect people to be looking at (via man -Tps, or just plain man).

I was agreeing with you; I let "man -Tps -l git-foo.1" render from roff
input and I can see that the output from asciidoc toolchain) prepared as
roff input does not consider printed pages so important anymore.
