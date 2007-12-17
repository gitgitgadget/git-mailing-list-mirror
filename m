From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] the use of 'tr' in the test suite isn't really portable
Date: Mon, 17 Dec 2007 12:25:29 -0800
Message-ID: <7vlk7t6pc6.fsf@gitster.siamese.dyndns.org>
References: <20071217191508.79cc05e2@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:26:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4MXU-0008Bw-IB
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820AbXLQUZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 15:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbXLQUZs
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:25:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820AbXLQUZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 15:25:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FBA142EE;
	Mon, 17 Dec 2007 15:25:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 980D742ED;
	Mon, 17 Dec 2007 15:25:36 -0500 (EST)
In-Reply-To: <20071217191508.79cc05e2@pc09.procura.nl> (H. Merijn Brand's
	message of "Mon, 17 Dec 2007 19:15:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68612>

The contents looked correct but the patch was garbled.

--

Applying the use of 'tr' in the test suite isn't really portable
.dotest/patch:11: indent with spaces.
               git diff-index -r $commit | cut -f 2- | tr '\n' '\000' | \
.dotest/patch:153: indent with spaces.
            dd if=/dev/zero bs=4k count=1 | tr "\\000" $i >$i &&
.dotest/patch:165: indent with spaces.
                       tr '\000' 'g'
.dotest/patch:174: indent with spaces.
                       tr '\000' 'g'
error: patch failed: git-filter-branch.sh:290
error: git-filter-branch.sh: patch does not apply
error: patch failed: t/t0020-crlf.sh:5
error: t/t0020-crlf.sh: patch does not apply
error: patch failed: t/t3300-funny-names.sh:54
error: t/t3300-funny-names.sh: patch does not apply
error: patch failed: t/t4020-diff-external.sh:99
error: t/t4020-diff-external.sh: patch does not apply
error: patch failed: t/t4116-apply-reverse.sh:12
error: t/t4116-apply-reverse.sh: patch does not apply
error: patch failed: t/t4200-rerere.sh:129
error: t/t4200-rerere.sh: patch does not apply
error: patch failed: t/t5300-pack-object.sh:15
error: t/t5300-pack-object.sh: patch does not apply
error: patch failed: test-sha1.sh:10
error: test-sha1.sh: patch does not apply
.dotest/patch:11: indent with spaces.
               git diff-index -r $commit | cut -f 2- | tr '\n' '\000' | \
.dotest/patch:153: indent with spaces.
            dd if=/dev/zero bs=4k count=1 | tr "\\000" $i >$i &&
.dotest/patch:165: indent with spaces.
                       tr '\000' 'g'
.dotest/patch:174: indent with spaces.
                       tr '\000' 'g'
