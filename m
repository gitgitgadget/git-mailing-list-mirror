From: Enrico Weigelt <weigelt@metux.de>
Subject: Incremental push w/o compression
Date: Thu, 28 Oct 2010 02:22:26 +0200
Message-ID: <20101028002224.GA6335@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 02:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBGUr-0004Xf-Sq
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 02:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757682Ab0J1AhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 20:37:24 -0400
Received: from caprica.metux.de ([82.165.128.25]:59251 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751935Ab0J1AhW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 20:37:22 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o9S0cwSu030857
	for <git@vger.kernel.org>; Thu, 28 Oct 2010 02:39:00 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9S0cRfq030778
	for git@vger.kernel.org; Thu, 28 Oct 2010 02:38:27 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o9S0MRgr012878
	for git@vger.kernel.org; Thu, 28 Oct 2010 02:22:27 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160140>

Hi folks,


as discussed in earlier threads, I'm using git for backups on an
machine with quite low memory. Committing works fine now, but
pushing still makes trouble: it takes way too long for compressing.
Is there a way do disable delta compression and transfer the
objects (at least the larger ones) separately (so they're already
on the remote and dont have to be re-transmitted in next pass,
even when the refs have not yet been updated) ?


BTW: what really happens when I push another ref, which has mostly
the same objects, but a different history ? Will the already
present objects be reused or are they all transfered a second time ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
