From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Possible d/f conflict bug or regression
Date: Sat, 29 Mar 2008 09:01:19 +0100
Message-ID: <200803290901.19154.chriscool@tuxfamily.org>
References: <200803290813.08419.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <junkio@cox.net>, krh@redhat.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 08:56:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfVvQ-0002lW-MK
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 08:56:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbYC2Hzn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Mar 2008 03:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbYC2Hzn
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 03:55:43 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:38518 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbYC2Hzm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Mar 2008 03:55:42 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 21BD01AB2C9;
	Sat, 29 Mar 2008 08:55:41 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 035FC1AB2CF;
	Sat, 29 Mar 2008 08:55:40 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200803290813.08419.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78451>

Le samedi 29 mars 2008, Christian Couder a =E9crit :
>
> mkdir testdir &&
>         cd testdir &&
>         touch foo &&
>         git init &&
>         git add . &&
>         git commit -m 'Initial commit.' &&
>         rm foo &&
>         mkdir foo &&
>         git commit -a -m 'Test.'

I don't know if this helps but with "git rm foo" instead of "rm foo" it=
=20
works like this:

Initialized empty Git repository in .git/
Created initial commit e784a71: Initial commit.
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 foo
rm 'foo'
Created commit 232e3ae: Test.
 0 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 foo

Christian.
