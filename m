From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix -q/-v to pull/fetch
Date: Mon, 20 Oct 2008 16:52:08 -0700
Message-ID: <7v1vya3jvb.fsf@gitster.siamese.dyndns.org>
References: <1224440277-2469-1-git-send-email-tuncer.ayaz@gmail.com>
 <4ac8254d0810191133v79ed73b7tf09a282f44d302dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 01:59:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks4Z4-0005Fp-MZ
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 01:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbYJTXwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 19:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752331AbYJTXwX
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 19:52:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbYJTXwW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 19:52:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 59A948D6B8;
	Mon, 20 Oct 2008 19:52:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 394648D6B6; Mon, 20 Oct 2008 19:52:15 -0400 (EDT)
In-Reply-To: <4ac8254d0810191133v79ed73b7tf09a282f44d302dd@mail.gmail.com>
 (Tuncer Ayaz's message of "Sun, 19 Oct 2008 20:33:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 219B0720-9F02-11DD-B0F7-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98747>

"Tuncer Ayaz" <tuncer.ayaz@gmail.com> writes:

> it doesn't work as I expected when you supply -q and -v.
> I have to redo it, I guess.

Probably adding a few new tests to one of the test scripts in t/ is in
order, then.
