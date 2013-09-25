From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Wed, 25 Sep 2013 21:12:28 +0200
Message-ID: <vpqzjr0pvfn.fsf@anie.imag.fr>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
	<CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
	<CAEQewpqbf-sWSt0GS9eXQNi0yFz5-23NcO2JWKO4OgSFv3SXdA@mail.gmail.com>
	<vpqzjr1ujyn.fsf@anie.imag.fr>
	<CAEQewpoD2VRVtpEyG121TqAptoYfEXxt57CCthBX_EfN7LU0fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jona Christopher Sahnwaldt <jc@sahnwaldt.de>
X-From: git-owner@vger.kernel.org Wed Sep 25 21:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOuVq-0007Hb-U2
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 21:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab3IYTMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 15:12:33 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51873 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754336Ab3IYTMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 15:12:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8PJCQ4C023568
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Sep 2013 21:12:26 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VOuVh-0003aP-8W; Wed, 25 Sep 2013 21:12:29 +0200
In-Reply-To: <CAEQewpoD2VRVtpEyG121TqAptoYfEXxt57CCthBX_EfN7LU0fQ@mail.gmail.com>
	(Jona Christopher Sahnwaldt's message of "Wed, 25 Sep 2013 18:24:20
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Sep 2013 21:12:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8PJCQ4C023568
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1380741147.37219@ZLzMrB2SRJoNtBQZDAQV7Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235366>

Jona Christopher Sahnwaldt <jc@sahnwaldt.de> writes:

> Hi everyone,
>
> tl;dr: The short form "git checkout foo" is a mess. There's simply too
> much "DWIM" magic going on. There are no comprehensible rules how it
> decides if "foo" is a pathspec or a refspec.

There is a very simple rule:

What's on the left hand side of -- are refs, what's on the right hand
side are paths.

When you don't use --, then Git tries to guess, and fails whenever
there's an ambiguity.

>> OK, what happens is that "git checkout wiktionary" is actually a
>> shorthand for "git checkout -b wiktionary --track origin/wiktionary".
>
> No, it isn't.

What I meant was that the short form advised by people were _meant_ to
be a shorthand.

> Let's consider several scenarios:

I don't get your point. Is the overly long list a way of complaining?
Are you suggesting a change? What do you think about the change I'm
proposing?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
