From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFE] allow git bisect to figure out in which revision a bug was
 fixed
Date: Tue, 21 Jul 2009 18:08:41 -0700
Message-ID: <7v4ot5zfqe.fsf@alter.siamese.dyndns.org>
References: <x49ocrdokp9.fsf@segfault.boston.devel.redhat.com>
 <7vfxcpdbsh.fsf@alter.siamese.dyndns.org>
 <20090721202848.GA3453@localhost.localdomain>
 <7vprbtbwhu.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0907212030180.30629@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Bacik <josef@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jul 22 03:09:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTQKI-0002Zp-9k
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 03:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbZGVBIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 21:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752400AbZGVBIt
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 21:08:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbZGVBIt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 21:08:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D727CD864;
	Tue, 21 Jul 2009 21:08:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 37399D861; Tue, 21 Jul 2009
 21:08:42 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0907212030180.30629@xanadu.home> (Nicolas
 Pitre's message of "Tue\, 21 Jul 2009 20\:35\:52 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3657C220-765C-11DE-B4B7-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123728>

Nicolas Pitre <nico@cam.org> writes:

> Why not simply automatically inverting the meaning of good and
> bad based on which commit is the ancestor of the other initially?

Because neither may be an ancestor of the other?
