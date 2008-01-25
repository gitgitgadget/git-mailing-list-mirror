From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On pathnames
Date: Thu, 24 Jan 2008 20:18:48 -0800
Message-ID: <7vtzl27d1z.fsf@gitster.siamese.dyndns.org>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	<20080123064139.GC16297@glandium.org>
	<4697E0BA-7243-4C35-A384-0BD261EC21AF@sb.org>
	<20080123094052.GB6969@glandium.org> <20080123133802.GC7415@mit.edu>
	<alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	<98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
	<alpine.LFD.1.00.0801230930390.1741@woody.linux-foundation.org>
	<7vprvr7x8h.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801241722130.22568@xanadu.home>
	<46a038f90801241955j672ca508q2eb691be5e1d328f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Kevin Ballard" <kevin@sb.org>, "Theodore Tso" <tytso@mit.edu>,
	"Mike Hommey" <mh@glandium.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:20:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIG2o-0003PI-5J
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 05:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbYAYET0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 23:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYAYET0
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 23:19:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46019 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbYAYETZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 23:19:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E6451101;
	Thu, 24 Jan 2008 23:19:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C5111100;
	Thu, 24 Jan 2008 23:19:10 -0500 (EST)
In-Reply-To: <46a038f90801241955j672ca508q2eb691be5e1d328f@mail.gmail.com>
	(Martin Langhoff's message of "Fri, 25 Jan 2008 16:55:10 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71679>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> There is one thing that I don't see in Junio's plan...
>
>  - a warning during checkout if the index contains "equivalent" paths
> that will clobber eachother during checkout.
>  - an optional warning/error during add, to be raised if I am adding a
> path that is equivalent to an already-existing path in the index

Thanks.  I think these and many other issues need to be worked
out.

In my message, I did not even try to be exhaustive.  I outlined
the parts that would most deeply affect the parts I care more
deeply about, which is the plumbing.  As I said many times, I do
not do Porcelains ;-).
