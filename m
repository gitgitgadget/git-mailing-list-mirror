From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Tue, 27 Jan 2009 23:37:21 -0800
Message-ID: <7v4ozjx4ni.fsf@gitster.siamese.dyndns.org>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com>
 <20090126210027.GG27604@coredump.intra.peff.net>
 <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com>
 <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com>
 <e2b179460901270210q69fe1e42xb801553e4e9005e9@mail.gmail.com>
 <BAD975AD-323D-4278-8405-0B57E7202797@gmail.com>
 <20090128070114.GB19165@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Perry Smith <pedzsan@gmail.com>,
	Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:38:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS50i-00087M-LW
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbZA1Hha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752257AbZA1Hha
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:37:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47708 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbZA1Hh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:37:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C87E1D6F0;
	Wed, 28 Jan 2009 02:37:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8A7471D6EC; Wed,
 28 Jan 2009 02:37:23 -0500 (EST)
In-Reply-To: <20090128070114.GB19165@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 28 Jan 2009 02:01:14 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83A59638-ED0E-11DD-89D2-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107494>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 27, 2009 at 07:35:00PM -0600, Perry Smith wrote:
>
>> Just to be sure we are on the same page.  My directory structure has a
>> top/src/git-1.6.1 and top/build/git.1.6.1.  The src/git-1.6.1 is the
>> tar ball.  The  build/git-1.6.1 starts out empty.  I cd into it and
>> then do: ../../src/git-1.6.1/configure <options>  After this
>> completes, you can do "make".
>
> I don't see how this would work without automake support, which git does
> not have.

... nor want to have ;-).
