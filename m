From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: detached HEAD before root commit - possible?
Date: Mon, 24 Jun 2013 00:55:05 +0200
Message-ID: <20130623225505.GO20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 24 00:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqtBi-0001eb-Rc
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 00:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015Ab3FWWzI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Jun 2013 18:55:08 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:50718 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab3FWWzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 18:55:07 -0400
Received: from localhost6.localdomain6 (g227076062.adsl.alicedsl.de [92.227.76.62])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0MHaGK-1Urya5238W-003fRU; Mon, 24 Jun 2013 00:55:05 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:maGQCavN8Rg4/ZYSGd1/cfgp4413O+J72zZjf7xQUBn
 RU9qFSZ58iD6CYgXz6HK9y7LuKHlS/F1GFMc+GAlOTfpWFa0Fj
 HYkAHLlaW3sGno1NYS9FdkgjgJ81PD1rDzcn4rtx6DCVevdnT8
 Z+u0x3txvZ8B8xgUNTygkP5Acx5l3g9DYQQzx2klCau+rDW0jj
 zMBekbCql5/Yd+u+9wNxMJSx1cBzGbBT9JWvF5pfDEK7grxy8A
 R3gL0S2GJ3NG4FlfoaWI0ED5mtRNUtyCIVzLmSOlnbNYV+DLlx
 5aC5YosrYTZYcf/6+BEqyIKe/LBzosWVECLy63xZod1eYNNOeA
 Txae7rcuX0v4QkOmsI6HKa5yx9twVXD8ANfQBZGNa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228765>

I suspect that detaching HEAD before a root commit is not possible by
design.  What would HEAD contain then!?  'git checkout' seems to
corroborate:

$ git init
Initialized empty Git repository in /tmp/test/.git/
$ git checkout --detach
fatal: You are on a branch yet to be born

Are there some plumbing commands and options that would still allow
this, or can I rely on that that it's impossible?


Thanks,
G=E1bor
