From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Mon, 29 Aug 2011 15:02:35 -0700
Message-ID: <CA+55aFxB7mBByT9W4c0D6kELcZMZDD_j0_S2869nS4LV0mNTbA@mail.gmail.com>
References: <4E56CE8F.8080501@panasas.com> <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com>
 <4E580830.4010305@panasas.com> <1314624752.2816.32.camel@twins> <4E5BFD36.2090000@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 00:03:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9vd-0002pF-2k
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 00:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123Ab1H2WDc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Aug 2011 18:03:32 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53240 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753945Ab1H2WDa convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 18:03:30 -0400
Received: from mail-ww0-f44.google.com (mail-ww0-f44.google.com [74.125.82.44])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p7TM2uSE017629
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL);
	Mon, 29 Aug 2011 15:02:57 -0700
Received: by wwf5 with SMTP id 5so6190142wwf.1
        for <multiple recipients>; Mon, 29 Aug 2011 15:02:56 -0700 (PDT)
Received: by 10.216.161.146 with SMTP id w18mr26496wek.70.1314655376156; Mon,
 29 Aug 2011 15:02:56 -0700 (PDT)
Received: by 10.216.187.66 with HTTP; Mon, 29 Aug 2011 15:02:35 -0700 (PDT)
In-Reply-To: <4E5BFD36.2090000@panasas.com>
X-Spam-Status: No, hits=-105.01 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180365>

On Mon, Aug 29, 2011 at 1:57 PM, Boaz Harrosh <bharrosh@panasas.com> wr=
ote:
>
> =A0What are you guys afraid of? what possibly could be bad about this=
 patch?

I just detest filling the kernel tree with git stuff.

Right now, the only git-specific file we have in the kernel tree is
the ".gitignore" files, afaik. And if you were to use some other SCM,
the "ignore" model at least translates directly to just about anything
else (with the problem that the .gitignore model tends to be more
powerful than most other SCM's have, but whatever).

I'd hate to start populating the project with more stuff.

                     Linus
