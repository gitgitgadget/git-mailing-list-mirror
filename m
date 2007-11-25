From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-add: fix command line building to call interactive
Date: Sun, 25 Nov 2007 10:36:29 -0800
Message-ID: <7vlk8mmatu.fsf@gitster.siamese.dyndns.org>
References: <1195996542-86074-1-git-send-email-win@wincent.com>
	<7vd4tynqpw.fsf@gitster.siamese.dyndns.org>
	<F09249EB-475A-4352-A3A1-A8B15D2A94FF@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 19:36:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwMLd-0003nS-UR
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 19:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755067AbXKYSgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 13:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbXKYSgf
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 13:36:35 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:32804 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427AbXKYSgf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2007 13:36:35 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EFE6F2EF;
	Sun, 25 Nov 2007 13:36:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7DA4899A01;
	Sun, 25 Nov 2007 13:36:52 -0500 (EST)
In-Reply-To: <F09249EB-475A-4352-A3A1-A8B15D2A94FF@wincent.com> (Wincent
	Colaiuta's message of "Sun, 25 Nov 2007 19:27:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65982>

Wincent Colaiuta <win@wincent.com> writes:

> El 25/11/2007, a las 19:07, Junio C Hamano escribi=F3=BA=8A=8A> The e=
arlier 7c0ab4458994aa895855abc4a504cf693ecc0cf1 (Teach builtin-=20
>> add
>> to pass multiple paths to git-add--interactive) did not allocate =20
>> enough,
>
> Yes, it was off by one; sorry about that. You may have noticed that I=
 =20
> fixed that up in the patches I sent out yesterday and today. May need=
 =20
> to redo them now to apply on top of this.

I'd suggest you to slow down, apply the two patches on top of 'next' an=
d
take a look at the result.

I _think_ the only remaining thing is --patch, and none of the pathspec
thing is needed.
