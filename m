From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git automatic stashing?
Date: Tue, 9 Nov 2010 20:19:09 +0100
Message-ID: <201011092019.09239.trast@student.ethz.ch>
References: <AANLkTim3MacQK6EtTPNJsYbqb=5bOM3W3BXC6p=hT+PU@mail.gmail.com> <AANLkTi=G=Xo90QayvuRDp=GTWtkES2fU0kkmn87Q09_2@mail.gmail.com> <vpqd3qe8g5j.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Casey McGinty <casey.mcginty@gmail.com>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 09 20:19:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFtiv-00083r-Hf
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 20:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab0KITTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 14:19:12 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:54645 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab0KITTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 14:19:11 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 9 Nov
 2010 20:19:08 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 9 Nov
 2010 20:19:09 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-90-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <vpqd3qe8g5j.fsf@bauges.imag.fr>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161065>

Matthieu Moy wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> > On Tue, Nov 9, 2010 at 12:37 PM, Casey McGinty <casey.mcginty@gmail.com> wrote:
> >> Is there any feature in git to perform and auto stash apply/pop when
> >> trying to do a merge/rebase in a dirty working dir? This would save
> >> some keystrokes from time-to-time, and make it easier for new users
> >> unfamiliar with git.
> >
> > And when switching branches too.
> 
> Isn't that what "git checkout -m" does?

The problem with checkout -m is that you get only a single shot at
conflict resolution.  'git stash pop' does not drop the stash in the
case of a conflict, so you can try again.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
