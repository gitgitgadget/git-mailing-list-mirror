From: gabriel staffelbach <gabriel.staffelbach@cerfacs.fr>
Subject: Git variable expansion when pulling ?
Date: Fri, 31 Jan 2014 18:43:12 +0100
Message-ID: <79E8887F-E7DD-4AA5-945B-10D86F317340@cerfacs.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 18:48:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9ICZ-0000XO-H0
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 18:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbaAaRsS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jan 2014 12:48:18 -0500
Received: from coconut.cerfacs.fr ([138.63.2.35]:51736 "EHLO
	coconut.cerfacs.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbaAaRsO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jan 2014 12:48:14 -0500
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2014 12:48:13 EST
Received: from coconut.cerfacs.fr (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id 977B62FA887D_2EBE0A3B
	for <git@vger.kernel.org>; Fri, 31 Jan 2014 17:42:59 +0000 (GMT)
Received: from maui.cerfacs.fr (maui.cerfacs.fr [138.63.200.112])
	by coconut.cerfacs.fr (Sophos Email Appliance) with ESMTP id 7BB582FA8876_2EBE0A3F
	for <git@vger.kernel.org>; Fri, 31 Jan 2014 17:42:59 +0000 (GMT)
Received: from belial.cerfacs.fr (belial.cerfacs.fr [138.63.213.115])
	by maui.cerfacs.fr (Postfix) with ESMTP id AC8293600D6
	for <git@vger.kernel.org>; Fri, 31 Jan 2014 18:42:59 +0100 (CET)
X-Mailer: Apple Mail (2.1827)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241310>

Hi ,=20
I=92ve just setup a variable expansion scheme via the attribues filters=
 for our versioning purposes.=20
I do realise there is much debate on whether to do this or not but it i=
s an indispensable part for our code.=20

However i just realised the filters are not executed if we update the c=
ode via a pull command and the file with the metadata is not modified .=
=20

Is there a correct way to have the filter execute even for a pull and u=
pdate the Git sha1 info in our log file ?=20

Thanks

Gabriel
