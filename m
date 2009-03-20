From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
 shortcut to the tracked branch
Date: Fri, 20 Mar 2009 09:47:33 -0700
Message-ID: <7vbprwi1ju.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de>
 <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
 <20090320004029.GX23521@spearce.org>
 <20090320060545.GB27008@coredump.intra.peff.net>
 <7vprgc4r6h.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903201029290.10279@pacific.mpi-cbg.de>
 <20090320111238.GZ8940@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 20 17:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkhuD-0002Io-Kc
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 17:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757300AbZCTQrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 12:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757073AbZCTQro
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 12:47:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756821AbZCTQrn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 12:47:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A8D037A2B;
	Fri, 20 Mar 2009 12:47:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 99AB47A24; Fri,
 20 Mar 2009 12:47:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D41B05C0-156E-11DE-98A3-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113978>

Petr Baudis <pasky@suse.cz> writes:

>> "git branch" I agree with, but not "git update-ref".  As plumbing, the 
>> latter should be much more allowing, feeding rope aplenty (but also 
>> allowing cool tricks we do not think about yet).
>
> We shouldn't allow creating insane ref names even with update-ref. That
> way porcelains cannot rely on update-ref to sanity check the user's
> crap. At most, maybe you might want to bypass this check with some force
> switch, though I really can't quite imagine why.

That's all nice and clean in theory, but it was more or less the same
reasoning as what was behind the tightening not to allow anything but
refs/heads pointed by HEAD, but you know what fell out of it.  "Insane"
and "crap" are in the eye of the beholder.
