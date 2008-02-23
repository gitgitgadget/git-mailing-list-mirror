From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t3404: use configured shell instead of /bin/sh
Date: Sat, 23 Feb 2008 14:55:42 -0800
Message-ID: <7vir0fz3ip.fsf@gitster.siamese.dyndns.org>
References: <20080220235944.GA6278@coredump.intra.peff.net>
 <200802232113.40100.johannes.sixt@telecom.at>
 <7v63wf2yzt.fsf@gitster.siamese.dyndns.org>
 <200802232209.41428.johannes.sixt@telecom.at>
 <20080223211536.GA13280@coredump.intra.peff.net>
 <7vmypr1gmh.fsf@gitster.siamese.dyndns.org>
 <20080223223933.GA13683@coredump.intra.peff.net>
 <7vve4fz3y1.fsf@gitster.siamese.dyndns.org>
 <20080223224938.GA14231@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Whit Armstrong <armstrong.whit@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 23:56:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT3IX-0004HF-7q
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 23:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbYBWW4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 17:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbYBWW4N
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 17:56:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbYBWW4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 17:56:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56A541C58;
	Sat, 23 Feb 2008 17:56:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 514D61C57; Sat, 23 Feb 2008 17:55:57 -0500 (EST)
In-Reply-To: <20080223224938.GA14231@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 23 Feb 2008 17:49:38 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74875>

Jeff King <peff@peff.net> writes:

> Personally, I think we are better off putting such configuration into a
> file that gets sourced by test-lib.sh, but I don't overly care. I _do_
> find "sh -x tXXXX-name.sh" useful from time to time, but mainly only
> while debugging the test scripts themselves.

I do too.

I think the basic goal should be to come up with a way to make
sure that "cd t/ && make" and "cd t/ && sh -x tXXXX-name.sh"
would get an environment as close as possible to what happens
when you run "make test" at the toplevel.
