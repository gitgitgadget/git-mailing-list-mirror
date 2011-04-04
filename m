From: Jonathan Michalon <johndescs@gmail.com>
Subject: Re: Better big file support & GSoC
Date: Mon, 4 Apr 2011 18:52:48 +0200
Message-ID: <20110404185248.1061e452@RunningPinguin.chalmion.homelinux.net>
References: <20110402164051.1f263aa0@RunningPinguin.chalmion.homelinux.net>
 <alpine.DEB.2.00.1104022056530.29543@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 04 18:53:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6n1R-0003Dg-Rz
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 18:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab1DDQw4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 12:52:56 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:57401 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab1DDQwz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 12:52:55 -0400
Received: by wwk4 with SMTP id 4so1846837wwk.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=vT+P+xWHHhuc7+S3ojXfO7s5kzIu/DZeH/c+BP+/JvA=;
        b=yC4QtPeqqWfsNgSrOKCoL4hyEjOk7nRdvrIx6dZYT4fdWz6DIeJ9bqzo3y1JIycLwM
         pmWh8EF0Ado//9JilGk4BHt5EZQCyQ2ZLKm72+l1mD7USRqAOBAq0g3CVkTEUY0Ss5AX
         Ormn/pMmQ+eBJ7boR6VjNcWNjgz/WzLmUa5CY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=YexPd7+GEqqE1zIiXvIekXCEXeyhEUyp1PigBjXbqIhTM6KXQTNvYf+yeLntH9MTQY
         m6zXEqshlYkKZ0ujxLppWOAYuELJfNZbpnnb227dYEerxpo/3o5bWw3/ZlzuRfKUngWb
         v9ULybyU9pR0ji4JSiGLOq/17zYjqD+XvORkk=
Received: by 10.216.82.16 with SMTP id n16mr3125880wee.13.1301935972979;
        Mon, 04 Apr 2011 09:52:52 -0700 (PDT)
Received: from RunningPinguin.chalmion.homelinux.net (AStrasbourg-251-1-20-21.w82-126.abo.wanadoo.fr [82.126.210.21])
        by mx.google.com with ESMTPS id c54sm2343210wer.30.2011.04.04.09.52.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 09:52:52 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104022056530.29543@asgard.lang.hm>
X-Mailer: Claws Mail 3.7.4 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170823>

Le Sat, 2 Apr 2011 21:00:53 -0700 (PDT),
david@lang.hm a =C3=A9crit :

> On Sat, 2 Apr 2011, Jonathan Michalon wrote:
>=20
> > Hi Git people,
> >
> > I'm an applicant to the GSoC within git.
> > I would like to help building a better big file support mechanism.
> >
> > I have read the latest threads on this topic:
> > http://thread.gmane.org/gmane.comp.version-control.git/165389/focus=
=3D165389
> > http://thread.gmane.org/gmane.comp.version-control.git/168403/focus=
=3D168852
>=20
> there was also an offshoot of a similar discussion that pointed out t=
hat=20
> this could be done pretty cleanly with the clean/smudge hooks.
>=20
> David Lang

Edit:
Hum I just failed to reply correcly... did only to the original poster,=
 not the
whole list. My apologies.

Message:
At least to my mind big file support is more important than just doing =
some
tricky manipulation with existing hook types. It should highly benefit =
from
being integrated deeply within git, both because of optimisations or in=
 terms
of integration.
I read the discussion about clean/smudge hooks too but I skipped the id=
ea
because the final thought was "feels like a hack". See here:
http://article.gmane.org/gmane.comp.version-control.git/168857

In fact I don't know how this could be considered as "clean" or "hacky"=
=E2=80=A6

--
Jonathan Michalon
