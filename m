From: Andreas Stricker <astricker@futurelab.ch>
Subject: Re: Fwd: Error with git-svn pushing a rename
Date: Fri, 15 Nov 2013 14:36:29 +0100
Organization: FutureLAB
Message-ID: <5286235D.9060602@futurelab.ch>
References: <CAM-uYMgy8duxdGY8rbCJv9To3FFMAUDv22nnzbQ+e3QrTCLLpQ@mail.gmail.com>	<CAM-uYMigCTK=j3HkyT0F=jtDoDERdtkpZiTXRvBhSHJW3edJ-w@mail.gmail.com>	<CAM-uYMiK4wkQyGJLemSAbNwHJNoH-k8Zv0W2yBtnTCbsFLj8Fg@mail.gmail.com>	<5285CE6C.2030609@futurelab.ch> <CAM-uYMgn4SGqurqRG-RDiicLxpf9NfTPUvNn9FaFUUbxFRJsZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Benjamin Pabst <benjamin.pabst85@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 15 14:36:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhJZe-00010a-Oe
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 14:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab3KONgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 08:36:35 -0500
Received: from host-179.futurelab.ch ([62.2.169.179]:47690 "EHLO
	primus.futurelab.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab3KONge (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 08:36:34 -0500
Received: from astricker.futurelab.ch (localhost.localdomain [127.0.0.1])
	(authenticated bits=0)
	by primus.futurelab.ch (8.13.8/8.13.8/fL-3.7) with ESMTP id rAFDaUsi023354;
	Fri, 15 Nov 2013 14:36:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <CAM-uYMgn4SGqurqRG-RDiicLxpf9NfTPUvNn9FaFUUbxFRJsZw@mail.gmail.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237906>

Hi Benjamin

> thanks for your link. Can you give me the exact version you
> downgraded svn to?

svn, Version 1.7.10 (r1485443)

I tried to reproduce the problem with git version 1.8.4.2 and
Subversion version 1.8.4 (r1534716) with a fresh and pristine
subversion repo and a git-svn clone of it: I didn't manage to
reproduce the rename issue. Then I switched subversion back to
1.7.10, created both the repo and the git-svn clone, switched
againt to 1.8.4.2 and then got an error. Unfortunately I didn't
check if the subversion perlbindings were regenerated, so I'm
not exactly sure. I'll repeat the test again, as soon I've find
the time.

It looks like a fresh git svn clone may fix the problem.

Regards, Andy
