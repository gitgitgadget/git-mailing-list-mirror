From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: Re: mkstemps compat issue
Date: Sun, 7 Jun 2009 14:49:16 +0200
Message-ID: <DAD17464-336A-451A-AEFE-26481D6B39B2@web.de>
References: <ED882BBA-E0E7-4CCC-9C6B-72FEBED1C9E0@web.de>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	HaikuPorts developers discussion list 
	<haikuports-devs@ports.haiku-files.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 14:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDHpL-0003qJ-1Y
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 14:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbZFGMtl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 08:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbZFGMtk
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 08:49:40 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:57296 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561AbZFGMtk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 08:49:40 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 92D36FEFCF98;
	Sun,  7 Jun 2009 14:49:41 +0200 (CEST)
Received: from [84.148.59.44] (helo=[10.0.0.2])
	by smtp05.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.110 #277)
	id 1MDHof-0002TP-00; Sun, 07 Jun 2009 14:49:37 +0200
In-Reply-To: <ED882BBA-E0E7-4CCC-9C6B-72FEBED1C9E0@web.de>
X-Mailer: Apple Mail (2.935.3)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX18PpqXWtmmvuWD44O6ps3t4Xrb0plDDLOcVMEy9
	9QkqztZJoHDNGl+sOoSuTr76MGMLp2GqT1FVfkQ/jZwXKf1cY4
	SSMc+X+5ccr89sGXBK+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120968>


Am 07.06.2009 um 14:32 schrieb Andreas F=E4rber:

> The merge commit b11cf09043f18b368ec0d988f064ea21247c843d introduced =
=20
> a git_mkstemps function in path.c, using mkstemps for the =20
> implementation. Unlike mkstemp that function is not part of POSIX, =20
> so we seem to need a NO_MKSTEMPS option and corresponding =20
> alternative code path.
>
> Any suggestions how to best replace mkstemps?

Sorry for the noise... NO_MKSTEMPS=3DYesPlease does work correctly if =20
typed correctly. (Thanks for the hint!)

It was a little confusing seeing mkstemps being used unconditionally =20
in path.c, but it's being #defined in git-compat-util.h, so everything =
=20
is fine.

Regards,

Andreas
