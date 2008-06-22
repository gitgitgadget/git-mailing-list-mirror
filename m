From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 1/2] api-parse-options.txt: Introduce documentation for parse options API
Date: Sun, 22 Jun 2008 14:49:08 +0200
Message-ID: <200806221449.08307.barra_cuda@katamail.com>
References: <1214092802-8175-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephan Beyer <s-beyer@gmx.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 14:45:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAOwf-0001P7-Hr
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 14:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYFVMo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Jun 2008 08:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbYFVMo0
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 08:44:26 -0400
Received: from smtp.katamail.com ([62.149.157.154]:32792 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751650AbYFVMo0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jun 2008 08:44:26 -0400
Received: (qmail 705 invoked by uid 89); 22 Jun 2008 12:43:54 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO ?80.104.56.194?) (barra?cuda@katamail.com@80.104.56.194)
  by smtp1-pc with SMTP; 22 Jun 2008 12:43:53 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <1214092802-8175-1-git-send-email-s-beyer@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85765>

On Sunday 22 June 2008, Stephan Beyer wrote:
> +`PARSE_OPT_KEEP_DASHDASH`::
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Usually long options (`\--=
long-opt`) are boiled down to their
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0short option equivalent, i=
f available.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Using this flag, long opti=
ons are kept.

No: PARSE_OPT_KEEP_DASHDASH keeps the "--" that usually separates optio=
ns
from files, as in

	git ls-files [options] -- [files]

i.e. after parsing, the new argv will still contain "--".

> +`OPT__ABBREV(&int_var)`::
> +       Add `\--abbrev [<n>]`.

better:
+       Add `\--abbrev[=3D<n>]`.

since the <n> is optional.
