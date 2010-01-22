From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: git-svn question: adding a branch to a local clone of an upstream 
	git-svn clone
Date: Fri, 22 Jan 2010 15:03:10 -0500
Message-ID: <76718491001221203y54c3ec5br8fa7a40b5dd7da6a@mail.gmail.com>
References: <76718491001221115r56c1f6e4qbf6cecc30ce4af58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 21:03:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYPiy-000350-WB
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 21:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab0AVUDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jan 2010 15:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282Ab0AVUDN
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 15:03:13 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:50974 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0AVUDN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 15:03:13 -0500
Received: by iwn16 with SMTP id 16so433433iwn.33
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 12:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=zIciJx53PNoumcRgFhPrgVpyIeNWpoqpQGXDvXnkb24=;
        b=tUnqdDSFK3OszyOsN1oS/349N85iSR0dSPCuXHdcEs146KUnwpyLp2PgL7JV2EC2ev
         J3sDUHKhIVNFnB6lMyhiuQGnaG1q3e4ituoPsSlT0HWDpL10zAVBfSdup5r4qpd+g8mP
         4WAXVf43isoFcg4vPwKDaAnaQ34hMDvbTbhf4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=JjuaTuaHHEfoKP6F1QewquJGyhyVws2ubrPY/PH2ZCAMd55Zf7zcc7W6llUmovOae6
         rcje2cHp5kfQ4E+4JGz0eb2LlTxRG158h3sKpBAiknnnUlda8qin4sofmfZTeyHv2UfH
         kIV32JD+OS/gwZtoggly8Axg9eAzzYiJZFLzc=
Received: by 10.231.148.66 with SMTP id o2mr434684ibv.81.1264190590584; Fri, 
	22 Jan 2010 12:03:10 -0800 (PST)
In-Reply-To: <76718491001221115r56c1f6e4qbf6cecc30ce4af58@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137776>

On Fri, Jan 22, 2010 at 2:15 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:

> $ git checkout -b 249 bf6f4ed
> ...
> [svn-remote "svn"]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0url =3D http://src.chromium.org/svn
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fetch =3D branches/249/src:refs/remotes/br=
anches/249

Also tried this:

$ git update-ref refs/remotes/branches/249 bf6f4ed
$ git svn fetch
Done rebuilding
=2Egit/svn/refs/remotes/branches/249/.rev_map.4ff67af0-8c30-449e-8e8b-a=
d334ec8d88c
Done rebuilding
=2Egit/svn/refs/remotes/branches/249/.rev_map.4ff67af0-8c30-449e-8e8b-a=
d334ec8d88c
Done rebuilding
=2Egit/svn/refs/remotes/branches/249/.rev_map.4ff67af0-8c30-449e-8e8b-a=
d334ec8d88c
[... lots of these as it works its way through 30k revisions...]
=46ound possible branch point: http://src.chromium.org/svn/trunk/src =3D=
>
http://src.chromium.org/svn/branches/249/src, 32041
Initializing parent: refs/remotes/branches/249@32041
r3 =3D c14d891d44f0afff64e56ed7c9702df1d807b1ee (refs/remotes/branches/=
249@32041)
=2E..

So, no help either. :-(

j.
