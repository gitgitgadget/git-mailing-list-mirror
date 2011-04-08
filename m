From: Thorsten Glaser <tg@mirbsd.de>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Fri, 8 Apr 2011 19:05:31 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com>
 <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
 <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com> <4D9EDCEA.9010903@drmicha.warpmail.net>
 <20110408185924.GA25840@elie>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:15:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8H98-0006cq-Dg
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 21:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757696Ab1DHTPA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 15:15:00 -0400
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:46701 "EHLO
	herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757680Ab1DHTO7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 15:14:59 -0400
Received: from herc.mirbsd.org (tg@localhost [IPv6:::1])
	by herc.mirbsd.org (8.14.5.Beta0/8.14.5.Beta0) with ESMTP id p38J5Xo2015136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Apr 2011 19:05:36 GMT
Received: (from tg@localhost)
	by herc.mirbsd.org (8.14.5.Beta0/8.14.5.Beta0/Submit) id p38J5W3Q014379;
	Fri, 8 Apr 2011 19:05:32 GMT
Received: by S/MIME Plugin for MirBSD 10 Kv#10uAE-20110220 i386; Fri Apr  8 19:05:31 UTC 2011
X-X-Sender: tg@herc.mirbsd.org
In-Reply-To: <20110408185924.GA25840@elie>
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171145>

Jonathan Nieder dixit:

>I think the most native-looking way to store metadata associated to
>paths is .gitattributes.  It also has the nice feature of allowing a
>single attribute to apply to multiple files.

Eh, no. Think of extended attributes like, say, NTFS Resource Forks.
They=E2=80=99re just different =E2=80=9Clines=E2=80=9D into the =E2=80=9C=
plane=E2=80=9D a file can be, if
you excuse the metapher. (All parallel, of course.) They are just
another facet of each file.

bye,
//mirabilos
--=20
22:20=E2=8E=9C<asarch> The crazy that persists in his craziness becomes=
 a master
22:21=E2=8E=9C<asarch> And the distance between the craziness and genia=
lity is
only measured by the success 18:35=E2=8E=9C<asarch> "Psychotics are con=
sistently
inconsistent. The essence of sanity is to be inconsistently inconsisten=
t
