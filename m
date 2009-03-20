From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
 shortcut to the tracked branch
Date: Thu, 19 Mar 2009 23:57:42 -0700
Message-ID: <7vprgc4r6h.fsf@gitster.siamese.dyndns.org>
References: <200903181448.50706.agruen@suse.de>
 <20090318182603.GM8940@machine.or.cz>
 <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de>
 <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
 <20090320004029.GX23521@spearce.org>
 <20090320060545.GB27008@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 07:59:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkYhR-0004VE-VV
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 07:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbZCTG54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 02:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751894AbZCTG54
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 02:57:56 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZCTG54 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 02:57:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 76C82A30A1;
	Fri, 20 Mar 2009 02:57:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 436E9A309D; Fri,
 20 Mar 2009 02:57:43 -0400 (EDT)
In-Reply-To: <20090320060545.GB27008@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 20 Mar 2009 02:05:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E7BA3CA-151C-11DE-9172-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113903>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 19, 2009 at 05:40:29PM -0700, Shawn O. Pearce wrote:
>
>> So yea, you can create a branch named "foo@{1}".
>
> But you can't actually refer to it:
>
>   $ git branch foo@{1}
>   $ git show foo@{1} --
>   fatal: bad revision 'foo@{1}'
>
> which implies that nobody is actually using it for anything.

I think you are right.  It is just "git branch" and perhaps "git
update-ref" are too loose in enforcing what can be created.
