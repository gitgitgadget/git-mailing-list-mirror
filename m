From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: RFC: "git config -l" should not expose sensitive information
Date: Mon, 17 Dec 2012 12:35:54 +0100
Message-ID: <50CF039A.7010800@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 12:36:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkYzX-0007yg-Qu
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 12:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab2LQLf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2012 06:35:58 -0500
Received: from mout.gmx.net ([212.227.17.21]:54604 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab2LQLf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 06:35:58 -0500
Received: from mailout-de.gmx.net ([10.1.76.38]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MSFoz-1TYqdL1NCl-00TXrA for
 <git@vger.kernel.org>; Mon, 17 Dec 2012 12:35:56 +0100
Received: (qmail invoked by alias); 17 Dec 2012 11:35:56 -0000
Received: from f054055138.adsl.alicedsl.de (EHLO [78.54.55.138]) [78.54.55.138]
  by mail.gmx.net (mp038) with SMTP; 17 Dec 2012 12:35:56 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX180o2YeK0U0kzYbZKa9XgJcsfQ0AebX0j0mPizhaD
	zvw1MTqxMEZWZ9
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/17.0 Thunderbird/17.0
X-Enigmail-Version: 1.4.6
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211676>

often the output is requested in help forums - and a
"git config -l | wgetpaste" exposes parameters like sendmail.smtppass -
so hide those variables in the output (if not explicitly wanted) would
makes sense, or ?

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
