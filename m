From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 1/8] Support coverage testing with GCC/gcov
Date: Mon, 16 Feb 2009 10:39:04 +0100
Message-ID: <vpq3aeeoh53.fsf@bauges.imag.fr>
References: <cover.1234736374.git.trast@student.ethz.ch>
	<fb1e427bf56f5061634bc57fe6837f75e36c6cb2.1234736374.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 16 10:45:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ02R-0005iU-F2
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 10:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbZBPJnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 04:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752630AbZBPJnw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 04:43:52 -0500
Received: from imag.imag.fr ([129.88.30.1]:53110 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbZBPJnv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 04:43:51 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n1G9d5w9001684
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Feb 2009 10:39:05 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LYzwO-0006g1-VU; Mon, 16 Feb 2009 10:39:04 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LYzwO-0001ol-RT; Mon, 16 Feb 2009 10:39:04 +0100
In-Reply-To: <fb1e427bf56f5061634bc57fe6837f75e36c6cb2.1234736374.git.trast@student.ethz.ch> (Thomas Rast's message of "Sun\, 15 Feb 2009 23\:25\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 16 Feb 2009 10:39:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110154>

detail:

Thomas Rast <trast@student.ethz.ch> writes:

> With gcc's --coverage option, we can perform automatic coverage data

I don't think gcc has a --coverage ...

> +COVERAGE_CFLAGS = $(CFLAGS) -O0 -ftest-coverage -fprofile-arcs
> +COVERAGE_LDFLAGS = $(CFLAGS)  -O0 -lgcov

... and this is not the one you are using anyway.

(but great thing to use gcov! thanks)

-- 
Matthieu
