From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 14:56:41 +0200
Message-ID: <200610171456.41548.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <BAYC1-PASMTP02ADC5BEF688E61583283CAE0E0@CEZ.ICE> <vpqbqob5euu.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>,
	Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 14:56:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZoUT-0007oS-LF
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 14:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWJQM4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Oct 2006 08:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWJQM4O
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 08:56:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:49845 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750780AbWJQM4N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 08:56:13 -0400
Received: by ug-out-1314.google.com with SMTP id o38so976096ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 05:56:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Pie/o6IQfEjree3DC1vOg2kKEoyOo2Bp7nDtfTwRwTSX/ghOON0xLLu8qXrbIlQ7gjAkPk6GQ/9/dqn96i2eYVrf/lgkwVzQNH8TtG950U/b+hZH/DmiNcVsU3TkYsnQL7idAKdp4sCHJ9v/Rm9WDyg9jSJERajtXaD26sDdi1k=
Received: by 10.67.97.18 with SMTP id z18mr9707470ugl;
        Tue, 17 Oct 2006 05:56:12 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id 20sm125673uga.2006.10.17.05.56.11;
        Tue, 17 Oct 2006 05:56:11 -0700 (PDT)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
User-Agent: KMail/1.9.3
In-Reply-To: <vpqbqob5euu.fsf@ecrins.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29065>

Matthieu Moy wrote:
>> This is exactly the same in Git. =A0You really only ever push upstre=
am
>> when your local changes fast forward the remote, (ie. you're up to d=
ate).
>> Git will warn you if your changes don't fast forward the remote.
>=20
> Yes, but you will have to do a merge at some point, right ? While I'm
> keeping a purely linear history (not that it is good in the general
> case, but for "projects" on which I'm the only developper, I find it
> good. For example, my ${HOME}/etc/).

=46ast-forward doesn't result in merge.

If you have

  1---2---3        <branch 1, or branch locally>
           \
            4---5  <branch 2, or branch at remote>

then this is fast-forward case. After pull (or push) you have

  1---2---3---4---5 <branch 1>

without merge.

--=20
Jakub Narebski
Poland
