From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list (profiling gitweb)
Date: Wed, 1 Oct 2008 11:52:08 +0200
Message-ID: <200810011152.11361.jnareb@gmail.com>
References: <200809251230.11342.jnareb@gmail.com> <1D35F972-DA47-4445-A667-B03F841CABC6@develooper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: "Ask =?utf-8?q?Bj=C3=B8rn?= Hansen" <ask@develooper.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 11:53:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkyOk-00062r-7b
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 11:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbYJAJwY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2008 05:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbYJAJwY
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 05:52:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:32361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbYJAJwX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 05:52:23 -0400
Received: by ug-out-1314.google.com with SMTP id k3so757816ugf.37
        for <git@vger.kernel.org>; Wed, 01 Oct 2008 02:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SL/KEbRqWlC+3jUtvuMoXKF/RvgPZjDIPDmslMPlGpI=;
        b=fhnzUbjBbkh6nsPC5zD8zZlqaqLJIkUQd7erdagzzUyD61tLqCPF7ONoVO400IcZ+S
         CE+FPZDJvCqSOIvKKHVbHiDr+F5ZIvlP7YP9t8AjimoJzNmL3l6sE5zz6hPkLlTLoeg/
         QDbjcVkwqe5+OkxGkpkvFReib8GkCDlYvUqD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dd/qIwTlQWHtA9nsGwZvQ7ebFKQdko8hTT5wcXlqmnfddvBGlnqi1fY5JrvHX0ugvl
         fxmr2+TLPaQVpyERYqpNes/oxitm+XJtbmtjve9JUEtULmcs/ottARAfVH1CJM6aGN1I
         nnEb1Xz/E/fqw3qchY8aOQYj0ZNATmv2dWNY0=
Received: by 10.66.250.1 with SMTP id x1mr2528551ugh.4.1222854741067;
        Wed, 01 Oct 2008 02:52:21 -0700 (PDT)
Received: from ?192.168.1.11? (abvo173.neoplus.adsl.tpnet.pl [83.8.212.173])
        by mx.google.com with ESMTPS id j27sm3604015ugc.7.2008.10.01.02.52.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Oct 2008 02:52:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1D35F972-DA47-4445-A667-B03F841CABC6@develooper.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97213>

On Wed, 1 Oct 2008, Ask Bj=C3=B8rn Hansen wrote:
> On Sep 25, 2008, at 3:30, Jakub Narebski wrote:
>=20
> > * Optional information about load stats
> >
> >  Add an option to display information about how much time it took t=
o =20
> > generate page, how many git commands were called, and possibly othe=
r =20
> > metric; if page was cached, write when it was generated, and how =20
> > much time till timeout.  This probably would require additional per=
l =20
> > modules, and it should be conditional on those modules.
>=20
> Before spending too much time on this, be sure to have a look a =20
> Devel::NYTProf.
>=20
> http://search.cpan.org/~timb/Devel-NYTProf-2.03/lib/Devel/NYTProf.pm
>=20
> http://blog.timbunce.org/2008/07/15/nytprof-v2-a-major-advance-in-per=
l-profilers/

Thank you very much for the pointers.

However I'm not sure how much help would that be, as according to J.H.
(kernel.org admin) and Petr Baudis (repo.or.cz admin), gitweb
performance in real life settings is bound by I/O, not by CPU usage.

--=20
Jakub Narebski
Poland
