From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 06 Feb 2009 02:28:48 -0800
Message-ID: <7vd4dv7tb3.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
 <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
 <buobptg6tek.fsf@dhlpc061.dev.necel.com>
 <7vfxis86tp.fsf@gitster.siamese.dyndns.org>
 <buor62c3yin.fsf@dhlpc061.dev.necel.com>
 <7vprhw6l1i.fsf@gitster.siamese.dyndns.org>
 <buoab8z52te.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gyles19@visi.com, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 11:30:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVNya-0007SR-CD
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 11:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbZBFK25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 05:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbZBFK25
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 05:28:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993AbZBFK24 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 05:28:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 657CD2A8D7;
	Fri,  6 Feb 2009 05:28:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7CA252A8AF; Fri, 
 6 Feb 2009 05:28:50 -0500 (EST)
In-Reply-To: <buoab8z52te.fsf@dhlpc061.dev.necel.com> (Miles Bader's message
 of "Fri, 06 Feb 2009 18:31:41 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F4D602DA-F438-11DD-B664-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108673>

Miles Bader <miles@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>>
>> Please do not encourge use of configure/autoconf *in this project*.
>
> Er ... I was not doing so.  I was saying that if one is going to use
> autoconf with git, one should use a non-ancient version.

That is nice but the statement is only half-truth, and should be followed
by ", but why bother?  You do not even need to use configure to build
git, and insn is all here...".

Omitting that latter half and instead having him spend time to update
autoconf, which is not even needed, sounds like strongly encouraging its
use to me.

> I don't think merely discussing autoconf+git without pejorative asides
> is "encouraging use".

"You should use recent enough autoconf *if* you want to use configure, but
why bother?  You do not even need to use configure to build git, and here
is how..." does not say anything pejorative about autoconf, either, and it
is certainly not encouraging its use.

On the other hand, omitting "but why bother?" part is, and the reason is
not because it does not badmouth autoconf, but because use of autoconf is
non-essential in this project.
