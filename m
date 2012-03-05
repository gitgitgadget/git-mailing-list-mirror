From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] Support Out-Of-Tree Valgrind Tests
Date: Mon, 5 Mar 2012 08:53:39 +0100
Message-ID: <87aa3vzdoc.fsf@thomas.inf.ethz.ch>
References: <1330903437-31386-1-git-send-email-greened@obbligato.org>
	<1330903437-31386-2-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 08:53:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Sjt-0001EI-S3
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 08:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274Ab2CEHxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 02:53:44 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:24363 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238Ab2CEHxo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 02:53:44 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 08:53:41 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 5 Mar
 2012 08:53:40 +0100
In-Reply-To: <1330903437-31386-2-git-send-email-greened@obbligato.org>
	(greened@obbligato.org's message of "Sun, 4 Mar 2012 17:23:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192211>

greened@obbligato.org writes:

> +# GIT_VALGRIND_TOOLS is the location of tools like valgrind.sh.
> +if test -z "$GIT_VALGRIND_TOOLS"
> +then
> +	# We allow tests to override this, in case they want to run tests
> +	# outside of t/.
> + 
> +        # For in-tree test scripts, this is in TEST_DIRECTORY/valgrind
> +        # (t/valgrind), but a test script that lives outside t/ can
> +        # set this variable to point at the right place so that it can
> +        # find t/valgrind directory that house test helpers like
> +        # valgrind.sh.
> +       GIT_VALGRIND_TOOLS="$TEST_DIRECTORY"/valgrind
> +fi

I'm a bit curious: why isn't it enough to spell that path
$GIT_BUILD_DIR/t/valgrind instead of making it fully configurable?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
