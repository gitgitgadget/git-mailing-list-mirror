From: Philipp Metzler <phil@goli.at>
Subject: Re: git commit -a reports untracked files after a clone
Date: Mon, 16 May 2011 12:49:07 +0200
Message-ID: <7C2AE1EE-4CAE-4E86-A53C-C97BE1F2573B@goli.at>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at> <7v39kgr5ln.fsf@alter.siamese.dyndns.org> <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at> <20110516103829.GA23889@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 12:49:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLvMU-0001L6-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 12:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab1EPKtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 06:49:12 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.31]:55766 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab1EPKtM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 06:49:12 -0400
Received: from [80.120.110.118] (helo=[192.168.1.52])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <phil@goli.at>)
	id 1QLvMK-0006ch-Ig; Mon, 16 May 2011 12:49:08 +0200
In-Reply-To: <20110516103829.GA23889@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
X-Df-Sender: phil@goli.at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173724>

Hi,

Hope this helps. Just let me know if you need additional infos.

[phil@Silberpfeil tmp]$ git clone git://git.kernel.org/pub/scm/git/git.git
Cloning into git...
remote: Counting objects: 140472, done.
remote: Compressing objects: 100% (33586/33586), done.
remote: Total 140472 (delta 105841), reused 139396 (delta 104981)
Receiving objects: 100% (140472/140472), 27.67 MiB | 638 KiB/s, done.
Resolving deltas: 100% (105841/105841), done.
[phil@Silberpfeil tmp]$ cd git
[phil@Silberpfeil git]$ git commit -uall
# On branch master
nothing to commit (working directory clean)
[phil@Silberpfeil git]$ git commit -a
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	t/t9154/
#	t/t9601/
#	t/t9602/
#	t/t9603/
#	t/t9700/
#	t/valgrind/
#	templates/
#	vcs-svn/
#	xdiff/
nothing added to commit but untracked files present (use "git add" to track)
[phil@Silberpfeil git]$ git commit -uall
# On branch master
nothing to commit (working directory clean)
[phil@Silberpfeil git]$ git commit -u
# On branch master
nothing to commit (working directory clean)
[phil@Silberpfeil git]$ git commit --all
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	t/t9154/
#	t/t9601/
#	t/t9602/
#	t/t9603/
#	t/t9700/
#	t/valgrind/
#	templates/
#	vcs-svn/
#	xdiff/
nothing added to commit but untracked files present (use "git add" to track)

Cheers,

Philipp

_______________________________________________________________

DI Philipp Metzler
Goli.at GesbR.
Dorf Rieden 7/11
A-6900 Bregenz
EU - Austria

E-Mail: phil@goli.at
Skype: googol
Tel: +43 / 676 / 72 94 176
ICQ: 13950954

o www.philippmetzler.com - Softwareentwicklung und Websites mit Django und Typo3.
o www.goli.at - Ihr Speicherplatz im Netz. Messen Sie uns an unseren Daten.
o www.clickshopping.at - Wir bringen Ihre Produkte auf den Punkt.
o www.greencar.at - Elektroautos und mehr ...
_______________________________________________________________

Am 16.05.2011 um 12:38 schrieb Jeff King:

> On Sun, May 15, 2011 at 10:26:01AM +0200, Philipp Metzler wrote:
> 
>> [phil@Silberpfeil tmp]$ git --version
>> git version 1.7.5.1
>> [phil@Silberpfeil tmp]$ git clone git://git.kernel.org/pub/scm/git/git.git
>> Cloning into git...
>> remote: Counting objects: 140383, done.
>> remote: Compressing objects: 100% (33498/33498), done.
>> remote: Total 140383 (delta 105777), reused 139383 (delta 104980)
>> Receiving objects: 100% (140383/140383), 27.61 MiB | 642 KiB/s, done.
>> Resolving deltas: 100% (105777/105777), done.
>> [phil@Silberpfeil tmp]$ cd git
>> [phil@Silberpfeil git]$ git commit -a
>> # On branch master
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #	vcs-svn/
>> #	xdiff/
> 
> Can you try this again with "git commit -uall" so we can see which
> specific files in those directories are causing the issue?
> 
> -Peff
