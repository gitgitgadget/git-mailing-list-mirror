From: szeder@ira.uka.de
Subject: Bash prompt "namespace" issue
Date: Tue, 13 May 2014 08:18:49 +0200
Message-ID: <20140513081849.5dql886xw080ww88@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 08:19:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wk63M-0005SP-IN
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 08:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbaEMGSz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 02:18:55 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:45083 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750743AbaEMGSz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 02:18:55 -0400
Received: from irawebadmin.ira.uni-karlsruhe.de ([141.3.10.50] helo=webadmin)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Wk636-0006Nc-NA; Tue, 13 May 2014 08:18:48 +0200
Received: from apache by webadmin with local (Exim 4.63)
	(envelope-from <szeder@ira.uka.de>)
	id 1Wk637-0004fY-UP; Tue, 13 May 2014 08:18:49 +0200
Received: from 90.64.uzpak.uz (90.64.uzpak.uz [213.230.81.90]) by
	webmail.informatik.kit.edu (Horde MIME library) with HTTP; Tue, 13 May 2014
	08:18:49 +0200
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
X-WebMail-Company: ATIS-Webmail
X-Originating-IP: 213.230.81.90
X-Remote-Browser: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:27.0)
	Gecko/20100101 Firefox/27.0
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1399961928.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248750>

Hi,

Commit 59d3924fb (prompt: fix missing file errors in zsh) added the =20
helper function eread() to git-prompt.sh.  That function should be in =20
the git "namespace", i.e. prefixed with __git_, otherwise it might =20
collide with a function of the same name in the user's environment.

It's already in master and I don't have the means to send a patch =20
fixing this ATM, sorry.

Best,
G=E1bor
