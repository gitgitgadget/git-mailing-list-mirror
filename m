From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git svn : hook before 'git svn dcommit'
Date: Sun, 03 Jul 2011 23:00:41 +0200
Message-ID: <vpq62njaxl2.fsf@bauges.imag.fr>
References: <vpqfwmos5sg.fsf@bauges.imag.fr>
	<1309726156-31156-1-git-send-email-frederic.heitzmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 03 23:00:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdTmf-0003do-EM
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jul 2011 23:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab1GCVAr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Jul 2011 17:00:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58892 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750973Ab1GCVAq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2011 17:00:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p63L0d4R002564
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 3 Jul 2011 23:00:39 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QdTmU-00039y-49; Sun, 03 Jul 2011 23:00:42 +0200
In-Reply-To: <1309726156-31156-1-git-send-email-frederic.heitzmann@gmail.com>
	(=?iso-8859-1?Q?=22Fr=E9d=E9ric?= Heitzmann"'s message of "Sun, 3 Jul 2011
 22:49:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 03 Jul 2011 23:00:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p63L0d4R002564
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1310331641.33895@tKMtW063GrFcXeIOVAOVjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176589>

=46r=E9d=E9ric Heitzmann <frederic.heitzmann@gmail.com> writes:

> The 'pre-svn-dcommit' hook is called by 'git svn dcommit' and can be =
used to
> prevent some diff to be committed to a SVN repository. It may typical=
ly be
> used to filter some intermediate patches, which were committed into g=
it but
> must not find their way to the SVN repository.

Why 2 patches?

We usually try to have each commit as correct as possible (e.g. when
sending several patches, each commit should still pass the testsuite).
With your 2-patches serie, the first commit has documentation for a
feature which doesn't exist yet.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
