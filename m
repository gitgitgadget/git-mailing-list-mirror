From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Wed, 25 Jun 2008 10:58:52 +0200
Message-ID: <200806251058.54319.jnareb@gmail.com>
References: <m31w2mlki4.fsf@localhost.localdomain> <7vod5qa0tu.fsf@gitster.siamese.dyndns.org> <20080625022610.GB20361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Jeske <jeske@google.com>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 11:00:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBQrG-0007as-5r
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 11:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbYFYI7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 04:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753916AbYFYI7J
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 04:59:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:28370 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbYFYI7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 04:59:08 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1121443ywe.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=inaIRyQaekjDR+JBSd8MExKXDe7BqE/tdQ6qOCwvtyU=;
        b=F49Pg1upggUDlfcdGyqqLJ04v3K14GSIoaENov1gfaIuFotwjITNJU4Vwmmf1ztpC/
         EydBc8tVd9esDbc3QOkixK464ATqLfxY69VoUKI5xIoG1HYZoYN9kpzC1V+CRdj0hFLo
         Dipew4Zjlc7i2cwxmyu4xMZx+A9X+VfQfQGBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=e4y5Mz/poyGGOxmvSKKoSpETiPxOqwVMFlOW7E4yj4nQaEaJc4CsuB/WwjAhNBlNkX
         QRTPWwMLS+O6FHcwwZ2NHFn0XS70nKUE77oDbPfRrtKh15Hz00PoqZ0Z8K1OBFhZaP/8
         tifC7KaNUhWzcfDajK233jpQxx9V2TRLGq1jQ=
Received: by 10.103.222.1 with SMTP id z1mr2843842muq.71.1214384346280;
        Wed, 25 Jun 2008 01:59:06 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.223.44])
        by mx.google.com with ESMTPS id i5sm28241283mue.2.2008.06.25.01.59.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 01:59:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080625022610.GB20361@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86257>

On Wed, 25 Jun 2008, Theodore Tso wrote:

> The reason why I've been thinking that I should change my shell scrip=
t
> from:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git checkout integration
> =A0=A0=A0=A0=A0=A0=A0=A0git reset --hard <foo>
>=20
> to:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git update-ref ref/heads/integration HEAD
> =A0=A0=A0=A0=A0=A0=A0=A0git checkout integration

Hmmmm.... Wouldn't it be easier on fingers to use

          git reset --soft integration

--=20
Jakub Narebski
Poland
