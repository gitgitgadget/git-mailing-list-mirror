From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Implement selectable group ownership in git-init
Date: Tue, 6 Nov 2007 11:31:21 +0100
Message-ID: <143A8D66-66A3-4E71-A8FD-90254CD99C1E@wincent.com>
References: <472CC676.3000603@gmail.com> <7vabpvx8uu.fsf@gitster.siamese.dyndns.org> <8EF5148D-C1F0-4329-A221-82D0B7E9932C@wincent.com> <472F98DE.2010406@gmail.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francesco Pretto <ceztkoml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 11:31:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpLig-0000TK-47
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 11:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbXKFKb1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 05:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754619AbXKFKb1
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 05:31:27 -0500
Received: from wincent.com ([72.3.236.74]:47424 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbXKFKb0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Nov 2007 05:31:26 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lA6AVMpl003155;
	Tue, 6 Nov 2007 04:31:23 -0600
In-Reply-To: <472F98DE.2010406@gmail.com>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63655>

El 5/11/2007, a las 23:27, Francesco Pretto escribi=F3:

> Wincent Colaiuta ha scritto:
>> I think this proposal adds unnecessary clutter to the codebase for
>> something that can easily be achieved (and *should*) using chown, =20
>> chgrp,
>> or "sudo -u" etc.
>
> While still not convinced about that "unnecessary", i had to admit =20
> the risk
> of breaking something with my addition was too high. What about a =20
> compromise?
> I have improved the documentation about shared repositories. A patch =
=20
> coming
> shortly.

Sounds like an excellent idea.

Cheers,
Wincent
