From: Cristian Tibirna <ctibirna@giref.ulaval.ca>
Subject: fetch --no-tags with and w/o --all
Date: Wed, 06 Mar 2013 16:33:02 -0500
Message-ID: <1879950.i2j8pjGADy@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 22:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDM7R-0006VR-TR
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab3CFVnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:43:00 -0500
Received: from serveur.giref.ulaval.ca ([132.203.7.102]:33963 "EHLO
	mailhost.giref.ulaval.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab3CFVm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:42:59 -0500
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Mar 2013 16:42:59 EST
Received: from localhost (localhost [127.0.0.1])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTP id BBFA2101220
	for <git@vger.kernel.org>; Wed,  6 Mar 2013 16:33:03 -0500 (EST)
X-Virus-Scanned: amavisd-new at giref.ulaval.ca
Received: from mailhost.giref.ulaval.ca ([127.0.0.1])
	by localhost (mailhost.giref.ulaval.ca [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NKsZnUP0Qr+p for <git@vger.kernel.org>;
	Wed,  6 Mar 2013 16:33:02 -0500 (EST)
Received: from gandalf.localnet (gandalf.giref.ulaval.ca [132.203.7.101])
	by mailhost.giref.ulaval.ca (Postfix) with ESMTPSA id E38E01011E5
	for <git@vger.kernel.org>; Wed,  6 Mar 2013 16:33:02 -0500 (EST)
User-Agent: KMail/4.10 (Linux/3.4.28-2.20-desktop; KDE/4.10.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217553>

Hello

$ git --version
git version 1.7.10.4

$ git fetch origin --no-tags
does what it says

$ git fetch --all --no-tags
still gets all the tags from the remote.

Is this known?

Thanks.

-- 
Cristian Tibirna				(1-418-) 656-2131 / 4340
  Laval University - Quebec, CAN ... http://www.giref.ulaval.ca/~ctibirna
  Research professional at GIREF ... ctibirna@giref.ulaval.ca
