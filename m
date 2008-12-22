From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'Theirs' merge between branches on a binary file.
Date: Mon, 22 Dec 2008 15:18:44 -0800
Message-ID: <7v3agfhk8b.fsf@gitster.siamese.dyndns.org>
References: <c115fd3c0812221256l494bb824ga8e1640efb07b20c@mail.gmail.com>
 <7vr63zhq4k.fsf@gitster.siamese.dyndns.org>
 <c115fd3c0812221316y24ce0c7q29807cd349a99e83@mail.gmail.com>
 <7vd4fjhlf8.fsf@gitster.siamese.dyndns.org>
 <c115fd3c0812221458q3444cbcai7ab1716b9195ad08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 00:20:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEu4J-0002u3-7l
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 00:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421AbYLVXSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 18:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbYLVXSw
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 18:18:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215AbYLVXSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 18:18:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 665371A97E;
	Mon, 22 Dec 2008 18:18:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D23D81A83D; Mon,
 22 Dec 2008 18:18:46 -0500 (EST)
In-Reply-To: <c115fd3c0812221458q3444cbcai7ab1716b9195ad08@mail.gmail.com>
 (Tim Visher's message of "Mon, 22 Dec 2008 17:58:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E43433E4-D07E-11DD-8113-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103780>

"Tim Visher" <tim.visher@gmail.com> writes:

> On Mon, Dec 22, 2008 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> That sounds like "git checkout --theirs"...
>
> I'm sorry, Junio.  I don't mean to be dense but I can't find that in
> the docs and when I execute it it comes back as an unknown command.

Hmph, I meant to point you at:

    http://www.kernel.org/pub/software/scm/git/docs/git-checkout.html

I think you can use "git checkout-index --stage=3 path" if your git is
older than that one with the option.

v1.6.0.1-15-g38901a4 (checkout --ours/--theirs: allow checking out one
side of a conflicting merge, 2008-08-30) introduced the feature.
