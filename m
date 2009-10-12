From: bill lam <cbill.lam@gmail.com>
Subject: quote in help code example
Date: Mon, 12 Oct 2009 18:29:26 +0800
Message-ID: <20091012102926.GA3937@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 12:39:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxIIu-0005tf-Gs
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 12:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755122AbZJLKaJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 06:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754995AbZJLKaJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 06:30:09 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:54090 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbZJLKaI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 06:30:08 -0400
Received: by pxi9 with SMTP id 9so8490792pxi.4
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ERrXuvpJAVE+syx3tvEG+KcTx/RYqKSw68/evwWjgEc=;
        b=JjLoC+/1uIYWTSsEO4coZVGezwUmMiyMzJoIHqffLIT2Tv455HjL6YYm0jycOjFyXE
         lEF/O16Wu2TRsSaglziMokNzHwvsH8BDguEihCXcFN/6G99P0BX0W58XhSQj+KWy/+BR
         SM0Mn6nZYeDBnczBTkmvHj9g2HXyckfQbuKvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=ZXm4fi8hIianPJLa/CijWxntn61m2ZYk+Xs3pt88+owJaIAyVFjZKRGd5CJk8AdemL
         xKiJSbwSc6tKEpnJyZPBaMaunqhQd37Lsxw7P+V9RMFMw925hfetw7LdE7z350ufxYCf
         Q0qpMZrkg5XGdoIvWpIgreFRTPLtysZ8F7gXo=
Received: by 10.115.66.13 with SMTP id t13mr9619941wak.176.1255343371679;
        Mon, 12 Oct 2009 03:29:31 -0700 (PDT)
Received: from localhost (pcd632137.netvigator.com [218.102.164.137])
        by mx.google.com with ESMTPS id 21sm991367pzk.15.2009.10.12.03.29.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 03:29:30 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130001>

In git man, eg. git help filter-branch
The code examples for command line or shell scripts inside .ft pairs
use (smart?) quote instead of single quotes, like

  .ft C
   git filter-branch --tree-filter =B4rm filename=B4 HEAD
   .ft

Is this intentional or just some configuration problem during
compiling.

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
