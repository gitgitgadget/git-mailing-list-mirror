From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: can I use multiple worktree in same git repo ?
Date: Thu, 21 Jul 2011 20:22:15 +0200
Message-ID: <20110721182215.GA9505@kolya>
References: <20110720182438.3c40cf1d@shiva.selfip.org>
 <CACsJy8CLRjLag65H6KQ1AUABLwiL09wNQw3VH8Y-JQnw7CqLUw@mail.gmail.com>
 <m3sjpzsdll.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"J. Bakshi" <joydeep@infoservices.in>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 20:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjxsw-0002Hz-AK
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 20:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab1GUSWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jul 2011 14:22:05 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:48583 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab1GUSWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 14:22:03 -0400
Received: by eye22 with SMTP id 22so1806829eye.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 11:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=73XXf0GzTRdKNGjQrk/YfpfzDqYiTToTPcGawDWkxKQ=;
        b=rMVyP7Na7p+7rR/t1fkaMhW0N0A5KxkpKWlMfDPiYHyhVKgS65M9fvAX7mxnardRXn
         7CPb+v5KrE3jmjqwt41lG+UVywTP3vFpkt+V87mFgMrMa5PnmafAeo1sBwDlcyZOzC1K
         sfjm2NSukqWfSOU1nDvzw+TNaTiMh1XchmDA0=
Received: by 10.14.100.201 with SMTP id z49mr274125eef.119.1311272521647;
        Thu, 21 Jul 2011 11:22:01 -0700 (PDT)
Received: from kolya (h-185-240.a189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id v20sm1269379eeh.46.2011.07.21.11.22.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 11:22:00 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qjxt1-0002TV-Jf; Thu, 21 Jul 2011 20:22:15 +0200
Content-Disposition: inline
In-Reply-To: <m3sjpzsdll.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177607>

On Thu, Jul 21, 2011 at 11:17:57AM -0700, Jakub Narebski wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>=20
> > On Wed, Jul 20, 2011 at 7:54 PM, J. Bakshi <joydeep@infoservices.in=
> wrote:
> > > As a result whenever there is a commit , it updates the related f=
older in filesystem.
> > > Say a commit at svn->mysite-repo->dir1->trunk->src =3D=3D> modify=
 =3D=3D> /var/www/demo/dir1
> > >
> > > Can I do the same in git with multiple worktree ? possible ?
> >=20
> > Using multiple worktree with the same repo won't work in git becaus=
e
> > the repo also have worktree-related information. [...]
> [...]
> > Also have a look at git-new-workdir in contrib directory of git
> > repository. I don't use it but you might find it useful.
>=20
> Actually with git-new-workdir you can have multiple working
> directories associated with single repository, by the way of symlinks=
=2E
>=20
> Note however that if you intend to *work* in those workdirs, they
> better correspond to different branches... or you can mess something
> heavy.

It would be possible to use the .git-file feature here. Then symlinks a=
re
avoided and the solution is portable.

Med v=E4nliga h=E4lsningar
=46redrik
