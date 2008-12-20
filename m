From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Introduce commit notes
Date: Sat, 20 Dec 2008 12:09:24 -0800
Message-ID: <7vhc4ywqvf.fsf@gitster.siamese.dyndns.org>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
 <alpine.DEB.1.00.0812200034450.30769@pacific.mpi-cbg.de>
 <20081220065337.GA2581@coredump.intra.peff.net>
 <200812200855.14915.robin.rosenberg.lists@dewire.com>
 <20081220080546.GA4580@coredump.intra.peff.net>
 <7vk59vz2dx.fsf@gitster.siamese.dyndns.org>
 <20081220082304.GA5693@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 20 21:11:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE8A9-0001oF-EK
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbYLTUJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 15:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbYLTUJg
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:09:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbYLTUJf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:09:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D6DB87397;
	Sat, 20 Dec 2008 15:09:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DAB9587390; Sat,
 20 Dec 2008 15:09:25 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F538EA6-CED2-11DD-8AAA-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103660>

Jeff King <peff@peff.net> writes:

> On Sat, Dec 20, 2008 at 12:17:46AM -0800, Junio C Hamano wrote:
>
>> >   1. git am /the/patch
>> >   2. patch -p1 <.git/rebase-apply/patch
>> >   3. manually inspect the results for sanity, and fix up the cache.h
>> >      bit that failed totally
>> >   4. git add -u && git add notes.[ch]
>> >   5. git am --resolved
>> 
>> I usually skip 2-4 and edit .git/rebase-apply/patch in place instead, and
>> run "git am" instead of step 5.
>
> How do you track down the source of the conflict to do the patch fixup?

Old fashioned way, by looking at the patch and the file that the patch is
supposed to apply and reading the contexts.
