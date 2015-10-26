From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] Correct fscanf formatting string for I64u values
Date: Mon, 26 Oct 2015 13:20:24 -0700
Message-ID: <xmqqy4epfkl3.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<9f9e70a1704d8388f520535192e263089e36860e.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Waldek Maleska <w.maleska@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:20:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqoG1-0003NJ-RE
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 21:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbbJZUU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:20:28 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752300AbbJZUU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 16:20:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1AB7B26F23;
	Mon, 26 Oct 2015 16:20:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=LOPpTZ
	2pME1LmqxQmmrcQGRpbsguArENPQ4B/zzc+Un9fLg78nG2V0XzireOpLR9gaj0B3
	t5rvI44LUeI/P56bLPT5r17TzQJaM5YF1op0QUEzhH2zhgk7oZqPSV/l5VbwqIbT
	It5junAeluxqOLi9xdpm7OSBcQeIR0ev6saug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q9OlMM215c/rTZOePTTTYvzavLWP5oWH
	Lz2O4iWcyZVriWOEtwlMVfUyFNWmDYNeN/x9x2/5thePjJnBYh6t/OB/+Lr4oL8p
	BHRCvxCMAZns5PtG69iuN+HCYDJb0GtkLinFJ9IvO4YMAOXaGUM2qohHR/KjaLq9
	JGbp6AkIyC4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 063B326F21;
	Mon, 26 Oct 2015 16:20:26 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 66E3F26F20;
	Mon, 26 Oct 2015 16:20:25 -0400 (EDT)
In-Reply-To: <9f9e70a1704d8388f520535192e263089e36860e.1445865176.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 26 Oct 2015 14:15:33 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FDD8AFF2-7C1E-11E5-A900-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280219>

Thanks; will queue.
