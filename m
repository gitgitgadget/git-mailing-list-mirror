From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: [long] worktree setup cases
Date: Fri, 22 Oct 2010 07:00:12 +0200
Message-ID: <20101022050011.GA27179@nibiru.local>
References: <20101020085859.GA13135@do> <20101020190709.GB10537@burratino> <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com> <20101021033042.GA1891@burratino> <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com> <20101021185132.GB28700@nibiru.local> <AANLkTinS0co8TMmyRCQ4Xe9+pDR-uUn20WNQwYJEAQea@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 07:09:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P99t3-0007vq-Ir
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 07:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838Ab0JVFJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 01:09:35 -0400
Received: from caprica.metux.de ([82.165.128.25]:39076 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751273Ab0JVFJe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 01:09:34 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o9M5B1Pu001518
	for <git@vger.kernel.org>; Fri, 22 Oct 2010 07:11:03 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9M5AsIZ001509
	for git@vger.kernel.org; Fri, 22 Oct 2010 07:10:54 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o9M50CK0029019
	for git@vger.kernel.org; Fri, 22 Oct 2010 07:00:12 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTinS0co8TMmyRCQ4Xe9+pDR-uUn20WNQwYJEAQea@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159643>

* Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Fri, Oct 22, 2010 at 1:51 AM, Enrico Weigelt <weigelt@metux.de> wrote:
> >> Also the "relative to $GIT_DIR" may be confusing. If $GIT_DIR points
> >> to a file that points to a true repo, then to which one it is
> >> relative?
> >
> > Despite the fact that I doubt the usefulness of an .git file at
> > all, it IMHO should be interpreted as an kind of userland symlink.
> 
> I do find .git file useful. I put my worktree in a server where it can
> be wiped out completely. So I don't want to put my .git there. .git
> file can be used this case so I don't have to set
> GIT_DIR/GIT_WORK_TREE every time and my .git is safe elsewhere.

Why not using a symlink here ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
