From: Rolf Leggewie <foss@rolf.leggewie.biz>
Subject: Re: broken bash completion
Date: Sat, 05 May 2012 12:24:38 +0800
Message-ID: <4FA4AB86.8020108@rolf.leggewie.biz>
References: <4FA14016.8050503@rolf.leggewie.biz> <20120504233213.GF2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat May 05 06:24:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQWYA-0003ig-QM
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 06:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024Ab2EEEYu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 00:24:50 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:60279 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750888Ab2EEEYt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 00:24:49 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mx.arcor.de (Postfix) with ESMTP id AF28335A56A;
	Sat,  5 May 2012 06:24:47 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id AC5489DB6E;
	Sat,  5 May 2012 06:24:47 +0200 (CEST)
Received: from [192.168.3.3] (unknown [110.55.115.205])
	(Authenticated sender: leggewie@arcor.de)
	by mail-in-13.arcor-online.net (Postfix) with ESMTPA id C1C412123EA;
	Sat,  5 May 2012 06:24:44 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-13.arcor-online.net C1C412123EA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120504233213.GF2164@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197090>

Dear G=E1bor,

thank you for taking the time to write up an analysis and offer some=20
workarounds to the bash-completion issue I reported.  That is much=20
appreciated.

After all is said and done, though, the bash-completion remains=20
inconsistent and thus broken.  It's great that your life is currently=20
more convenient but in the end you are relying on broken behaviour.

Affected commands:
git log
git diff
git whatchanged
git branch (why offer tags OR files here at all)
[...]

Unaffected programs, i.e. working correctly:
git commit
[...]

Some consistency would be great.  In a perfect world bash-completion=20
ought to work on all possible completion targets but at the same time i=
t=20
should exclude all that make no sense, too.  Neither of the two seems t=
o=20
be currently the case.

I had a look at /etc/bash_completion.d/git to see if there was some wor=
k=20
I could do to cook up a patch, but unfortunately, it's all greek to me=20
in there.

Regards

Rolf
