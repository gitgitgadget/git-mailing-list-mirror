From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git rm --cached and pull semantics
Date: Sun, 17 Jan 2010 16:06:39 -0800
Message-ID: <86my0c5l9s.fsf@blue.stonehenge.com>
References: <4B51EE39.3010401@phuk.ath.cx> <vpq1vhpufec.fsf@bauges.imag.fr>
	<4B53941A.6020500@phuk.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: list@phuk.ath.cx
X-From: git-owner@vger.kernel.org Mon Jan 18 01:28:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWfUA-0006Tl-HQ
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 01:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab0ARA2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 19:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754211Ab0ARA2p
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 19:28:45 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:21444 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab0ARA2p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 19:28:45 -0500
X-Greylist: delayed 1326 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2010 19:28:45 EST
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 1B02A1DE4CD; Sun, 17 Jan 2010 16:06:39 -0800 (PST)
x-mayan-date: Long count = 12.19.17.0.11; tzolkin = 1 Chuen; haab = 9 Muan
In-Reply-To: <4B53941A.6020500@phuk.ath.cx> (list@phuk.ath.cx's message of "Sun, 17 Jan 2010 23:50:02 +0100")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137350>


The real WTF here is that you are using a workdir as your live dir.

If you treat git as a *source* manager like it is, you'd also have an
installer that would copy the resulting files into their live locations,
and could be edited to either leave that newly untracked file alone,
or deliberately remove it.

Use git as intended, and you get no problems.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
