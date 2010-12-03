From: Enrico Weigelt <weigelt@metux.de>
Subject: interfacing M$-TFS
Date: Fri, 3 Dec 2010 22:01:39 +0100
Message-ID: <20101203210139.GB14508@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 22:05:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcom-0004Nw-GM
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab0LCVFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 16:05:17 -0500
Received: from caprica.metux.de ([82.165.128.25]:43780 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752344Ab0LCVFQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 16:05:16 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oB3L7pic000824
	for <git@vger.kernel.org>; Fri, 3 Dec 2010 22:07:52 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oB3L75a3000807
	for git@vger.kernel.org; Fri, 3 Dec 2010 22:07:05 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oB3L1dUA002512
	for git@vger.kernel.org; Fri, 3 Dec 2010 22:01:39 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162854>


Hi folks,


is there any way for directly interfacing M$-TFS (w/o its svn proxy) ?

I'm currently working on an embedded linux project and my customer
has a company wide policy to put everything into - please put on
you intellectual seatbelt - M$ TFS.

Needless to mention that TFS' VCS stuff is practically unusable,
but some collegues still committing directly to TFS (haven't
conviced them to switch over to git), and releases have to be
put there, as QA folks dont know anything else.

My current workflow is:

#1: a main branch, frequently copied over TFS manually (;-o)
#2: lots of topic branches which get rebased onto master
#3: finished topic branches are rebased to latest master and
    then copied over to and committed in TFS

Of course, that much manual work - especially with the need of 
checking out / locking invidual files in TFS - really suxx and
wastes a lot of time. So I'm looking for way to:

a) track remote branches from TFS
b) push back changes into a TFS remote tracking branch

Both should be possible from Linux side, using the native protocol
(very unlikely that IT department can be convinced to install the
svn proxy for TFS).



thx
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
