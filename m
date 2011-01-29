From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Permissions and authorisations in git repository
Date: Sat, 29 Jan 2011 18:28:15 +0100
Message-ID: <20110129172815.GB602@nibiru.local>
References: <1296214884133-5969556.post@n2.nabble.com> <20110128150631.33be0a9d.kostix@domain007.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 29 18:36:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjEjJ-0005Ko-AT
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 18:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab1A2Rgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 12:36:39 -0500
Received: from caprica.metux.de ([82.165.128.25]:39473 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754057Ab1A2Rgi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 12:36:38 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p0THX1gq011453
	for <git@vger.kernel.org>; Sat, 29 Jan 2011 18:33:04 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p0THWYW3011422
	for git@vger.kernel.org; Sat, 29 Jan 2011 18:32:34 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p0THSFUl006399
	for git@vger.kernel.org; Sat, 29 Jan 2011 18:28:15 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110128150631.33be0a9d.kostix@domain007.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165663>

* Konstantin Khomoutov <flatworm@users.sourceforge.net> wrote:

<snip>

In fact, git does not have any access control whatsoever. It relies
on what the underlying transport protocol allows it to do.

With ssh, you could wrap the commands into some script which checks,
the permissions on calling-in user or key (eg. restrict write access
on certain refs to certain people). You could do even more fancy
things like given everybody (or certain people) unrestricted write
access, but under the hood put their rename the updated refs
(eg. you can push 'master', but on the server, refs/heads/master
wont be overwritten, instead it goes to refs/heads/konstantin/master).

Some people (coming from strictly-central ideologies) might consider
git's access control angonsticity a drawback, but IMHO it's a very
good thing - git doesn't want to be a full-blown "out-of-the-box"
VCS (like, eg. clearcase), but more a lightweight toolkit to easily
build your own.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
