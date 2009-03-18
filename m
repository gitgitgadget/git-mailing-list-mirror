From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Tue, 17 Mar 2009 18:06:34 -0700
Message-ID: <7vsklbod0l.fsf@gitster.siamese.dyndns.org>
References: <200903171953.23650.ogoffart@kde.org>
 <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>
 <20090318004056.GB25454@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Goffart <ogoffart@kde.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 02:08:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjkGW-00058A-RK
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 02:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbZCRBGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 21:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754417AbZCRBGm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 21:06:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbZCRBGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 21:06:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 947DB7287;
	Tue, 17 Mar 2009 21:06:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BCD317283; Tue,
 17 Mar 2009 21:06:35 -0400 (EDT)
In-Reply-To: <20090318004056.GB25454@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 17 Mar 2009 20:40:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09D9F54E-1359-11DE-9F62-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113549>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 17, 2009 at 11:31:19PM +0100, Johannes Schindelin wrote:
>
>> > I was told on IRC that this has been discussed already not so long ago, 
>> > and looking on the archive[1], all i seen was bikesheeding .  Here is a 
>> > patch :-)
>> 
>> Unfortunately, the implementation is not the problem, but picking the best 
>> name.  The first letter "m" will be taken in a short while by the "merge" 
>> command for "rebase -i -p", so "message" is out, sadly.
>> 
>> But the "rephrase" command will be part of the "rebase -i -p" series when 
>> I will finally be able to submit it.
>
> Also, I thought the general plan was to add such features to the
> git-sequencer work which will (hopefully) eventually replace "rebase
> -i". Dscho, can you give a brief update on how that is coming? Are
> rebase patches worth thinking about?

I am not quite sure what rephrase is buying us.  Do we also want to
introduce retree that allows you to muck with the tree object recorded
without giving you a chance to clobber the commit log message?
