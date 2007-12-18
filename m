From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Tue, 18 Dec 2007 08:39:52 -0800 (PST)
Message-ID: <m3hcigot3h.fsf@roke.D-201>
References: <20071214105238.18066.23281.stgit@krank>
	<b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	<20071217224812.GA6342@diana.vm.bytemark.co.uk>
	<20071218052115.GA13422@diana.vm.bytemark.co.uk>
	<b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	=?iso-8859-15?q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 17:40:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4fUS-0000Ch-7Y
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 17:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625AbXLRQj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 11:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757609AbXLRQj5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 11:39:57 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:10071 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757464AbXLRQj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 11:39:56 -0500
Received: by fg-out-1718.google.com with SMTP id e21so400034fga.17
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 08:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=l0YXdB3WyUAELDD3n21e3BE5VgnFyKwZC5Tya0ZhQmQ=;
        b=cS+cUJM/1O0Re+lr0G9Xjmvz6XIc8HoR/UugDIhaSrI36Ux3J+ph1mCnuFX60ZpkcpxredVP7o8yRYVH2MNXGzP5Gr91/zM6K3i9xBANGzP0j9q1/AvwM8FJ4cIhnG+sH6XAEkS2lnApzhJghZxyEOG5rUuIZE6WHuTze3I5wHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=jGjDENk19rlSSXOUduUzVbC9FpaNNK/xCRx+VRzXjx55EhssyDV4YfCj9YcbPne/ofRZGpi/sHj0aH8ylMtbytJwryNmEb46EJ1Bbvg4RPm5KufKkerQjWKVTl1ZI24R8xsITt68/h0jsXGT3A6CwPtobsiP2HImFrP1H0rCG4k=
Received: by 10.86.70.8 with SMTP id s8mr7844683fga.29.1197995993981;
        Tue, 18 Dec 2007 08:39:53 -0800 (PST)
Received: from roke.D-201 ( [83.8.255.201])
        by mx.google.com with ESMTPS id 4sm6765831fgg.2007.12.18.08.39.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2007 08:39:52 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBIGdhHx014064;
	Tue, 18 Dec 2007 17:39:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id lBIGdFuN014059;
	Tue, 18 Dec 2007 17:39:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68776>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> Thanks again for maintaining these branches.
>=20
> On 18/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >   git://repo.or.cz/stgit/kha.git safe

> >       Remove "stg resolved"
>=20
> I'd like to keep this command. git-mergetool doesn't support the tool
> I use (emacs + ediff and more stgit-specific file extensions like
> current, patch etc.). I also don't find 'git add' to be meaningful fo=
r
> marking a conflict as solved.

I also would like to have this command kept (and shown in 'stg help'!).
Contrary to 'git add' it can check and add to index / update index
only for files with conflict; we have -r (ancestor|current|patched)
to choose one side, and we could add --check to check if there are
no conflict markers with files (useful with -a/--all).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
