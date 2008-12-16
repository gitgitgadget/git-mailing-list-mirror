From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Mon, 15 Dec 2008 16:16:01 -0800
Message-ID: <7vprjtug8u.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
 <20081215004651.GA16205@localhost>
 <7v63lm1c76.fsf@gitster.siamese.dyndns.org>
 <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org> <20081215095949.GA7403@localhost>
 <7vskopwxej.fsf@gitster.siamese.dyndns.org>
 <7vej09w0hy.fsf@gitster.siamese.dyndns.org>
 <20081215230205.GA19538@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Dec 16 01:18:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCNd1-0004ra-Fi
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 01:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544AbYLPAQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 19:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754250AbYLPAQL
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 19:16:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182AbYLPAQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 19:16:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 198441A5AB;
	Mon, 15 Dec 2008 19:16:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 425E71A594; Mon,
 15 Dec 2008 19:16:02 -0500 (EST)
In-Reply-To: <20081215230205.GA19538@localhost> (Clemens Buchacher's message
 of "Tue, 16 Dec 2008 00:02:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BCECF5B4-CB06-11DD-89AA-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103219>

Clemens Buchacher <drizzd@aon.at> writes:

> I strongly disagree. With the suggested behavior I would have to
> double-check every single untracked file in my tree for conflicts before
> trying a throw-away merge followed by git reset --hard, for example.

AFAICS, that's not "suggested behaviour" for merge, but it is the
behaviour that has been true for eternity.

You can suggest to fix "reset --hard", though.
