From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.1-rc3
Date: Mon, 15 Dec 2008 02:17:38 -0800
Message-ID: <7vy6yhwxml.fsf@gitster.siamese.dyndns.org>
References: <7vbpvnbcoa.fsf@gitster.siamese.dyndns.org>
 <7voczdyh23.fsf@gitster.siamese.dyndns.org>
 <34543.bFoQE3daRhY=.1229335460.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, raa.lkml@gmail.com,
	git@vger.kernel.org
To: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Dec 15 11:19:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCAXZ-0001dy-Vo
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:19:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYLOKRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 05:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbYLOKRr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 05:17:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbYLOKRq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 05:17:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E19A8792E;
	Mon, 15 Dec 2008 05:17:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 744048792C; Mon,
 15 Dec 2008 05:17:40 -0500 (EST)
In-Reply-To: <34543.bFoQE3daRhY=.1229335460.squirrel@webmail.hotelhot.dk>
 (Anders Melchiorsen's message of "Mon, 15 Dec 2008 11:04:20 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9D935FC0-CA91-11DD-866D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103151>

"Anders Melchiorsen" <mail@cup.kalibalik.dk> writes:

> The patch in that post improved things somewhat, by making a correct
> commit. Of course, the working tree then silently loses a file, which
> could be seen as being worse than a fatal failure.

Thanks for a reminder.  When resending for discussion, please make it
accompanied with a test case.  In any case, let's leave anything iffy
after the final.
