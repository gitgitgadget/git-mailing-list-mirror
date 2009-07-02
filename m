From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Bug report: .gitattributes: -diff Unset causes files to be reported
 as binaries
Date: Thu, 02 Jul 2009 16:29:07 +0200
Message-ID: <4A4CC433.5040401@lsrfire.ath.cx>
References: <200907011208.35397.fenglich@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Frans Englich <fenglich@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Jul 02 16:29:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMNHv-0005Zv-JS
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 16:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378AbZGBO3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 10:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZGBO3K
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 10:29:10 -0400
Received: from india601.server4you.de ([85.25.151.105]:43055 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbZGBO3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 10:29:09 -0400
Received: from [10.0.1.101] (p57B7D606.dip.t-dialin.net [87.183.214.6])
	by india601.server4you.de (Postfix) with ESMTPSA id AF7952F8068;
	Thu,  2 Jul 2009 16:29:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <200907011208.35397.fenglich@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122649>

=46rans Englich schrieb:
> Hi,
>=20
> Applying -diff Unset to a file using .gittattributes causes "git diff=
" to=20
> state that the file is a binary even though it isn't, or have been in=
structed=20
> to be treated as one. See attached script for reproducing.
>=20
> This causes confusion since the file isn't a binary, it's only the di=
ff output=20
> that has been suppressed. For instance, an auto generated cpp file ha=
s -diff=20
> Unset applied to it to suppress the meaningless output, but people co=
ntact=20
> you to point out the file is binary.

Generated files normally don't need to be tracked, as long as all their
sources are tracked and the tools to generate them are readily availabl=
e
to your target audience.  So perhaps ceasing to track the files and
adding them to the file .gitignore instead is an option?

Ren=E9
