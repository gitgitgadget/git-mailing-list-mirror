From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Test on Windows - prequel
Date: Wed, 18 Mar 2009 15:47:11 -0700
Message-ID: <7vljr2bg9c.fsf@gitster.siamese.dyndns.org>
References: <cover.1237410682.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:48:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4ZA-0000QY-3N
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbZCRWrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbZCRWrU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:47:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbZCRWrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:47:19 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AAD2A3288;
	Wed, 18 Mar 2009 18:47:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 32908A3287; Wed,
 18 Mar 2009 18:47:13 -0400 (EDT)
In-Reply-To: <cover.1237410682.git.j6t@kdbg.org> (Johannes Sixt's message of
 "Wed, 18 Mar 2009 22:27:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BBD180E0-140E-11DE-8159-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113698>

Johannes Sixt <j6t@kdbg.org> writes:

>   t7300: fix clean up on Windows
>
> Johannes Sixt (9):
>   t9400, t9401: Do not force hard-linked clone
>   test suite: Use 'say' to say something instead of
>     'test_expect_success'
>   Call 'say' outside test_expect_success
>   test-lib: Replace uses of $(expr ...) by POSIX shell features.
>   test-lib: Simplify test counting.
>   test-lib: Introduce test_chmod and use it instead of update-index
>     --chmod
>   t2200, t7004: Avoid glob pattern that also matches files
>   t5300, t5302, t5303: Do not use /dev/zero
>   t5602: Work around path mangling on MSYS

Do you have an 11-patch series, or 10-patch series with a cover letter?  I
am wondering what happened to [PATCH 11/11].
