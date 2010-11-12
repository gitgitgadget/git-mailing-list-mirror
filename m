From: Enrico Weigelt <weigelt@metux.de>
Subject: Incremental object transfer
Date: Fri, 12 Nov 2010 11:34:27 +0100
Message-ID: <20101112103427.GA29057@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 11:48:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGrBg-0008R3-CC
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 11:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756726Ab0KLKsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 05:48:32 -0500
Received: from caprica.metux.de ([82.165.128.25]:48993 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756378Ab0KLKsb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Nov 2010 05:48:31 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oACAoXX0020439
	for <git@vger.kernel.org>; Fri, 12 Nov 2010 11:50:33 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oACAo3V1020343
	for git@vger.kernel.org; Fri, 12 Nov 2010 11:50:03 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oACAYS9w008230
	for git@vger.kernel.org; Fri, 12 Nov 2010 11:34:28 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161334>


Hi folks,


as already said some time ago, I'm using git to back up maildirs
on a machine w/ relatively low ram. The biggest problem for now
is the initial push (maybe later larger subsequent pushes could
be also affected too): it takes quite a long time to get everything
packed, and if the connection breaks (the box is sitting behind
a dynamic-IP DSL link), everything has to be restarted :(

So my idea is to incrementally transfer objects in smaller packs,
disable gc on remote side and update refs when some commit is
complete.

Is there any way to do this ?


thx
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
