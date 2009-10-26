From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: git rebase -i <first_commit_in_repository>
Date: Mon, 26 Oct 2009 16:47:38 -0400
Message-ID: <b2e43f8f0910261347m38ccb608nb5858ff1dc432b33@mail.gmail.com>
References: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>
	 <40aa078e0910261025l1ad7bf8ex27fd62072a317f9d@mail.gmail.com>
	 <2b05065b0910261108g4a8448c8x295606a8d33612f5@mail.gmail.com>
	 <4AE60669.9080402@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: eschvoca <eschvoca@gmail.com>, kusmabite@gmail.com,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2WTh-0007uP-T2
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 21:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbZJZUrg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2009 16:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbZJZUrg
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 16:47:36 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:60365 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbZJZUrf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2009 16:47:35 -0400
Received: by iwn10 with SMTP id 10so6227332iwn.4
        for <git@vger.kernel.org>; Mon, 26 Oct 2009 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BpC0xJzq+hFyNg18qGpeo+IZyY9wUeekQpgUaAx/n0c=;
        b=lvtinyMnKYXdL+vMY0apqL3qUIEkh1iToySp2+MX/IjYpniUya/MT+P52pub8mqlVf
         JAnwk2LDQ4zs0vlVNVa1U+iMnyw+baqLZ8htvQjd7RnVFd8uC4dX2OhRd7zWqQRnO3VY
         iZzlxSX7KX/Av0jf+5Kvf4MB0IM7x49JS+BGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=H6hVBIzEMHGoM2KlEj2PgunHjhghMhj+VAdYm9ub/SQDpy0n+valXmS8NRG83NU5q3
         mv6yEdontCB3ki91xZ4rf0tCzApBzQtDehayeDNUKG8eU8ZitIrnAhhNjuAQ+UJcWiJF
         fTsv5gZMTSHR+zis2p+5fuI+oaLkoigUcQqwE=
Received: by 10.231.48.210 with SMTP id s18mr1167589ibf.3.1256590058287; Mon, 
	26 Oct 2009 13:47:38 -0700 (PDT)
In-Reply-To: <4AE60669.9080402@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131270>

2009/10/26 Dirk S=FCsserott <newsletter@dirk.my1.cc>:
> Am 26.10.2009 19:08 schrieb eschvoca:
> Hi,
>
> probably my approach could help you in the future: When I create a ne=
w repo
> (git init) I firstly create an initial commit with nothing else than =
an
> initial commit, i.e.:
>
> $ git init
> $ echo "initial" > initial.commit
> $ git add initial.commit
> $ git commit -m "Initial commit"

I don't think this is actually necessary.  You should just be able to d=
o:
$ git init
$ git commit --allow-empty -m "Initial commit (empty)"

--
Allan
