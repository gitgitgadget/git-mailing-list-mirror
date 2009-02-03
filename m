From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: revert committed and pushed tag
Date: Tue, 03 Feb 2009 15:45:01 +0100
Message-ID: <4988586D.603@cetrtapot.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 15:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUMhJ-0000iV-5b
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 15:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbZBCOy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2009 09:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755286AbZBCOy6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 09:54:58 -0500
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172]:60457 "EHLO
	zimbra-mta.cetrtapot.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbZBCOy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 09:54:56 -0500
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Feb 2009 09:54:56 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 79CA819FA22
	for <git@vger.kernel.org>; Tue,  3 Feb 2009 15:45:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra-mta.cetrtapot.si
Received: from zimbra-mta.cetrtapot.si ([127.0.0.1])
	by localhost (zimbra-mta.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aV3y1mKgBOjM for <git@vger.kernel.org>;
	Tue,  3 Feb 2009 15:45:40 +0100 (CET)
Received: from [172.31.65.135] (unknown [192.168.66.2])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 2C75419F9BE
	for <git@vger.kernel.org>; Tue,  3 Feb 2009 15:45:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108195>

Hi,

Is there a way to 'revert' committed and pushed tag?
I've noticed that some files were not included in the commit (new files=
)
and I would like to squeeze them in before the tag was
created/committed/pushed to the remote server.

I did:
$ git add ..files..
$ git commit
$ git push
$ git tag rc3
$ git push --tags

Thank you,
Hinko
--=20
Hinko Ko=E8evar, OSS developer
=C8ETRTA POT, d.o.o.
Planina 3, 4000 Kranj, SI EU
tel     ++386 (0) 4 280 66 03
e-mail  hinko.kocevar@cetrtapot.si
http    www.cetrtapot.si
