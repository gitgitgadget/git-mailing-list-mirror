From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [StGit PATCH] t2800: Adapt to changes in git's conflict markers
Date: Sat, 18 Jul 2009 12:51:03 -0700
Message-ID: <7v7hy53h3s.fsf@alter.siamese.dyndns.org>
References: <20090715095312.1705.13477.stgit@october.e.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Martin Renold <martinxyz@gmx.ch>, git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 21:52:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSFxP-0003Vs-CE
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 21:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZGRTvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 15:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZGRTvN
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 15:51:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbZGRTvN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 15:51:13 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 161728D53;
	Sat, 18 Jul 2009 15:51:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5E90E8D50; Sat,
 18 Jul 2009 15:51:05 -0400 (EDT)
In-Reply-To: <20090715095312.1705.13477.stgit@october.e.vtech> (Karl Wiberg's
 message of "Wed\, 15 Jul 2009 11\:54\:08 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5731230E-73D4-11DE-ADA0-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123534>

Karl Wiberg <kha@treskal.com> writes:

> From: Karl Wiberg <kha@treskal.com>
>
> The conflict markers used by git were changed slightly by commit
> 606475f3 ("Remove filename from conflict markers"); specifically, the
> conflict markers contain the filename only when the filename has
> changed.
>
> This patch adapts t2800 to allow either the new or the old format.
>
> Signed-off-by: Karl Wiberg <kha@treskal.com>

Thanks; Cc'ed Martin Renold <martinxyz@gmx.ch>.
