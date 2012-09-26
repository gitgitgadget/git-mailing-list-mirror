From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Problem completing remotes when .git/remotes exits
Date: Wed, 26 Sep 2012 03:09:38 +0200
Message-ID: <20120926010938.GD10144@goldbirke>
References: <505A2330.9040800@kdbg.org>
 <20120925230045.GA13266@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 03:09:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGg8N-0007yb-A3
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 03:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158Ab2IZBJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 21:09:41 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:64148 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab2IZBJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 21:09:40 -0400
Received: from localhost6.localdomain6 (p5B130672.dip0.t-ipconnect.de [91.19.6.114])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Lo5FM-1TwbWN0hC4-00gUUF; Wed, 26 Sep 2012 03:09:39 +0200
Content-Disposition: inline
In-Reply-To: <20120925230045.GA13266@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:ZEw+H77Vte4ilabmH47r0XChpB/islmvcSUTW2HW5Vo
 P/E7dqI3Ov2vXcN/ZEmrjW1XVTLJeUuSDbG/nQno0+2WV3GYXf
 ZhUXM/rPRPswTGAW3VjBS15wvo8NL2/mhChMqFu4cHvl37eS/n
 6aKdgy9KBR2zs90wdF4Tx1yhB3nX+naYMxHLJOUrSGAFHpSGSB
 i+APcEoHTTU99WSFWsloZ4IbMVD6dqJnrZn25mFJTqAMZydzS6
 5poGOgZ2E1cvztnjOPENOM4ZemSRV9aPXHp4GNiafe5IgXq9HK
 XMNOUK39es0c4lRvXLXl/ot7tmEAQRBk5t/ow05d2NT24tWUhl
 UiG4C3+H2859lz10sw4E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206389>

On Wed, Sep 26, 2012 at 01:00:45AM +0200, SZEDER G=E1bor wrote:
> But then it got me thinking...  Notice how much effort we spend just
> to get the list of remotes?  We could just run 'git remote' directly
> instead...

Actually, we can't, because 'git remote' doesn't seem to list remotes
stored under .git/remotes.  Is that intentional?

Anyway, we could still use 'git remote' to replace at least the config
query and the for loop to spare a few lines of code and a subshell.
