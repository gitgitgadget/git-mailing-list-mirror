From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Teams of people using signed commits...
Date: Sat, 15 Jun 2013 00:06:27 +0200
Message-ID: <20130614220627.GA371@paksenarrion.iveqy.com>
References: <CABQymNKuwiOz-MQuM12fWSgBvBsBrykNYBqPBxCuSuxAC5cZZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Fleischman <efleischman@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 15 00:03:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Unc5a-00070r-FE
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 00:03:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876Ab3FNWDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 18:03:18 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:59329 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742Ab3FNWDR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 18:03:17 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so974775lab.17
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Eewdue2taTQiC4TXK8mVxG/ykWaX1JcVaz3z7fwFg0o=;
        b=QLxD6oIaazGLC0aongYcpB1qmQf5U844HGtsLj9LqvAHgfueJKPtAhZRg+j0FTf9z6
         WL+ih29Aa4uq3xcyNWhJ41NYYTzhes2ocxrkhVLV2FbWGmlDKLnohXVV3zIR82zmIGXO
         /ya5JX852P3se1l3aHu4xMorKh6K+Cb8a57d7Q30Ya9Zjt4/iVAPYDC32l+zpGhs6t5L
         ZPezWQaa/UmP9Z2IpoSaAwEmJVaXC9L020CivlOhG/L5ZcZINZVcGaCBW0xhWasQPvGR
         6sii6Kx8NUnXFYIksZDg5mRU6KGZ6p2lMByJlEXV+uoSsdVUZ2IQ5IOJQtwnBBbScw9C
         d5fg==
X-Received: by 10.112.73.210 with SMTP id n18mr2000260lbv.90.1371247396329;
        Fri, 14 Jun 2013 15:03:16 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id m1sm1571176lag.3.2013.06.14.15.03.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 15:03:15 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Unc8Z-0000Rl-H6; Sat, 15 Jun 2013 00:06:27 +0200
Content-Disposition: inline
In-Reply-To: <CABQymNKuwiOz-MQuM12fWSgBvBsBrykNYBqPBxCuSuxAC5cZZw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227927>

On Fri, Jun 14, 2013 at 12:02:01PM -0700, Eric Fleischman wrote:
> We think we know how to deal with signed commits & auto-reject such
> commits at build time, as well as clean up. But we're worried that
> folks won't sign on the way in accidentally. We don't know of a good
> way to force the team to always sign commits yet, especially as they
> get new machines and what hav eyou.
>=20
> Is there a way to add something to the repo config to force, or at
> least default, this?
> We considered forking git and forcing this on the team, forcing them
> to sign for our repos. But we'd love to avoid this sort of
> heavy-handed approach.
>=20
> Thx!
> Eric

Hi,
I might miss something here, but couldn't you just write a pre-commit
hook on the client side to help the developers remember  and a post-rec=
eive
hook on the server side to actually enforce this?

With that said, I'm a bit skeptical about enforcing ways to use
software. It usually hide real social problems instead. For example, if
your developers doesn't understand the value in always signing their
commits, can you trust that they protect their gpg-key well enough?
--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
