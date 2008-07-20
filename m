From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Sun, 20 Jul 2008 23:50:47 +0200
Message-ID: <200807202350.47950.jnareb@gmail.com>
References: <4876B223.4070707@gmail.com> <200807192107.56333.jnareb@gmail.com> <20080720213642.GE10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 20 23:52:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKgp1-0004lr-EZ
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 23:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbYGTVu6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jul 2008 17:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbYGTVu5
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 17:50:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59018 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbYGTVu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 17:50:57 -0400
Received: by ug-out-1314.google.com with SMTP id h2so198616ugf.16
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 14:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=5KNvIDzHjDQktIWLUUJ3ZGAI8tt/vTJZnwRCSn/T41Q=;
        b=o/EIY17GMxBj9TikAdZ9v6viIM68p1M/c3C0ZlOnFEjJGr62ewGQxOiup9jJdzgph6
         SCw5UaqxOHFrQPNm691tfUiB+AYYyRxl56ul7BzQmvl+W4UTyUHxY8oXKe9pVhOuWbGP
         Gg/UPukfMSR5d1I/BlSP0OYqgBA4cK97E4bCA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OKHGEscWQv+MYeUfbgJWlhnfIJ956PBhTABnTNtjZa0JWK33wcY/k+tXBSEn0dcvhc
         0NY/biUj+ihwKKwfRQhVibvL1tw5q9i6tEYq8RNXgIrp2M00aGrgmpE07AxTXbkHcIVP
         x4Xx8U04ijhtvYILcAQQXCF9bcNu5vGYDnpUE=
Received: by 10.67.115.14 with SMTP id s14mr1211378ugm.59.1216590655371;
        Sun, 20 Jul 2008 14:50:55 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.215.213])
        by mx.google.com with ESMTPS id e33sm6260128ugd.81.2008.07.20.14.50.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jul 2008 14:50:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080720213642.GE10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89244>

On Sun, 20 Jul 2008, Petr Baudis wrote:
> On Sat, Jul 19, 2008 at 09:07:55PM +0200, Jakub Narebski wrote:

> > I think this is a very good idea. =A0Although... you mix somewhat h=
ere
> > relationships. =A0Relationship between Git::CommandFactory (Git::Cm=
d?)
> > is a bit different than relationship between Git::Repo and
> > Git::Repo::NonBare. =A0Git::Repo::NonBare is a case of Git::Repo wh=
ich
> > additionally knows where its working copy (Git::WC?) is, and where
> > inside working copy we are (if we are inside working copy). =A0Git:=
:Repo
> > uses Git::CommandFactory to route calls to git commands, and to
> > provide default '--git-dir=3D<repo_path>' argument.
>=20
> Yes, but that does not mean Git::Repo must not inherit from
> Git::CmdFactory. Think of Git::CmdFactory as maybe a kind of Java-sen=
se
> interface to a degree.

I agree. Nevertheless one inheritance is "interface", second
is "subclass"... but I don't think that matters at all.  Just being
nitpicky.

--=20
Jakub Narebski
Poland
