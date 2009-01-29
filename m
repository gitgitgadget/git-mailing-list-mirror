From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -u: do not fail to resolve a path as deleted
Date: Wed, 28 Jan 2009 16:13:21 -0800
Message-ID: <7veiynj7fi.fsf@gitster.siamese.dyndns.org>
References: <7vbptrkqvb.fsf@gitster.siamese.dyndns.org>
 <7viqnzj9ay.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 01:15:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSKZ9-0002N0-ML
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 01:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757864AbZA2ANb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 19:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761989AbZA2AN3
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 19:13:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762876AbZA2AN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 19:13:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E1A1794149;
	Wed, 28 Jan 2009 19:13:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3D9E894147; Wed,
 28 Jan 2009 19:13:22 -0500 (EST)
In-Reply-To: <7viqnzj9ay.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Jan 2009 15:32:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A53EC770-ED99-11DD-950C-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107602>

Junio C Hamano <gitster@pobox.com> writes:

> This is wrong; breaks t3702.

Ugh; that is a bogus test.  Please disregard.
