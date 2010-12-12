From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Push to all repositories
Date: Sun, 12 Dec 2010 16:09:30 +0100
Message-ID: <20101212150929.GA23298@nibiru.local>
References: <1291829983410-5816069.post@n2.nabble.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 12 16:14:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRndZ-0000UQ-RY
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 16:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642Ab0LLPOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 10:14:52 -0500
Received: from caprica.metux.de ([82.165.128.25]:37485 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751812Ab0LLPOw (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Dec 2010 10:14:52 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oBCFA1C9029779
	for <git@vger.kernel.org>; Sun, 12 Dec 2010 16:10:02 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oBCF9ANi029727
	for git@vger.kernel.org; Sun, 12 Dec 2010 16:09:10 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oBCF9U83031664
	for git@vger.kernel.org; Sun, 12 Dec 2010 16:09:30 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1291829983410-5816069.post@n2.nabble.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163482>

* Kevin Sheedy <kevinsheedy@gmail.com> wrote:

Hi,

> Clearcase has a great solution to this, "dynamic views". Whenever I check in
> some code, the whole team magically get's my changes straight away.
> Normally, they don't even notice, they're just forced to stay in sync. This
> drastically reduces the number of 'code conflicts' where people make changes
> to 'stale' files. This enforces the practise of "catching errors early". It
> also keeps developers "honest" as they have to keep the quality of their
> checkins high lest they get shouted at by the rest of the team.

Are you sure you *really* want this ? 
I'd strongly advise against that.

Better have some central branch (maybe on a dedicated remote)
where everybody can push to, and the others fork off from there
and frequently rebase or merge if they like.


My preferred workflow is to have per-issue branches (eg. per bug,
per feature, etc), which frequently get rebased to the mainline
and are only pushed upwards if they're finished (IOW: only one
person is actively working on an small issue at a time, others
may just read but dont write). Once some issue branch seems to
be ready, it gets rebased to latest master and cleaned up, others
might do some reviews and if it passed all tests (and only then!)
it gets pushed upwards.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
