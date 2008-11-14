From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] fatal error during merge
Date: Thu, 13 Nov 2008 16:29:34 -0800
Message-ID: <7vfxlvf8up.fsf@gitster.siamese.dyndns.org>
References: <53328.bFoQE3daRhY=.1226568134.squirrel@webmail.hotelhot.dk>
 <2008-11-13-14-23-19+trackit+sam@rfc1149.net>
 <20081113140323.GA10267@neumann>
 <2008-11-13-15-26-33+trackit+sam@rfc1149.net>
 <20081113145325.GD29274@neumann>
 <57814.N1gUGH5fRhE=.1226596012.squirrel@webmail.hotelhot.dk>
 <20081113180931.GE29274@neumann> <20081113230932.GA8552@blimp.localdomain>
 <48332.N1gUGH5fRhE=.1226619243.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Anders Melchiorsen" <mail@cup.kalibalik.dk>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	"Samuel Tardieu" <sam@rfc1149.net>, git@vger.kernel.org,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 01:31:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0mbO-0002Av-JX
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 01:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454AbYKNAa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 19:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756443AbYKNAa0
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 19:30:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbYKNAaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 19:30:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6843D7DF3C;
	Thu, 13 Nov 2008 19:30:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EF58F7DF30; Thu,
 13 Nov 2008 19:29:41 -0500 (EST)
In-Reply-To: <48332.N1gUGH5fRhE=.1226619243.squirrel@webmail.hotelhot.dk>
 (Anders Melchiorsen's message of "Fri, 14 Nov 2008 00:34:03 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6BBBD76E-B1E3-11DD-BBD8-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100936>

"Anders Melchiorsen" <mail@cup.kalibalik.dk> writes:

> Your patch got rid of the errors and it commits the merged tree. But the
> working tree is not updated correctly, so the moved file disappears.

Isn't this a long known breakage of D/F conflict check logic in
merge-recursive backend?
