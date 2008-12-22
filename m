From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'Theirs' merge between branches on a binary file.
Date: Mon, 22 Dec 2008 13:11:23 -0800
Message-ID: <7vr63zhq4k.fsf@gitster.siamese.dyndns.org>
References: <c115fd3c0812221256l494bb824ga8e1640efb07b20c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:13:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEs53-0001Jp-MV
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 22:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbYLVVLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 16:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754578AbYLVVLb
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 16:11:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbYLVVLa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 16:11:30 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 105571ADD1;
	Mon, 22 Dec 2008 16:11:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 01F0E1ADDA; Mon,
 22 Dec 2008 16:11:25 -0500 (EST)
In-Reply-To: <c115fd3c0812221256l494bb824ga8e1640efb07b20c@mail.gmail.com>
 (Tim Visher's message of "Mon, 22 Dec 2008 15:56:31 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 199A57BE-D06D-11DD-BEC8-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103772>

"Tim Visher" <tim.visher@gmail.com> writes:

> I have a binary file that is coming up with a merge conflict
> (obviously) between two branches and I want to simply say, 'take their
> version of the file'.

Do you mean during a conflicted merge resolution you would want to check
their version out of the index and declare that it is the merge result?
