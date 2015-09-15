From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [bug] .git/hooks/commit-msg.sample test is reversed
Date: Tue, 15 Sep 2015 11:10:59 +0200
Message-ID: <vpq8u88cajg.fsf@anie.imag.fr>
References: <55F7DA48.30104@fissore.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Federico Fissore <federico@fissore.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 11:11:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbmGs-0002fc-L2
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 11:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbbIOJLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 05:11:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52298 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbbIOJLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 05:11:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8F9AwQq015468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 15 Sep 2015 11:10:58 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8F9AxvH010024;
	Tue, 15 Sep 2015 11:10:59 +0200
In-Reply-To: <55F7DA48.30104@fissore.org> (Federico Fissore's message of "Tue,
	15 Sep 2015 10:43:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Sep 2015 11:10:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8F9AwQq015468
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442913060.91828@mAkUXm2ZqfFZcN+6sApFKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277898>

Federico Fissore <federico@fissore.org> writes:

> Hello everyone
>
> In file commit-msg.sample, grep test is reversed. It greps
> '^Signed-off-by: '
> while it should grep
> 'Signed-off-by: '
>
> If you run the sample against attached file, it won't complain. Remove
> the ^ and it will work as expected

I think the test is correct.

In grep, ^ can have two meanings:

'^foo' means "foo at the start of a line"
'[^abc]' means "one character but not a, b or c"

The Signed-off-by: trailer is meant to be at the start of a line, hence
the ^.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
