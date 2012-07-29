From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 17:05:50 +0200
Message-ID: <20120729150550.GA17679@paksenarrion.iveqy.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
 <CAMK1S_i7WjrZ=L_LVoTQriW8kKMPd+ABrgowpFCY3ks43E6K7A@mail.gmail.com>
 <20120729141354.GA16223@paksenarrion.iveqy.com>
 <CAMK1S_iFqQvU+USYf+wcsLFS1QtsytLnPfEhjcAVZa9Vwj8d1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 17:05:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvV44-0002Xl-UQ
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 17:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210Ab2G2PFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jul 2012 11:05:45 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33481 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021Ab2G2PFo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 11:05:44 -0400
Received: by lbbgm6 with SMTP id gm6so3091810lbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=L1L2YW2rHsGk2PbO8FI4pgXqD0/Hpw5ngcaeWwQkC80=;
        b=UxVvV2Dx05+fj86KT6kdO57rZGb/ABQMHhk3zrPdPnRRkn90suKkm3Y/EE+m/YWqcY
         WJWq3iR7sEzRO4iAfvOlc2UKEoc2Sk3W/rRiFk9Dccg3HFMYlb5YMeORW+GodzSSyR9t
         UvWQcEmsTBt0tYVhGwHho6XXvqhHnrpzkSs5xhRt0uRkdt11cqw+Fv+kBu6ejJl777ga
         k0kZLiKT3y2eif47DlnX/eV6u73Ma1oraBzGJTMYUohPGKqtoVo7USnvXouicbafH7GT
         EnKBmScnZf+n3R3Jlla3wU8yCfSPqXaErjCNKozi7i7NyxaMVdI//FAX34/BszYNumcx
         BgJQ==
Received: by 10.152.131.9 with SMTP id oi9mr8529556lab.39.1343574342822;
        Sun, 29 Jul 2012 08:05:42 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-235-111.a189.priv.bahnhof.se. [81.170.235.111])
        by mx.google.com with ESMTPS id xx8sm7953158lab.10.2012.07.29.08.05.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jul 2012 08:05:41 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1SvV42-0004gZ-CG; Sun, 29 Jul 2012 17:05:50 +0200
Content-Disposition: inline
In-Reply-To: <CAMK1S_iFqQvU+USYf+wcsLFS1QtsytLnPfEhjcAVZa9Vwj8d1w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202481>

On Sun, Jul 29, 2012 at 07:55:36PM +0530, Sitaram Chamarty wrote:
> > Thanks, however I think auto-creation is a great feature for some c=
ases
> > and I think there can be even more useable functions if we could ge=
t
> > user interaction.
>=20
> For the record, I don't think I agree.  There's a place to create a
> human-conversation, and there's a place not to.
>=20
> If you want a dialog with the server, there should be *other* command=
s
> that do that, instead of overloading git's own protocol.
>=20
> Since you mentioned gitolite, consider copying the fork command
> (src/commands/fork) and munging the code into an explicit wild repo
> create.

I appriciate that you clearified you oppinion. Please excuse me if it
sounded as I in any way speaked for gitolite. I use gitolite as an
example becuase the target application in this case is unknown to most
people (think gitolite with db-backend for user permissions).

It's a valid design oppinion to not mix git protocoll with anything
else. But gitolite already does that. Gitolite already have user
interaction mixed with git interaction. Do you say to me that gitolite
is broken and should not do user interaction over git-commands? Then wh=
y
does wild repos exists and why does gitolite error messages exists?

We're already down that road, why not do it better?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
