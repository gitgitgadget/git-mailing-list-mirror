From: m.skoric@web.de
Subject: Unable to clone svn repository
Date: Tue, 02 Sep 2008 16:58:15 +0200
Organization: http://freemail.web.de/
Message-ID: <1293837402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 16:59:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaXM7-0001sf-A3
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 16:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbYIBO6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2008 10:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbYIBO6T
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 10:58:19 -0400
Received: from fmmailgate05.web.de ([217.72.192.243]:60960 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbYIBO6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2008 10:58:19 -0400
Received: from web.de 
	by fmmailgate05.web.de (Postfix) with SMTP id 6CF3A5910E9C
	for <git@vger.kernel.org>; Tue,  2 Sep 2008 16:58:17 +0200 (CEST)
Received: from [62.206.44.30] by freemailng2303.web.de with HTTP;
 Tue, 02 Sep 2008 16:58:15 +0200
X-Provags-Id: V01U2FsdGVkX1/dCmvEAfE0+ZCySE5Lq2DppL4iWS9fp8PFqnoiZnxhKCI3S
 AlzJjM12kvMh2IyAyB8/2eXRdp/I1pAXXBwGZN8v8EkjHFCcN0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94677>

Hi guys,

im getting an error when im trying to clone a big svn repository. trunk=
 and a couple of branches worked before
git crashed.

git Version 1.6.0.1

command: git-svn clone https://SECRETURL --trunk=3Dtrunk --branches=3Db=
ranches --tags=3Dtags
error:

=46ound possible branch point: https://SECRETURL/branches/dirk/Abo-Uebe=
rnahme (Bug #994) =3D> https://SECRETURL/branches/Abo-Uebernahme (Bug #=
994), 341
Initializing parent: Abo-Uebernahme (Bug #994)@341
W: Ignoring error from SVN, path probably does not exist: (175002): RA =
layer request failed: REPORT request failed on '/svn/tixx1/!svn/bc/101'=
: REPORT of '/svn/tixx1/!svn/bc/101': Could not read chunk size: Secure=
 connection truncated (https://SECRETURL)
W: Do not be alarmed at the above message git-svn is just searching agg=
ressively for old history.
This may take a while on large repositories
=46ound possible branch point: https://SECRETURL/trunk =3D> https://SEC=
RETURL/branches/dirk/Abo-Uebernahme (Bug #994), 203
=46ound branch parent: (Abo-Uebernahme (Bug #994)@341) bb831869748c98bf=
97d105c5894ae65331c95c08
Bad URL passed to RA layer: Malformed URL for repository at /usr/bin/gi=
t-svn line 3792

Maybe a https problem -> "Secure connection truncated (https://SECRETUR=
L)" ?
Anyone has an idea and can help me?

Greetz ms
____________________________________________________________________
Psssst! Schon vom neuen WEB.DE MultiMessenger geh=F6rt?=20
Der kann`s mit allen: http://www.produkte.web.de/messenger/?did=3D3123
