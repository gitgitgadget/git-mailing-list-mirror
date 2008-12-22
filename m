From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'Theirs' merge between branches on a binary file.
Date: Mon, 22 Dec 2008 14:52:59 -0800
Message-ID: <7vd4fjhlf8.fsf@gitster.siamese.dyndns.org>
References: <c115fd3c0812221256l494bb824ga8e1640efb07b20c@mail.gmail.com>
 <7vr63zhq4k.fsf@gitster.siamese.dyndns.org>
 <c115fd3c0812221316y24ce0c7q29807cd349a99e83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:54:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEtfT-0003BQ-HU
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 23:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbYLVWxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 17:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754240AbYLVWxM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 17:53:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593AbYLVWxL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 17:53:11 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 20B8F1A823;
	Mon, 22 Dec 2008 17:53:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0AE371A817; Mon,
 22 Dec 2008 17:53:06 -0500 (EST)
In-Reply-To: <c115fd3c0812221316y24ce0c7q29807cd349a99e83@mail.gmail.com>
 (Tim Visher's message of "Mon, 22 Dec 2008 16:16:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4E1F540E-D07B-11DD-89EA-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103777>

"Tim Visher" <tim.visher@gmail.com> writes:

> On Mon, Dec 22, 2008 at 4:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Do you mean during a conflicted merge resolution you would want to check
>> their version out of the index and declare that it is the merge result?
>
> Sure.

That sounds like "git checkout --theirs"...
