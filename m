From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 19:12:39 +0100
Message-ID: <200911171912.40658.jnareb@gmail.com>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com> <200911171458.56047.jnareb@gmail.com> <7fce93be0911170751r6d51ae7bn20fd593741b3eba6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Luben Tuikov <ltuikov@yahoo.com>, "J.H." <warthog9@kernel.org>,
	git <git@vger.kernel.org>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Tue Nov 17 19:12:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NASXw-0007qI-4t
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 19:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbZKQSMn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Nov 2009 13:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbZKQSMn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 13:12:43 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:56564 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbZKQSMm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 13:12:42 -0500
Received: by bwz27 with SMTP id 27so210605bwz.21
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xOb6s7HglpkeUPr4IYcxedmtB58fYhfka2VQR0/DhbY=;
        b=YJ5KnUJkfYnKVjGFAePn3d8ZcdHRuPOtM8J/pZO0tRREXS/dPHU3tHAw6NwF4D/2Wn
         CbtGblR4o2OvdSEjp3YDm/mAoMpEOjImAgIoV7Y8icpDa8iUYcLo3vZO90GRYegvcDs6
         43MgPDC2HvuTouPxLXHNlAPYsxaiJ5Gid9KjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HwaopicYULD3EoQ4jflOi+qR5bFuAw5DrMQYrNcSoWPuQuXhmUxL5oV2FDmoXGb3eS
         Zp+NL2XPPhyEq9tUqWD7yBNfhY/qn3GMQVCYGT98KlY3DBybcIcZ4yj4U55KWmyvEiwJ
         G0CiAvA2+pdM3LXqF5tdhxxG2bVqKLmTbO2vs=
Received: by 10.223.20.85 with SMTP id e21mr1694267fab.25.1258481567198;
        Tue, 17 Nov 2009 10:12:47 -0800 (PST)
Received: from ?192.168.1.13? (abwu104.neoplus.adsl.tpnet.pl [83.8.244.104])
        by mx.google.com with ESMTPS id 14sm418246bwz.9.2009.11.17.10.12.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 10:12:44 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7fce93be0911170751r6d51ae7bn20fd593741b3eba6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133095>

On Tue, 17 Nov 2009, Sylvain Rabot wrote:
> On Tue, Nov 17, 2009 at 14:58, Jakub Narebski <jnareb@gmail.com> wrot=
e:

> > The description is a bit lacking. =A0Where user should put theirs g=
it
> > repositories, or symbolic links to git repositories?
>=20
> As I said It's only configuration so It depends of your server
> architecture. If admin of the server decides he allows users to brows=
e
> via gitweb their private/public repos which are linked in
> /home/*/.gitweb or anything else he has to modify the environmental
> variable in the rewrite rule according to his wish.

So in described configuration, to make repository visible user would ha=
ve
to put repository, or symbolic link to repository (or .git/ directory o=
f
the repository) in ~/gitweb/ directory (just like one would need to put
HTML files in ~/public_html/ or ~/WWW/ to have them visible as web site=
),
isn't it?

> > How it would look like in gitweb?
>=20
> What do you mean ?

How would example gitweb URL to repository look like?

--=20
Jakub Narebski
Poland
