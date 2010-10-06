From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [TOY PATCH] test-lib: &&-chaining tester
Date: Wed, 06 Oct 2010 10:09:11 +0200
Message-ID: <vpqeic3agk8.fsf@bauges.imag.fr>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
	<20101006053118.GA29289@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 10:11:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3P5f-0003hQ-FI
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 10:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab0JFIJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 04:09:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36039 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280Ab0JFIJg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 04:09:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9683o4P007112
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Oct 2010 10:03:50 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P3P3n-0002FC-LU; Wed, 06 Oct 2010 10:09:11 +0200
In-Reply-To: <20101006053118.GA29289@burratino> (Jonathan Nieder's message of "Wed\, 6 Oct 2010 00\:31\:18 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Oct 2010 10:03:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9683o4P007112
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1286957032.91773@PWUwvCqJf9GN0uWjhykb+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158270>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Elijah Newren wrote:
>
>> This patch series fixes many of the missing &&s in the testsuite.
>
> Thanks again.  Here's a little glimpse of a future without missing &&s
> to play with.

Probably a silly question, but is there any reason why we use these &&
instead of a "set -e" once and for all?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
