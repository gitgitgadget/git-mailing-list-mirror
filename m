From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 15:29:33 +0200
Message-ID: <200610211529.33426.jnareb@gmail.com>
References: <845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com> <ehd5u7$c5g$1@sea.gmane.org> <20061021131551.GC29843@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 15:29:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbGun-0007nX-Sb
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 15:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992896AbWJUN30 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 09:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992908AbWJUN30
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 09:29:26 -0400
Received: from hu-out-0506.google.com ([72.14.214.238]:17457 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2992896AbWJUN3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 09:29:25 -0400
Received: by hu-out-0506.google.com with SMTP id 28so542094hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 06:29:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FbetDC2IzUxaI+HgWllsWTIU8jsV5AarqXh82dmOgbbsahRUt463OvaUc7Tbdmbm07ZhukbwhVzGIDVLKRLD4eTebvC3KehYHcDn8hJpeErEpDdQAVo4xJy5ab4KNGZ9f/W9Sa91YwjfqSfdOL2B+6DaGJN/UTF/Ei6v3oS2ZTE=
Received: by 10.67.27.3 with SMTP id e3mr3767702ugj;
        Sat, 21 Oct 2006 06:29:24 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 32sm2727252ugf.2006.10.21.06.29.23;
        Sat, 21 Oct 2006 06:29:24 -0700 (PDT)
To: Jan Hudec <bulb@ucw.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <20061021131551.GC29843@artax.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29611>

Dnia sobota 21. pa=BCdziernika 2006 15:15, Jan Hudec napisa=B3:
> On Sat, Oct 21, 2006 at 03:05:22PM +0200, Jakub Narebski wrote:
>> Jan Hudec wrote:
>>=20
>>> On Fri, Oct 20, 2006 at 12:05:35AM -0400, Aaron Bentley wrote:
>>>> Tim Webster wrote:
>>>>> Also svn does not allow files in the same directory to live in
>>>>> multiple repos
>>>>=20
>>>> It would surprise me if many SCMs that support atomic commit also
>>>> support intermixing files from multiple repos in the same director=
y.
>>>=20
>>> In fact I think svk would. You would have to switch them by setting
>>> an environment variable, but it's probably doable. That is because
>>> unlike other version control systems, it does not store the informa=
tion
>>> about checkout in the checkout, but in the central directory and th=
at
>>> can be set. I don't know git well enough to tell whether git could =
do
>>> the same by setting GIT_DIR.
>>=20
>> You can very simply embed one "clothed" repository into another in G=
IT,
>> like shown below
[...]
>> It depends on circumstances if one wants files belonging to subdirec=
tory
>> be ignored by top repository. You would want to ignore .git/ directo=
ry,
>> though.
>=20
> Yes, you can do that with bzr and most other tools I know of as well.
> But I understand the original question as requesting the working tree=
s
> to be rooted at the same place (ie. all in /etc), because each has so=
me
> files and some directories that have to be placed next to each other.

You can separate working area from the repository (you don't need to ha=
ve
repository in top directory of working area), but you must then provide
for each git command you do the location of repository, either via sett=
ing
GIT_DIR environmental variable (GIT_DIR=3D/path/to/repo.git git commit =
=2E..),
or use --git-dir option of git wrapper (git --git-dir=3D/path/to/repo.g=
it diff),
as automatical detection of repository wouldn't work, of course.
--=20
Jakub Narebski
Poland
