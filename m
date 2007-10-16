From: "VAUCHER Laurent" <VAUCHER@fermat.eu>
Subject: RE: Problem with git-svnimport
Date: Tue, 16 Oct 2007 17:48:57 +0200
Message-ID: <55DDB08CC9CD2941A70E8D626789A2C906A4031C@ec8l7ljvo9h5dde.hosting.exch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 17:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhodC-0007gn-GU
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 17:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbXJPPqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Oct 2007 11:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933428AbXJPPqg
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 11:46:36 -0400
Received: from mail04.net-streams.fr ([213.41.74.9]:1799 "EHLO
	mail04.net-streams.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933409AbXJPPqf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 11:46:35 -0400
Received: from ec8l7ljvo9h5dde.hosting.exch [10.16.3.20] by mail04.net-streams.fr with ESMTP
  (SMTPD-9.10) id AB2C0704; Tue, 16 Oct 2007 17:39:24 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Problem with git-svnimport
Thread-Index: AcgP8ADfejCCl6nlQY+ySpGvCMx65gAG24Xw
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61197>

In fact, I think the problem appears not with undescore characters but =
spaces in tag and branche names.

Do you think there's a way around this (other than manually renaming ta=
gs and branches in the SVN repository)?

Laurent.

-----Message d'origine-----
De : git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] De la=
 part de VAUCHER Laurent
Envoy=E9 : 16 October 2007 14:31
=C0 : git@vger.kernel.org
Objet : !! SPAM Suspect : SPAM-URL-DBL !! Problem with git-svnimport

  Hi.

  Trying to convert a svn repository to git, I encountered the followin=
g
error:

Use of uninitialized value in hash element at /usr/bin/git-svnimport
line 534.

  Line 534 reads:
	my $gitrev =3D $branches{$srcbranch}{$therev};

  I have installed packages git-core and git-svn on Ubuntu. These
package have versions: "1:1.5.2.5-2-feisty1"

  The tool seems to choke on tags or branches with special characters
(underscore, for instance).


Laurent.
