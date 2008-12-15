From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: unify boolean feature subroutines
Date: Mon, 15 Dec 2008 14:21:13 -0800
Message-ID: <7v3agpw04m.fsf@gitster.siamese.dyndns.org>
References: <1229352709-4663-1-git-send-email-kraai@ftbfs.org>
 <1229352709-4663-2-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Mon Dec 15 23:22:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCLpt-0001qw-Ci
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 23:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYLOWVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 17:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbYLOWVV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 17:21:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33501 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbYLOWVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 17:21:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 87D7C1A593;
	Mon, 15 Dec 2008 17:21:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E17A31A58A; Mon,
 15 Dec 2008 17:21:15 -0500 (EST)
In-Reply-To: <1229352709-4663-2-git-send-email-kraai@ftbfs.org> (Matt Kraai's
 message of "Mon, 15 Dec 2008 06:51:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B270136A-CAF6-11DD-9ABA-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103213>

Matt Kraai <kraai@ftbfs.org> writes:

> The boolean feature subroutines were identical except for the name of
> the configuration option, so make that a parameter and unify them.

I think this makes sense but unfortunately it comes after the other one
that I do not know what its point is...
