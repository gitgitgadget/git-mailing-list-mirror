From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: GIT & Symbolic Links
Date: Sat, 17 Mar 2012 17:00:15 +0100
Message-ID: <20120317160015.GB18712@mailgate.onlinehome-server.info>
References: <CACHQFzEqe-SwpCgjgGRDdzcUQW_+8-TdLsRV6KbKorvq7dJi+g@mail.gmail.com>
 <CACHQFzEJATc2hiSdAgoGg3vssQ-CShF+89TOkzVwaf_ujYy+3w@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 17:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8w6H-0005tE-F4
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 17:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302Ab2CQQDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 12:03:21 -0400
Received: from caprica.metux.de ([82.165.128.25]:38535 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755783Ab2CQQDU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2012 12:03:20 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id q2HG0FZI019481
	for <git@vger.kernel.org>; Sat, 17 Mar 2012 17:00:15 +0100
Received: (from weigelt@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) id q2HG0FEA019480
	for git@vger.kernel.org; Sat, 17 Mar 2012 17:00:15 +0100
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACHQFzEJATc2hiSdAgoGg3vssQ-CShF+89TOkzVwaf_ujYy+3w@mail.gmail.com>
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193335>

* Sassy Natan <sassyn@gmail.com> wrote:

Hi,

> So for the example let's consider that user A clone the DEV GIT Repo
> into his/her home folder (/home/A/DEV)
> User B want to clone the same Repo. But now, I don't want user B to
> clone the all tree and files, but instead to have a symbolic links to
> the /home/A/DEV folder.
> All files and directories in the /home/B/DEV will be a links to the /home/A/DEV.

Symlinks wont fit here, as the userland sees them as links (and treats
them as such). What you're looking for is some solution that does the cow
stuff hidden from the normal userland. Perhaps via unionfs or something
fuse-based.

BUT: I'd first raise the question if your tree needs to be that big
at all. Perhaps it should be splitted into several smaller ones.
What actually does your tree make that big ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
