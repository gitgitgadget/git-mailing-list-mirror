From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: EOL strangeness
Date: Thu, 20 Jan 2011 09:54:43 +0100
Message-ID: <4D37F853.1020805@lsrfire.ath.cx>
References: <AANLkTiknxMh_OophKWsqkYO2C+PsfF0ZnNXKLbheM4wF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Graham Sanderson <graham.sanderson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 09:55:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfqIO-0003SW-7n
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 09:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab1ATIy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Jan 2011 03:54:59 -0500
Received: from india601.server4you.de ([85.25.151.105]:37661 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab1ATIy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 03:54:59 -0500
Received: from [192.168.2.104] (p4FFD8F15.dip.t-dialin.net [79.253.143.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 832E82F80A0;
	Thu, 20 Jan 2011 09:54:57 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTiknxMh_OophKWsqkYO2C+PsfF0ZnNXKLbheM4wF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165307>

Am 17.01.2011 20:56, schrieb Graham Sanderson:
> Apologies if someone has answered this before:
>=20
> So we have moved some big teams over to git (awesome thx), and have
> been using the msysgit default core.autocrlf=3Dtrue on Windows, and
> making sure text files are LF on other platforms
>=20
> However we do continue to have a few problems with people storing CRL=
=46
> in the repository (partly because of lack of understanding, and partl=
y
> it seems because of eGit on windows which ignores core.autocrlf).
>=20
> Anyway, this much is all fine, and we can fix; what I don't understan=
d
> is why for files stored as CRLF in the repository it seems
> indeterminate when or if they show up locally modified (on my window
> box with core.autocrlf =3D true) when I pull them from the repository=
=2E I
> assume the idea is that that they "would be" modified if I were to
> check them in, since they would be converted to LF, however this only
> happens sometimes and for a seemingly random subset of the files
> stored incorrectly.
>=20
> It also seems to depend on the state of the local index, as recreatin=
g
> the local index often changes the set of files that are displayed thi=
s
> way (even without any changes to the files), and it also seems to be
> different on different machines (perhaps based on when they happened
> to pull code).
>=20
> If anyone can give me a quick mental picture of how this is supposed
> to work (i.e. at what time the eol conversions are considered) then
> that'd be great... otherwise I guess I'll go dig in the code.

Perhaps this recent thread is of interest to you, even though it's on a
slightly different topic and inconclusive:

	http://thread.gmane.org/gmane.comp.version-control.git/163794

It would be nice to have the expectations in your case codified in a
test script -- based on the documentation, if possible.

Ren=E9
