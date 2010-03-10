From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 21:09:16 +0100
Message-ID: <201003102109.17210.j6t@kdbg.org>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302> <fabb9a1e1003091648q103ffa9co805233b57ddb3cc0@mail.gmail.com> <alpine.DEB.1.00.1003100222190.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 21:11:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpSFQ-00063W-GY
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 21:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972Ab0CJULL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 15:11:11 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:20194 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756966Ab0CJULJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 15:11:09 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 39F642C400D;
	Wed, 10 Mar 2010 21:11:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 749ED19F60C;
	Wed, 10 Mar 2010 21:09:17 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <alpine.DEB.1.00.1003100222190.7596@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141918>

On Mittwoch, 10. M=E4rz 2010, Johannes Schindelin wrote:
> On Wed, 10 Mar 2010, Sverre Rabbelier wrote:
> > On Tue, Mar 9, 2010 at 19:24, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > - Substantially speeded up startup time from cmd unless
> > >   NO_FSTAB_THREAD is =A0set (thanks Johannes Sixt).
> >
> > Sweet, any numbers?
>
> Yes: http://article.gmane.org/gmane.comp.version-control.msysgit/7986
>
> Basically, if you are not running Git from Git Bash, but from cmd.exe=
,
> every single call to MSys programs (such as sh.exe, perl.exe, sed.exe=
,
> etc) will take 100ms extra.
>
> > Also, why would I need to set NO_FSTAB_THREAD?
>
> When you want to access a USB stick that you plugged in after startin=
g Git
> Bash.

1. The environment variable name is MSYS_WATCH_FSTAB.

2. Unfortunately, it does not make a plugged-in USB stick visible to a =
running=20
bash; this non-feature is not addressed by this variable.

3. You would want to set the variable to non-zero if you frequently=20
edit /etc/fstab while an interactive bash is running. :-P

-- Hannes
