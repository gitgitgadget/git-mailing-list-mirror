From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Avery Pennarun's git-subtree?
Date: Tue, 27 Jul 2010 23:14:53 +0200
Message-ID: <4C4F4C4D.608@web.de>
References: <AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> <AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> <AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> <4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> <m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> <4C49B0E9.1090300@web.de> <AANLkTimSoe9iqu4cJCH1d4rVsWHpFn3+8pbrCxsnVM1D@mail.gmail.com> <4C4C9743.9080902@web.de> <20100727184047.GC25124@worldvisions.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= =?ISO-8859-1?Q?_Bjarmason?= 
	<avarab@gmail.com>, Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:15:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrUR-000864-OE
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab0G0VO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:14:59 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:40456 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab0G0VO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:14:58 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate02.web.de (Postfix) with ESMTP id 5C93116CE980A;
	Tue, 27 Jul 2010 23:14:56 +0200 (CEST)
Received: from [80.128.76.222] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OdrUG-00026D-00; Tue, 27 Jul 2010 23:14:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <20100727184047.GC25124@worldvisions.ca>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/jlqboxaTZ3pndh5HYZYGWovGdHpvBTqRxglLD
	5nbIYCXxNRePSaN4LAn6unW85HxFVKiUgz6ma9hKn8dVAItSVV
	ysHyFAucK30b9n+OFAQQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151996>

Am 27.07.2010 20:40, schrieb Avery Pennarun:
> With what you're proposing, for all my submodules, we can't each have our
> own project; we all have to push to the shared one.
> 
> (Just to be clear: I don't want to fork *every submodule by hand every
> time*.  I just want *my* stuff to be in *my* repo.  The easiest way to do
> this would be to have all my changes in a single repo, ie. my fork of the
> superproject.)

Fair enough, but that would not be the Right Thing for my use cases.
(E.g. I am using submodules to have a single upstream repo for a library
which I use in almost all my projects. And fixes to that library I do in
one of these projects shall be fetchable in all other projects right
after I pushed them to the submodules repo, without having to push them
out of the superprojects repo into the shared one /again/. The situation
at dayjob is the same and I assume a lot of people are using submodules
this way).

So I would vote for not breaking the *feature* submodules currently have:
to use a different repo than that used for the superproject. Because that
enables you to have shared content. I am not against having the /choice/
to have the submodules objects in the same repo as the superproject, but
that should be an option and not mandatory.
