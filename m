From: Enrico Weigelt <weigelt@metux.de>
Subject: svn import missing locks ?
Date: Tue, 17 Aug 2010 17:06:20 +0200
Message-ID: <20100817150619.GA12682@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 17:14:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlNru-00037L-5g
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 17:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab0HQPOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 11:14:18 -0400
Received: from caprica.metux.de ([82.165.128.25]:43793 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751493Ab0HQPOR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 11:14:17 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7HFE12K007748
	for <git@vger.kernel.org>; Tue, 17 Aug 2010 17:14:02 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7HFDM6A007723
	for git@vger.kernel.org; Tue, 17 Aug 2010 17:13:22 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7HF6K1D015260
	for git@vger.kernel.org; Tue, 17 Aug 2010 17:06:20 +0200
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153752>


Hi folks,


while importing an larger svn repository, my automatic maintenance
script (running gc+repack) hit in and produced an error:

    notice: HEAD points to an unborn branch (master)                                                                                   
    missing tree ce26e3c6e1a46c8b4ec57cf509da3e7c1acc932d                                                                              

looks like git-svn doesnt properly lock (otherwise git-gc would
have refused to run due lock, IMHO).

I'll yet have to wait until the import went through and check if
something got broken ...


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
