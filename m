From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how do I resolve this merge manually + mergetool bug
Date: Mon, 23 Feb 2009 23:16:16 -0800
Message-ID: <7vr61ol2yn.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com>
 <7vbpssmjm9.fsf@gitster.siamese.dyndns.org>
 <81bfc67a0902232252h56570308r22872854af8da54a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 08:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbrY6-0007M0-Po
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 08:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbZBXHQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 02:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbZBXHQX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 02:16:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbZBXHQW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 02:16:22 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3FFAE2BD03;
	Tue, 24 Feb 2009 02:16:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A0F882BD02; Tue,
 24 Feb 2009 02:16:18 -0500 (EST)
In-Reply-To: <81bfc67a0902232252h56570308r22872854af8da54a@mail.gmail.com>
 (Caleb Cushing's message of "Tue, 24 Feb 2009 01:52:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 09759A1C-0243-11DE-B018-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111231>

Caleb Cushing <xenoterracide@gmail.com> writes:

> git rm profiles/package.mask
>
> rm 'profiles/package.mask'
> rm 'profiles/package.mask'
> rm 'profiles/package.mask/gentoo.org'

Ahh, ok, "git rm" Porcelain may well be buggy; I almost never use it
myself.

"git update-index --force-remove profiles/package.mask" should work
better.  I tend to trust plumbing a lot more than Porcelain for these
corner cases.
