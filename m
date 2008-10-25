From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] textconv: don't convert for every operation
Date: Sat, 25 Oct 2008 16:48:19 -0700
Message-ID: <7vvdvg6xto.fsf@gitster.siamese.dyndns.org>
References: <20081025004815.GA23851@coredump.intra.peff.net>
 <20081025005256.GD23903@coredump.intra.peff.net>
 <7vhc71b5ai.fsf@gitster.siamese.dyndns.org>
 <20081025071912.GA24287@coredump.intra.peff.net>
 <7v3aika5l7.fsf@gitster.siamese.dyndns.org>
 <20081025193554.GA27457@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 26 01:49:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtstA-00056c-Gy
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 01:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbYJYXse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 19:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYJYXse
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 19:48:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbYJYXse (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 19:48:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C17F0747A5;
	Sat, 25 Oct 2008 19:48:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 349A8747A4; Sat, 25 Oct 2008 19:48:25 -0400 (EDT)
In-Reply-To: <20081025193554.GA27457@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 25 Oct 2008 15:35:54 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6E9F445A-A2EF-11DD-97A0-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99133>

Another place that would benefit from ALLOW_TEXTCONV is the function
wt_status_print_verbose() in wt-status.c, where we generate preview diff
for "git commit -v".  The output from that function is purely for human
consumption and does not have to be applicable.
