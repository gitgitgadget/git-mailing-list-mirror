From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/16] t3600: Use test prerequisite tags
Date: Sat, 21 Mar 2009 16:15:15 -0700
Message-ID: <7vr60qbh8c.fsf@gitster.siamese.dyndns.org>
References: <cover.1237667830.git.j6t@kdbg.org>
 <70f789fecee6955c362391b33272223c7ba74cc6.1237667830.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 00:17:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlAR4-0006I2-Vm
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbZCUXP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZCUXPZ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:15:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbZCUXPW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:15:22 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B055A3496;
	Sat, 21 Mar 2009 19:15:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9DE81A3495; Sat,
 21 Mar 2009 19:15:17 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 25E1CE2A-166E-11DE-8C90-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114093>

Johannes Sixt <j6t@kdbg.org> writes:

> The are two prerequisites.

Typo?

>
> - The filesystem support names with tabs or new-lines.
>
> - Files cannot be removed if their containing directory is read-only.
>
> Previously, whether these preconditions are satisified was tested inside
> test_expect_success. We move these tests outside because, strictly
> speaking, they are not part of the tests.

Otherwise looks good; thanks.
