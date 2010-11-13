From: Enrico Weigelt <weigelt@metux.de>
Subject: Using a different index and HEAD
Date: Sat, 13 Nov 2010 16:29:06 +0100
Message-ID: <20101113152906.GA24903@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 16:44:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHIHB-0006WC-Tr
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 16:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151Ab0KMPml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 10:42:41 -0500
Received: from caprica.metux.de ([82.165.128.25]:38058 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754825Ab0KMPml (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Nov 2010 10:42:41 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oADFihTC014914
	for <git@vger.kernel.org>; Sat, 13 Nov 2010 16:44:45 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oADFiEVh014845
	for git@vger.kernel.org; Sat, 13 Nov 2010 16:44:14 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oADFT6J2002742
	for git@vger.kernel.org; Sat, 13 Nov 2010 16:29:06 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161388>


Hi folks,


I'm currently thinking about an IDE toolkit entirely based on git,
which eg. versions every single file save operation (so, IOW: an
separately versioned workdir) automatically and later allows to
rebase/rework this to tell what really gets committed to the
actual working branch. For this multiple indices and refs/HEAD
pointers would be very helpful.

Is there already a way to tell other locations for index file
and current HEAD symref on command line (just like we have w/
--work-dir etc) ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
