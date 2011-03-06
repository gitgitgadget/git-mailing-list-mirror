From: Enrico Weigelt <weigelt@metux.de>
Subject: git for mail synchronization
Date: Sun, 6 Mar 2011 20:10:13 +0100
Message-ID: <20110306191013.GA12688@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 20:13:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwJOj-0003EQ-Nk
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 20:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405Ab1CFTNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 14:13:39 -0500
Received: from caprica.metux.de ([82.165.128.25]:41452 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752610Ab1CFTNj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Mar 2011 14:13:39 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p26JB1E7010477
	for <git@vger.kernel.org>; Sun, 6 Mar 2011 20:11:01 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p26JAxaH010467
	for git@vger.kernel.org; Sun, 6 Mar 2011 20:10:59 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p26JAD5B017342
	for git@vger.kernel.org; Sun, 6 Mar 2011 20:10:13 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168523>


Hi folks,


I'm currently thinking about using git for mail synchronization.
The scenario:

* multiple hosts share a set of maildirs where new mails can be
  added or removed arbitrarily (using non-conflicting filenames,
  eg. their sha-hashes)
* on each host, the current tree is committed in some time
  interval
* the hosts pull from each other and merge in the other's trees.


Could this work well ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
