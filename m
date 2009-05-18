From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] Extend sample pre-commit hook to check for non ascii filenames
Date: Tue, 19 May 2009 00:26:35 +0200
Message-ID: <200905190026.37291.jnareb@gmail.com>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <46a038f90905150352q76157227q24c6b8c0befa4108@mail.gmail.com> <20090518093655.GA910@heiko-voigts-macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue May 19 00:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6BIc-0004vh-S0
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 00:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbZERW0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 18:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754737AbZERW0p
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 18:26:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:44396 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694AbZERW0o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 18:26:44 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1271144fgg.17
        for <git@vger.kernel.org>; Mon, 18 May 2009 15:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=9KK+yA1GkNUlBbnOiYP7x2WbOWxzltrEWRbZf7gS5gg=;
        b=bFoZkONVbjEZEgel4EMOt28RVky3Cx1v5YScZsgDHpfcs8ZS6YpEIXJM+V6gR130gS
         CV+DsKxGn8/P1P72f8VE4tek296z6txX06+1tuKGu7i32rUr3fWUkZPuHJv2V24dJVkn
         9z5IRFV7ZZH2yKJHAOSQnBVzwUFOcMJUygyiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lyFE2gGw4pJ/eQ2Y/4gkX0gXfjL0PgW9Gzs5x9tlHmV9jg2XGw74WYF2syG5gax6hD
         pNnNCVeUMoIkK5Th8c1Bvst7rnvLi7KZFcDPS2ZHcIMUg8zprqHGmFSp0BszW+SrFg35
         dXCHFkNbEh6CXc0UnrYx5lHTh65/eMW68AEj4=
Received: by 10.86.91.10 with SMTP id o10mr7203979fgb.13.1242685603699;
        Mon, 18 May 2009 15:26:43 -0700 (PDT)
Received: from ?192.168.1.13? (abwi178.neoplus.adsl.tpnet.pl [83.8.232.178])
        by mx.google.com with ESMTPS id d4sm8622021fga.9.2009.05.18.15.26.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 May 2009 15:26:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090518093655.GA910@heiko-voigts-macbook.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119468>

On Mon, 18 May 2009, Heiko Voigt wrote:
> On Fri, May 15, 2009 at 12:52:41PM +0200, Martin Langhoff wrote:

> > =A0- Should all of this be a general "portablefilenames" setting?
>=20
> Well, if you can specify what general portable filenames would have a=
s
> properties.

"Fixing Unix/Linux/POSIX Filenames: Control Characters (such as=20
Newline), Leading Dashes, and Other Problems" by David A. Wheeler
http://www.dwheeler.com/essays/fixing-unix-linux-filenames.html

--=20
Jakub Narebski
Poland
