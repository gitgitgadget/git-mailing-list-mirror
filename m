From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff.c: fix pointer type warning
Date: Fri, 19 Dec 2008 15:09:51 -0800
Message-ID: <7vd4fn7oe8.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>
 <alpine.LFD.2.00.0812171043440.14014@localhost.localdomain>
 <20081218121118.3635c53c@crow> <494C1BE8.20607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Burton <markb@ordern.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Dec 20 00:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDoVA-0008NA-Ck
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 00:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbYLSXKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 18:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbYLSXKG
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 18:10:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbYLSXKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 18:10:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 28F7B17F34;
	Fri, 19 Dec 2008 18:10:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5462A1AA8C; Fri,
 19 Dec 2008 18:09:53 -0500 (EST)
In-Reply-To: <494C1BE8.20607@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?= Scharfe's
 message of "Fri, 19 Dec 2008 23:10:48 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 28E921CA-CE22-11DD-8D7A-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103597>

Thanks; I think I already have it in my tree from your yesterday's
e-mail.  I just have been too busy to whip the other branches into shape
to push the results out.
