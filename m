From: Enrico Weigelt <weigelt@metux.de>
Subject: Make git-push silent
Date: Thu, 21 Oct 2010 20:19:06 +0200
Message-ID: <20101021181906.GA28700@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 20:35:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8zz9-0004nM-NE
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 20:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191Ab0JUSf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 14:35:26 -0400
Received: from caprica.metux.de ([82.165.128.25]:46248 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753335Ab0JUSfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 14:35:25 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Oct 2010 14:35:25 EDT
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o9LIV1QJ030748
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 20:31:04 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9LIUZc7030098
	for git@vger.kernel.org; Thu, 21 Oct 2010 20:30:35 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o9LIJ6LK031396
	for git@vger.kernel.org; Thu, 21 Oct 2010 20:19:06 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159531>


Hi folks,


is there a way to make git-push silent in a way that it only 
outputs something in case of error ?

I'm using it as a backup tool via cron scripts, and therefore I
dont want any output when everything went okay.

If there's no such a feature/switch yet, could anyone give me
a hint where/how to implement this ?


thx
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
