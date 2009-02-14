From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [topgit] tg update error
Date: Fri, 13 Feb 2009 18:16:23 -0800
Message-ID: <7vocx53gqw.fsf@gitster.siamese.dyndns.org>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com>
 <20090212084811.GA14261@piper.oerlikon.madduck.net>
 <20090212092558.GB21074@skywalker>
 <20090212125621.GB5397@sigill.intra.peff.net>
 <7veiy3l689.fsf@gitster.siamese.dyndns.org>
 <20090213182609.GB31860@coredump.intra.peff.net>
 <7vy6w93hdb.fsf@gitster.siamese.dyndns.org>
 <20090214020848.GA9907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, madduck@debian.org,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 03:18:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYA6R-0005Y4-JJ
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 03:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbZBNCQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 21:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbZBNCQc
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 21:16:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZBNCQc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 21:16:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 620A02B158;
	Fri, 13 Feb 2009 21:16:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 60BFB2B156; Fri,
 13 Feb 2009 21:16:25 -0500 (EST)
In-Reply-To: <20090214020848.GA9907@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 13 Feb 2009 21:08:48 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7E8941F4-FA3D-11DD-9D79-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109803>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 13, 2009 at 06:02:56PM -0800, Junio C Hamano wrote:
>
>> > As it turns out, topgit is using refs/top-bases/ in HEAD,
>> > leading us to re-loosen (at least temporarily) the
>> > validate_headref check made in b229d18a. This patch does the
>> > corresponding loosening for the symbolic-ref safety valve,
>> > so that the two are in agreement once more.
>> >
>> > Signed-off-by: Jeff King <peff@peff.net>
>> 
>> Actually we should simply revert afe5d3d5 altogether with the above
>> message, as it introduced a test that expects the tightened behaviour.
>
> Is there any reason to throw away the "must be in refs/" safety valve,
> though? That was the actual patch I started with and solved my problem,
> and the "tighten to refs/heads/" bit came from discussion. That is, I
> think having a safety valve in symbolic-ref that matches
> validate_headref is orthogonal to how tightly validate_headref matches.
>
> But yes, I obviously failed to run the test suite on the follow-up patch
> I sent. The final test in t1401 would need to be reverted, as well.

Sure.
