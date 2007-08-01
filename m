From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Thu, 2 Aug 2007 00:18:18 +0200
Message-ID: <200708020018.18610.jnareb@gmail.com>
References: <200708010216.59750.jnareb@gmail.com> <20070801092428.GB28106@thunk.org> <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:18:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGMWQ-0002Rq-7v
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 00:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbXHAWSX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 1 Aug 2007 18:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbXHAWSX
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 18:18:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:50387 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXHAWSW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 18:18:22 -0400
Received: by nf-out-0910.google.com with SMTP id g13so88377nfb
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 15:18:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nBUO99zKDPRVAOfqqf2nUXqQwoeA0mM9r1dM+1Iayi8vxD/TPXFRrSJ9mJl2Y16XBYo23PpmRqpPJoLzn58m6F0HaexTRO3oTTBGslJ94+Cy33Akb7yacCyDX279xS7n3ShzO2sCh+LNUe+bZpf6RPcDOa9uDaPgsT8Tqn9Dq+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L5eFdkk4/lVPDAwF0D/NnMMx0BSabMrZzLlMTx2GoV6yAQxpGu+9JHVEq03E1uDh/mTZXov+WxpDGZaL6hd03fLq+34ihRbffvLMQAwxmj9tCB0K4rCP9f+PEJJbd1COwoMb3pKJMWXDCo7IcDGFIQ92LgwNJNJAc4P0Nl7m0k4=
Received: by 10.86.51.2 with SMTP id y2mr891514fgy.1186006700354;
        Wed, 01 Aug 2007 15:18:20 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id j12sm2465710fkf.2007.08.01.15.18.16
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Aug 2007 15:18:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr6mn5znm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54485>

Junio C Hamano wrote:

> Perhaps if the destination is local,
>=20
> =A0 =A0 =A0 =A0 =A0- if -s is given, just set up alternates, do nothi=
ng else;
> =A0 =A0 =A0 =A0 =A0- by default, do "always copy never hardlink";
> =A0 =A0 =A0 =A0 =A0- with -l, do "hardlink if possible";
>=20
> Hmmmm...

That I think it is the best solution, together with support for
file:///path/to/repo.git scheme which would turn on old repacking
behavior. I'm all for it.

--=20
Jakub Narebski
Poland
