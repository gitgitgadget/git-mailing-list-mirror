From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 10:07:43 +0100
Message-ID: <200712041007.44525.jnareb@gmail.com>
References: <4753D419.80503@clearchain.com> <200712041047.39340.ismail@pardus.org.tr> <200712041055.41593.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Benjamin Close <Benjamin.Close@clearchain.com>,
	git@vger.kernel.org
To: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Tue Dec 04 10:08:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzTlE-0004Al-Q9
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 10:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbXLDJHw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 04:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbXLDJHw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 04:07:52 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:45493 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbXLDJHv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 04:07:51 -0500
Received: by mu-out-0910.google.com with SMTP id i10so698783mue
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 01:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=W419/GMipu3mgDNxAPMZipSguAc5WJt4TsxR6ZSPVH8=;
        b=a7kUVIoNr8/5zOTIbZQTeULjpO8oZgxdQOuKLVcPVLI2tP6bcYaswjghLv66GLoo1rO1qxSnZVn0cm3cI5ql6etaBZhn8YwmmVpJ9xPG9+/uk5JGmCu+Gt1YjMm5NfhlWYM5qpo3GiGLQdp5+rdXd2QSphc2mxbMLrzRVZiKJAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FAasbjBVc2jIs8/1VKWncS2jmyY4gaQCkB5Yx6JiDsMIW42zP6GCDM6fC1LTlKKEfIu7FuExJacAr57O4vKdJH5xDDP0xZq1ILtBBHYYhE224a3r6HP348oJTh097xnkkhDRPiDlB8gEn3sH4GhagjlwDFnVJQLZs/5VaE5q2lU=
Received: by 10.86.54.3 with SMTP id c3mr8365537fga.1196759268382;
        Tue, 04 Dec 2007 01:07:48 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.233.204])
        by mx.google.com with ESMTPS id d13sm16004980fka.2007.12.04.01.07.45
        (version=SSLv3 cipher=OTHER);
        Tue, 04 Dec 2007 01:07:47 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200712041055.41593.ismail@pardus.org.tr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67029>

On Tue, 4 Dec 2007, Ismail D=C3=B6nmez wrote:

> Use Perl built-in utf8 function for UTF-8 decoding.
>=20
> Signed-off-by: =C4=B0smail D=C3=B6nmez <ismail@pardus.org.tr>
=20
Looks nice. I have not tested it, but if it works: Ack.
--=20
Jakub Narebski
Poland
