From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Thu, 2 Aug 2007 13:19:51 +0200
Message-ID: <200708021319.52565.jnareb@gmail.com>
References: <200708010216.59750.jnareb@gmail.com> <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net> <200708020018.18610.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 20:23:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGfL1-0006a5-Cf
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 20:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719AbXHBSXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 2 Aug 2007 14:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756689AbXHBSXu
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 14:23:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:7448 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055AbXHBSXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 14:23:48 -0400
Received: by nf-out-0910.google.com with SMTP id g13so158487nfb
        for <git@vger.kernel.org>; Thu, 02 Aug 2007 11:23:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a+kELRXiCQvppO6LRqEbwqSxc91gF8lpEI4PTVobJgSJOaY2lEMl5vWCOScm/IW/AVXSnnwFryQ51vQLYDoM+3uuGMCeei4RuuWeNcRElVwE6HivRG5UMlFkwHwbsgcyCD04QaW3oMlgEBZt8n47DedoSmXaoXUa7HqUv6f34oU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SJqoK4hFV3FQ17PrzhbWEKl6xmQLMPJXdaF02Q3mm1s+o5x2NSYEuYENDiS8zpbT3OQQ+KBuWE45uqUXv+8D7sZ7S/VcinRUS76FI6OzRDX42Egpjvyz3PWU8M9/T/qlZ3vNO4oyVacn2QcpSmkJeS6OErJ6m4Ah0QtjDiRCCXg=
Received: by 10.86.81.8 with SMTP id e8mr1567525fgb.1186079027592;
        Thu, 02 Aug 2007 11:23:47 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id o11sm4546704fkf.2007.08.02.11.23.46
        (version=SSLv3 cipher=OTHER);
        Thu, 02 Aug 2007 11:23:46 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200708020018.18610.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54585>

Jakub Narebski wrote:
> Junio C Hamano wrote:
>=20
> > Perhaps if the destination is local,
> >=20
> > =A0 =A0 =A0 =A0 =A0- if -s is given, just set up alternates, do not=
hing else;
> > =A0 =A0 =A0 =A0 =A0- by default, do "always copy never hardlink";
> > =A0 =A0 =A0 =A0 =A0- with -l, do "hardlink if possible";
> >=20
> > Hmmmm...
>=20
> That I think it is the best solution, together with support for
> file:///path/to/repo.git scheme which would turn on old repacking
> behavior. I'm all for it.

By the way, with "-l" you have hardlinks only till repack ("git gc"),
isn't it?

--=20
Jakub Narebski
Poland
