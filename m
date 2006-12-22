From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 23:40:49 +0100
Message-ID: <200612222340.50029.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <emhh4k$u4q$1@sea.gmane.org> <Pine.LNX.4.64.0612221609430.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 23:38:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxt1n-0002y0-VK
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 23:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbWLVWiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 17:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbWLVWiI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 17:38:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:6169 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbWLVWiH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 17:38:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3103510uga
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 14:38:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AWwi6+6A/w+AQguJ1vAsJfl9Z4kmpxqCZF598vpDulvzEazdgqpvtfJeCviEI+vdQoSGYM2bdR8awC4CdfQ/nXLkwAp9HxiuYuk7qztZ12BX6iShx4Bp4s3H2KlkwFNgz++KLL6WdNN5SjsmhE87v414P3bSVVjcBtilS+0EqzY=
Received: by 10.67.93.6 with SMTP id v6mr1377551ugl.1166827085959;
        Fri, 22 Dec 2006 14:38:05 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107])
        by mx.google.com with ESMTP id 72sm13774658ugb.2006.12.22.14.38.05;
        Fri, 22 Dec 2006 14:38:05 -0800 (PST)
To: Nicolas Pitre <nico@cam.org>, Junio Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612221609430.18171@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35240>

Nicolas Pitre wrote:
>=20
> Could you at least keep me in CC when replying to me please?

I have Cc-ed you and Junio, but somehow message I send to mailing
list loses the Cc:. Perhaps it is time to change news client (KMail),
or upgrade it...

> On Fri, 22 Dec 2006, Jakub Narebski wrote:
>=20
>> <opublikowany i wys=B3any>
>=20
> ?

Sorry, it is added (in my locale) when both sending reply via mail,
and to newsgroup (and to git mailing list via GMane NNTP news2mail
interface).


>> Perhaps less confusing, but also less powerfull. Current notation
>> allows for pulling _without need for tracking branches_.
>=20
> Is this really a killer feature worth the confusion?
>=20
> If you put the repo to pull from on the command line then sure you mi=
ght=20
> not want a tracking branch, but if you go to the trouble of adding a=20
> branch.blah.merge config entry then you certainly don't mind having a=
=20
> tracking branch?

I'm not sure. On one hand you have this feature, pulling without tracki=
ng
branch (which is nice workflow for one-branch repos at least), on the
other hand the tracking branch tells us the remote, and we can check if
they match.=20

On another hand, you can have two remotes which are the same repository
(mirrors for example)... although that would be better solved by allowi=
ng
multiple url...
--=20
Jakub Narebski
Poland
