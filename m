From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: GIT as binary repository
Date: Fri, 22 Oct 2010 07:02:58 +0200
Message-ID: <20101022050257.GB27179@nibiru.local>
References: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net> <AANLkTim6qsUDf5LS7C9o+C92Aqh7CohLLJ=+13BE3Tze@mail.gmail.com> <20101021195416.GF28700@nibiru.local> <AANLkTikk5FA-3LQNfjj6rq0ouO7CywZ9_FaaZCGRM_YB@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 07:12:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P99vO-0008SD-ST
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 07:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab0JVFL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 01:11:58 -0400
Received: from caprica.metux.de ([82.165.128.25]:46632 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752668Ab0JVFL6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 01:11:58 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o9M5DPAn001661
	for <git@vger.kernel.org>; Fri, 22 Oct 2010 07:13:27 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9M5DImw001650
	for git@vger.kernel.org; Fri, 22 Oct 2010 07:13:18 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o9M52wDC031015
	for git@vger.kernel.org; Fri, 22 Oct 2010 07:02:58 +0200
Mail-Followup-To: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikk5FA-3LQNfjj6rq0ouO7CywZ9_FaaZCGRM_YB@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159644>

* Shawn Pearce <spearce@spearce.org> wrote:
> On Thu, Oct 21, 2010 at 12:54 PM, Enrico Weigelt <weigelt@metux.de> wrote:
> > BTW: how are the current tree objects structured ? Is there always
> > one big tree object representing the whole tree or can it be
> > splitted hierachically ?
> 
> Trees in the repository are split hierarchically, but its a flat list
> in the dircache/index file (aka $GIT_DIR/index).

Good. That should allow optimizations for large trees w/o
having to change object formats.

What about splitted blobs ? Is this supported by the object
format right now ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
