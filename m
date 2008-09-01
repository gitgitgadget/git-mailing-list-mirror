From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Stranges with git-diff-index
Date: Mon, 01 Sep 2008 12:20:26 +0200
Message-ID: <48BBC1EA.6050005@viscovery.net>
References: <48BBB5B4.9080805@school9.perm.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?0KHQtdGA0LPQtdC5INCo0LDRgNGL0LHQuNC9?= 
	<nazgul@school9.perm.ru>
X-From: git-owner@vger.kernel.org Mon Sep 01 12:21:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka6XP-0003Nk-PU
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 12:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYIAKUb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Sep 2008 06:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbYIAKUb
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 06:20:31 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46685 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbYIAKUa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Sep 2008 06:20:30 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ka6WK-0000Js-3O; Mon, 01 Sep 2008 12:20:28 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D813D54D; Mon,  1 Sep 2008 12:20:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48BBB5B4.9080805@school9.perm.ru>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94561>

=D0=A1=D0=B5=D1=80=D0=B3=D0=B5=D0=B9 =D0=A8=D0=B0=D1=80=D1=8B=D0=B1=D0=B8=
=D0=BD schrieb:
> I've found this strange thing in git diff-index. I've got a clear wor=
k
> tree (all changes are commited). Then I've changed some files. After
> this I've run `git diff-index --name-status HEAD` and this command
> showed me changed files. After this I've undid this changes (I did th=
is
> myself, not using git-reset or any stuff like this). But when I run t=
his
> command again it showed me that this files are still changed. After t=
his
> I've run git-status and it told me that there is nothing to commit. A=
nd
> after this git-diff-index tells me that there is no changed files too=
=2E
>=20
> I think it's not normal.

That's perfectly normal.

Low-level git commands ("plumbing", like git diff-index) doesn't look a=
t
the file contents, only at the stat information. Next time use 'git dif=
f
--name-status HEAD'; it wouldn't have reported any changes.

-- Hannes
