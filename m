From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 21:32:03 +0100
Message-ID: <200811102132.05472.jnareb@gmail.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com> <200811102117.30372.jnareb@gmail.com> <200811102124.59973.fg@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Nazarewicz <mina86@tlen.pl>, git@vger.kernel.org
To: Francis Galiegue <fg@one2team.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:34:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzdRz-0007qO-9R
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839AbYKJUcM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 15:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYKJUcM
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:32:12 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:64746 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbYKJUcL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:32:11 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1200779nfc.21
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 12:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=X6Sr8Lhq+fH2DWqQecptfOxdmmV5suX6dMvT/5h0HnU=;
        b=avUSMbdF4R9OpezxXLgZ525vDPAsaCHi7Pr7x0GNJbE2VdeKMFQxyv52WKQPzS5Epe
         3/xGKcL08Iy27VqR/rcDRLOKdwojcB65Al+El5zy/XP25TfVGyXle2JhVHXGIaftDXd2
         +S1xqKWz++a8KKZVOTEAdy5tQx7J4SMZhhD8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rKfJmwxBiaCdAprK5qwfQl98vBodzQvzHfaMEPeNpSGP5aA1Eh8RQ2KDOekD/wwqoZ
         310xanqMwl4U/thoVmX+aESLHEJCkRWtlQDJHFuLLDT4uV2MQ2e37eaTrfk4Lju2jvLW
         66VbUZlrEGis4IYgYsrX6xom5rjPvodnzaJL4=
Received: by 10.210.81.3 with SMTP id e3mr8089120ebb.112.1226349129395;
        Mon, 10 Nov 2008 12:32:09 -0800 (PST)
Received: from ?192.168.1.11? (abwz230.neoplus.adsl.tpnet.pl [83.8.249.230])
        by mx.google.com with ESMTPS id 5sm279497eyh.2.2008.11.10.12.32.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 12:32:07 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200811102124.59973.fg@one2team.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100562>

Dnia poniedzia=C5=82ek 10. listopada 2008 21:24, Francis Galiegue napis=
a=C5=82:
> Le Monday 10 November 2008 21:17:29 Jakub Narebski, vous avez =C3=A9c=
rit=C2=A0:

> > Well, _some_ command has to be invoked to expand keywords. "git add=
"
> > doesn't do that (perhaps it should?), so you need to use checkout.
> >
>=20
> If "git add" aims to do that, you'd have to be very, VERY careful, no=
t to=20
> substitute in the wrong place to start with, not to attempt substitut=
ion in=20
> binary files...
>=20
> And this would have a sizeable cost, imho. If you really want to do t=
his,=20
> isn't there a hook somewhere that can do that for you, instead of mod=
ifying=20
> git add directly?

If I remember correctly there was idea to add 'pre-add' or 'post-add'
hook...

--=20
Jakub Narebski
Poland
