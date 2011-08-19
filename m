From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Unable to build git on Lion - missing config.h from Perl header files
Date: Sat, 20 Aug 2011 00:12:17 +0200
Message-ID: <201108200012.17580.trast@student.ethz.ch>
References: <611AB1F99D784B92B1F7278139D6EED5@gmail.com> <9B588F2F-ACDF-4DA7-BE30-E075CA729731@gmail.com> <CAGDPfJoG_ksfL5vqzGWe5jqW646CKB=Qxm9_G5d=ZHMWfixweA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sorin Sbarnea <sorin.sbarnea@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 00:12:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuXIg-0003XD-1Z
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:12:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756225Ab1HSWMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 18:12:21 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:50552 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006Ab1HSWMU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 18:12:20 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sat, 20 Aug
 2011 00:12:14 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.1; Sat, 20 Aug
 2011 00:12:17 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.1-40-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <CAGDPfJoG_ksfL5vqzGWe5jqW646CKB=Qxm9_G5d=ZHMWfixweA@mail.gmail.com>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179734>

Sorin Sbarnea wrote:
> This was a clean-new Lion install, not an upgrade. I just installed
> Xcode on alternate location /Developer41 instead of /Developer
> 
> Yes, I did a `make clean` but it has no effect.
> 
> The problem is that on Lion there is no config.h in the perl
> directory, only a perl.h file.

Color me puzzled, but where is it getting the config.h idea from?

  $ git grep config\\.h
  compat/fnmatch/fnmatch.c:# include <config.h>
  compat/regex/regex.c:#include "config.h"
  t/t4014-format-patch.sh:test_expect_success '--no-add-headers overrides config.headers' '

Similarly, 'git grep config perl' only turns up matches in perl code.
So what tells it to use config.h?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
