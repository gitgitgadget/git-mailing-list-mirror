From: =?utf-8?Q?R=C3=A9mi_Vanicat?= <vanicat@debian.org>
Subject: Re: emacs as mergetool
Date: Mon, 26 Sep 2011 19:28:58 +0200
Organization: none
Message-ID: <87ty7zjjqd.dlv@debian.org>
References: <201109261821.28382.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 19:29:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8EzU-0002ZG-MN
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 19:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab1IZR3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 13:29:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:53145 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab1IZR3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 13:29:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R8EzN-0002UQ-Li
	for git@vger.kernel.org; Mon, 26 Sep 2011 19:29:09 +0200
Received: from 66.57.138.88.rev.sfr.net ([88.138.57.66])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 19:29:09 +0200
Received: from vanicat by 66.57.138.88.rev.sfr.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 19:29:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 66.57.138.88.rev.sfr.net
User-Agent: Gnus/5.110017 (No Gnus v0.17) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:xqQ76s37YKPWqdx3SRkHyGJMQgQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182138>

Thomas Koch <thomas@koch.ro> writes:

> Hi,
>
> would you be so kind and give an emacs newbie (and vim refugee) a hin=
t about=20
> using emacs as mergetool?

In fact, I use magit like that: after the merge, if there was a
conflict, I launch magit (M-x magit) and go on the unmerged file, then =
I
use "e" (magit-ediff) to merge them. ediff merge tool is self
documented, and I never needed more than its documentation.

Of course for this you need to install magit, and you don't really use
Emacs as mergetool...

--=20
R=C3=A9mi Vanicat
