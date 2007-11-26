From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Rebase/cherry-picking idea
Date: Mon, 26 Nov 2007 13:51:02 +0100
Message-ID: <474AC136.8060906@viscovery.net>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com> <C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr> <D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com> <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 13:51:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwdQw-0007Nm-PE
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 13:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbXKZMvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Nov 2007 07:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753057AbXKZMvM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 07:51:12 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:48988 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbXKZMvL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 07:51:11 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IwdPu-0004YF-6V; Mon, 26 Nov 2007 13:50:27 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 07AF36B7; Mon, 26 Nov 2007 13:51:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66069>

Wincent Colaiuta schrieb:
> El 26/11/2007, a las 12:27, Wincent Colaiuta escribi=F3:
>> So I think that misleading noise needs to be suppressed or reworded=20
>> when rebasing. Will look into it.
>=20
> How about something like this? It would obviously be nice if we could=
=20
> avoid adding another option to builtin-revert; perhaps when/if=20
> git-rebase becomes a builtin we can avoid that. The other alternative=
,=20
> and probably one I like I bit more, would be to auto-detect that a=20
> rebase is in progress by looking inside the GIT_DIR, although that wo=
uld=20
> also alter the behaviour of manual invocations of git-revert and=20
> git-cherry-pick during an interactive rebase (do people actually do=20
> that?). What do you think?

Introduce an environment variable _GIT_CHERRY_PICK_HELP (note the leadi=
ng=20
underscore), which git-rebase sets; if it's set, git-cherry-pick uses t=
hat=20
text instead of the usual one.

-- Hannes
