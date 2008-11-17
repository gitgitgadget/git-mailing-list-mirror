From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Mon, 17 Nov 2008 10:28:18 +0100
Message-ID: <200811171028.19807.jnareb@gmail.com>
References: <1226759165-6894-1-git-send-email-giuseppe.bilotta@gmail.com> <200811170202.27893.jnareb@gmail.com> <cb7bb73a0811162210iadb7511rc3474272c8e60c59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 10:29:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L20QS-0004GJ-Nc
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 10:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbYKQJ22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2008 04:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbYKQJ22
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 04:28:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:40142 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbYKQJ21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 04:28:27 -0500
Received: by ug-out-1314.google.com with SMTP id 39so348992ugf.37
        for <git@vger.kernel.org>; Mon, 17 Nov 2008 01:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=EIanApJvIv33ByXOP1sZrV6xhgZs8u34kGOLT+FaBy4=;
        b=grQ66Ygz/4Vxku6La2mPtndl1CN8VP0umjEYRYlbH1y1dJqgxheAo7JvV/rrz0H9/r
         //9rMYkvYLaTR7C8W0w8FpbIMbG6staWerjEFga+lDRIRJG3yhXUKUtGkx5WDwKYbOTf
         84HFNfI+Do9zbBy7f1JOH1loSIEiD4UtGX2YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=sBRBzrIVqXqqNQl55JyhhOgO6/hb9qUz91NUGQtHABEKcz4FUcy6r5yAYyIA79eowL
         vN9/6gQVREaoHbOkvXTB++Y6c/orBQ3u2/5Bags9car/aWK2fwtdXXFWxljN/kdEbTTI
         Ep0tjs6xJbNMZrkhxYQxHBeO1eohoaPd5EO78=
Received: by 10.66.250.17 with SMTP id x17mr1159706ugh.67.1226914106244;
        Mon, 17 Nov 2008 01:28:26 -0800 (PST)
Received: from ?192.168.1.11? (abwi102.neoplus.adsl.tpnet.pl [83.8.232.102])
        by mx.google.com with ESMTPS id w28sm2053300uge.5.2008.11.17.01.28.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Nov 2008 01:28:24 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0811162210iadb7511rc3474272c8e60c59@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101203>

Dnia poniedzia=B3ek 17. listopada 2008 07:10, Giuseppe Bilotta napisa=B3=
:
> On Mon, Nov 17, 2008 at 2:02 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:

[...]
> > First, you forgot the signoff, but you have addressed that already.
> >
> >
> > Second, I thought at first that it would be good for the patch to a=
lso
> > simplify %feature hash, using "'default' =3D> 1" instead of current=
 bit
> > convoluted "'default' =3D> [1]", at the cost of bit more code for
> > defensive programming.  But now I think that if it is to be done,
> > it should be put as separate patch.
>=20
> Is this an ACK? 8-D

I'm sorry. Yes, it is.

Acked-by: Jakub Narebski <jnareb@gmail.com>

--=20
Jakub Narebski
Poland
