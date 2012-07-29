From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 23:26:27 +0200
Message-ID: <20120729212627.GA26430@paksenarrion.iveqy.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
 <7vehnvvyta.fsf@alter.siamese.dyndns.org>
 <20120729142458.GB16223@paksenarrion.iveqy.com>
 <CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
 <7vvch6uw89.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 23:26:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svb0N-0003oK-O2
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 23:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab2G2V0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jul 2012 17:26:21 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40174 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab2G2V0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 17:26:20 -0400
Received: by lbbgm6 with SMTP id gm6so3172846lbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QI8myPwhaVPwGm0+S9Takoz2IPdMvLRZQppPEBTPiOk=;
        b=zoSUSQH2ifZGGqRvB08pjsuFWPkP0MgLSfjG7RgptnpBo+ob9kqw1NIdr+95aof+p/
         UbdaC642YLIANCQRwSj7rLrfC2oDHdg3i6sKeW4WlRAokhSDxwSlkNw5GZVsvANX4ZJy
         zwE/IkOP9dpEpkaD0my80L8I4aEl8jdmE8/74W85eL+/GHnZfmy6AzNJkQVhZj3ouQmo
         jjMNpqQNHCslprzUtjy+cKqs/dxEH8XKWftwOKrLCNZfwPW8E4B8iLDZwN5FJe/WC9vG
         4/rv1MHce1HcICQK70+NmorfiZe0zLWvT2p6CmXRpKNC5vVeTEiBopsYxLCrm46nGdP7
         HBqA==
Received: by 10.112.84.168 with SMTP id a8mr4324534lbz.92.1343597179037;
        Sun, 29 Jul 2012 14:26:19 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-235-111.a189.priv.bahnhof.se. [81.170.235.111])
        by mx.google.com with ESMTPS id u10sm1789530lbm.14.2012.07.29.14.26.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jul 2012 14:26:17 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Svb0N-0006te-EB; Sun, 29 Jul 2012 23:26:27 +0200
Content-Disposition: inline
In-Reply-To: <7vvch6uw89.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202498>

Sorry I missed this thread earlier. I'll drop this if it's not somethin=
g
that's wanted.

On Sun, Jul 29, 2012 at 01:51:34PM -0700, Junio C Hamano wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>=20
> > Uggh, no.  Client-git should only talk to server-git.  It shouldn't=
 be
> > talking first to some *other* program (in this case gitolite), and
> > then to to server-git.  That doesn't sound sane to me.

This is exactly the way gitolite works. It's placed between git-server
and git-client. Does some checks and approves a connection if some
criterias isn't met. See the example when trying to clone an
non-existing repo from gitolite. You won't get an git error but a
gitolite error.

I can understand why my idea is beeing rejected but I can't see why the
gitolite way should be considered sane. It seems more like an hack to
me (according to git design principles).

So from a git point of view, why is it sane for passing through STDERR
but not STDIN and STDOUT?

(I realize that this is a closed matter but would appriciate an
explanation solely for my own educational purpose).

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
