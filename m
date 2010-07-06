From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] t/README: document more test helpers
Date: Tue, 6 Jul 2010 15:04:10 -0500
Message-ID: <20100706200410.GA7606@burratino>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
 <20100702192102.GA6585@burratino>
 <AANLkTilI0NZiDk3I850x28pr5I0sYRiPLW7HAST9sduU@mail.gmail.com>
 <m3wrtdm1y9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nazri Ramliy <ayiehere@gmail.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 22:06:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWEPA-0007Rc-GP
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 22:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab0GFUGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 16:06:00 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64056 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128Ab0GFUF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 16:05:59 -0400
Received: by iwn7 with SMTP id 7so7007988iwn.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 13:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UMN4mnvk1sWY9+ycPAaRQEuXOKYa9PhFcaKF07DhaTg=;
        b=W1cv7TgG6axJPUHgKXtp41sYhuMf/aEWaBJg/aUkq9ZpDmgjTShtO2f8NCwbzaT9f5
         HucXPeBvh9BRq2PebCH4jqPV3h0hlSxHZDiuYxkK1DAmNfEnBcZO22Ta/ts435FftbqR
         +u/pChytANJuFJ+RxSkjhEON08t6U5TQiN8z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NIh7w603OsLcy/DA05/70uCAiX3du9Mx58Chg3XytlTFc7fYMMa6bdGPWW3lYeQ6L3
         mqb9Mn+DG1QJIcwCln27+wir+W7sUTCijS6fdAgsOp3AYlsvUjp90Copu65C/JubonQP
         l73Lkew0s7/k3JRQKIJmnRwfscNYNAYAsWvHE=
Received: by 10.231.168.135 with SMTP id u7mr5590329iby.125.1278446758154;
        Tue, 06 Jul 2010 13:05:58 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm22570696ibb.14.2010.07.06.13.05.57
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 13:05:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3wrtdm1y9.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150406>

There is no documentation in t/README for test_must_fail,
test_might_fail, test_cmp, or test_when_finished.

Reported-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jakub Narebski wrote:

> Sidenote: test_when_finished, introduced by Jonathan Nieder in 3bf7886
> (test-lib: Let tests specify commands to be run at end of test,
> 2010-05-02) is not documented in t/README.

Good catch.

> Also, shouldn't it be
> named 'when_finished_test' rather than 'test_when_finished'?

It uses the test_* name to avoid a land-grab by test-lib.sh for other
namespaces.

> Currently 'test_when_finished' / 'when_finished_test' is used only in
> t0000-basic and t7509-commit.

Right, I have some ideas for using this but it is hard to find time.

Thanks for the comments.  Patch is on top of 6fd4529 (t/README:
proposed rewording..., 2010-07-05) from 'next'.

 t/README |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 271f868..9df0ae9 100644
--- a/t/README
+++ b/t/README
@@ -448,6 +448,37 @@ library for your script to use.
 	    'Perl API' \
 	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
 
+ - test_must_fail <git-command>
+
+   Run a git command and ensure it fails in a controlled way.  Use
+   this instead of "! <git-command>" to fail when git commands
+   segfault.
+
+ - test_might_fail <git-command>
+
+   Similar to test_must_fail, but tolerate success, too.  Use this
+   instead of "<git-command> || :" to catch failures due to segv.
+
+ - test_cmp <expected> <actual>
+
+   Check whether the content of the <actual> file matches the
+   <expected> file.  This behaves like "cmp" but produces more
+   helpful output.
+
+ - test_when_finished <script>
+
+   Prepend <script> to a list of commands to run to clean up
+   at the end of the current test.  If some clean-up command
+   fails, the test will not pass.
+
+   Example:
+
+	test_expect_success 'branch pointing to non-commit' '
+		git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
+		test_when_finished "git update-ref -d refs/heads/invalid" &&
+		...
+	'
+
 
 Tips for Writing Tests
 ----------------------
-- 
1.7.2.rc1
