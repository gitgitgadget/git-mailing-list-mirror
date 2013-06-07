From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: is there a fast web-interface to git for huge repos?
Date: Fri, 7 Jun 2013 08:33:53 +0200
Message-ID: <20130607063353.GB19771@paksenarrion.iveqy.com>
References: <CAPKkNb4bYfBeqkBKqe-22iJsqjmvrYNSe4oWUnPo7QeghLK59Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Constantine A. Murenin" <mureninc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 08:31:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkqCz-0001Bx-8d
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 08:31:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908Ab3FGGb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 02:31:29 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:49732 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737Ab3FGGb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 02:31:28 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so1463489lab.25
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h2ixn2AwHAq0QToT+hcldqDN/Mocj9SPxPOpXbG/MEQ=;
        b=xiJ+cW5BxsNkkiCWVWr5THJCiQogoZLoMnmL2eQdGXqWa1ubpVIFzWPvuB7OKaX0vE
         Ej4Lyut/5j5/a2Ep3PU1vMvKEyzhUvyFBYMIOHe6duktAqrQDKqYwYhiLZYiihEwKn18
         tcs8ZHw0aBmTwOUpc66HMUcqcvvuwyFXAeBMaycdDnGxERO250ROpRVFYN+CbUVjIM5x
         FQZhuIEyXsYloS91cBtYY4EYGLeIa8f5lKiddCDi8B8OVb/bOmx3GdguI85+RN5xQ9qw
         LV3gGTDe1pL9WWVP04cUjxJtwJppj6ytvU6s+tmue+JfrrJ2FgBFzh46iG0CztU/t1HC
         nhVA==
X-Received: by 10.112.144.69 with SMTP id sk5mr523265lbb.64.1370586686626;
        Thu, 06 Jun 2013 23:31:26 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id f9sm415412lbf.4.2013.06.06.23.31.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 23:31:26 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UkqFF-0005Gy-FP; Fri, 07 Jun 2013 08:33:53 +0200
Content-Disposition: inline
In-Reply-To: <CAPKkNb4bYfBeqkBKqe-22iJsqjmvrYNSe4oWUnPo7QeghLK59Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226608>

On Thu, Jun 06, 2013 at 06:35:43PM -0700, Constantine A. Murenin wrote:
> I'm interested in running a web interface to this and other similar
> git repositories (FreeBSD and NetBSD git repositories are even much,
> much bigger).
>=20
> Software-wise, is there no way to make cold access for git-log and
> git-blame to be orders of magnitude less than ~5s, and warm access
> less than ~0.5s?

The obvious way would be to cache the results. You can even put an
update cache hook the git repositories to make the cache always be up t=
o
date.

There's some dynamic web frontends like cgit and gitweb out there but
there's also static ones like git-arr ( http://blitiri.com.ar/p/git-arr=
/
) that might be more of an option to you.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
