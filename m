From: Junio C Hamano <gitster@pobox.com>
Subject: Re: conflict status
Date: Mon, 03 Aug 2009 11:35:03 -0700
Message-ID: <7vvdl4925k.fsf@alter.siamese.dyndns.org>
References: <DDAD985F-C9CA-4159-B382-354D4B082C19@users.sourceforge.net>
 <fabb9a1e0908031037t16a828f6h4de9fb11bcc957fe@mail.gmail.com>
 <200908032017.35101.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Wild <themiwi@users.sourceforge.net>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 03 20:35:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY2NT-0002WJ-BK
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 20:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbZHCSfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 14:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbZHCSfK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 14:35:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbZHCSfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 14:35:09 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 532851FAF1;
	Mon,  3 Aug 2009 14:35:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9915F1FAEE; Mon, 
 3 Aug 2009 14:35:04 -0400 (EDT)
In-Reply-To: <200908032017.35101.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon\, 3 Aug 2009 20\:17\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5F61D868-805C-11DE-9504-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124715>

Thomas Rast <trast@student.ethz.ch> writes:

> That only shows 'unmerged: foo' for me...
>
> The closest to porcelain I can get while still having all the
> information is
>
>   $ git ls-files -s foo
>   100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 1       foo
>   100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 2       foo
>
> In other words, not porcelain at all.

"git ls-files -u" would be what you want.  It shows all the paths with
conflicts in the index, and omits paths without conflicts in the index.
And the object names allow you to inspect the individual stages.
