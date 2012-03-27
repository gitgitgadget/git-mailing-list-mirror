From: greened@obbligato.org
Subject: Re: What's cooking in git.git (Mar 2012, #09; Mon, 26)
Date: Mon, 26 Mar 2012 20:16:02 -0500
Message-ID: <87limmdest.fsf@smith.obbligato.org>
References: <7vzkb3kl6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 03:19:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCL4b-00084T-N1
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 03:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab2C0BTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 21:19:40 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:36680 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751828Ab2C0BTj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 21:19:39 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=smith.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1SCHLJ-0001XG-Es; Mon, 26 Mar 2012 16:20:45 -0500
In-Reply-To: <7vzkb3kl6f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 26 Mar 2012 16:16:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: > * dg/test-from-elsewhere
    (2012-03-04) 2 commits > - Support out-of-tree Valgrind tests > - Allow overriding
    GIT_BUILD_DIR > > Better support for out-of-tree test scripts, but it appears
    that the > approach needs to be rethought. By repointing TEST_DIRECTORY to
    a > directory other than $(pwd)/.., an out of place test script can reach
    > test helpers and freshly built Git relative to it (GIT_BUILD_DIR is > a
    mere short-hand for $TEST_DIRECTORY/..). > > Discussion stalled. [...] 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193992>

Junio C Hamano <gitster@pobox.com> writes:

> * dg/test-from-elsewhere (2012-03-04) 2 commits
>  - Support out-of-tree Valgrind tests
>  - Allow overriding GIT_BUILD_DIR
>
> Better support for out-of-tree test scripts, but it appears that the
> approach needs to be rethought.  By repointing TEST_DIRECTORY to a
> directory other than $(pwd)/.., an out of place test script can reach
> test helpers and freshly built Git relative to it (GIT_BUILD_DIR is
> a mere short-hand for $TEST_DIRECTORY/..).
>
> Discussion stalled.

We don't need this anymore, so go ahead and drop it.

                          -Dave
