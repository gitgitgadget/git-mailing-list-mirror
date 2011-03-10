From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: Re* [PATCH 1/2] sha1_name: try to use same abbrev length when
 core.abbrevguard is specified
Date: Thu, 10 Mar 2011 20:54:44 +0900
Message-ID: <1299758084.1499.36.camel@leonhard>
References: <1299581951-4670-1-git-send-email-namhyung@gmail.com>
	 <7vipvsaz27.fsf@alter.siamese.dyndns.org>
	 <7vbp1kayoe.fsf@alter.siamese.dyndns.org>
	 <7vlj0n5o3n.fsf_-_@alter.siamese.dyndns.org>
	 <1299757966.1499.34.camel@leonhard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:54:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxeSH-0006Em-Rv
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 12:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583Ab1CJLyw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 06:54:52 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35290 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab1CJLyv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 06:54:51 -0500
Received: by pvg12 with SMTP id 12so271759pvg.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 03:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:cc:in-reply-to:references
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=1UPcAybZPbxTra4+OBwFHcEDmtAeaYBpYXfW1h9gQiQ=;
        b=Eb0dW+mquGN9SNE1Ye3a0JsLyqwIyMii2tql5liR/tO/CdUtiE9VNEBPgD35exVHbO
         BcQcDUeq8iViF4zSJt65H4xR9XTK96AhWS/iuumeysAOf9dHTPrF8nb6t2B723aAAYLY
         NUmLWK9r69fB/XN8DrganPFqBMg7QtLkzjj2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=LJ8eAQCIJx9WarntXowN5Hv1mGXaqCqe/B3CClinzFvwxYqJ3DDyywnkG437c7S/I0
         CrmSVIjqGhLK58tyMM9QS83k3toiKWYC84a1glVTtZD3cXQtsXAH2PhILCGeJSRCEOXu
         my7cPBaZIVo8fwhfZr+rxGS4KNAG0eCXXPf/0=
Received: by 10.142.250.20 with SMTP id x20mr6328724wfh.391.1299758089504;
        Thu, 10 Mar 2011 03:54:49 -0800 (PST)
Received: from [118.176.73.109] ([118.176.73.109])
        by mx.google.com with ESMTPS id w19sm3822438wfd.8.2011.03.10.03.54.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Mar 2011 03:54:49 -0800 (PST)
In-Reply-To: <1299757966.1499.34.camel@leonhard>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168812>

2011-03-10 (=EB=AA=A9), 20:52 +0900, Namhyung Kim:
> 2011-03-10 (=EB=AA=A9), 01:19 -0800, Junio C Hamano:
> > And here is an attempt to do so.  I have to admit that I didn't giv=
e it
> > too much thought, though, so please be careful when reviewing the l=
ogic.
> >=20
>=20
> What if the unique length is greater than or equal to the given lengt=
h?
> For instance the unique length is 7 and the caller gives 7 and the gu=
ard
> is 3. What do you want to return, 7 or 10? How about the unique lengt=
h
> of 8?
>=20
> I think the meaning of the guard is somewhat vague. When this feature
> was considered in LKML at first, Linus just wanted to change the defa=
ult
> length of commit abbreviation to 12 by making it user-configurable. [=
1]
> And this is the same situation what I tried to tell you in the previo=
us
> email.
>=20

Oh, I missed the link. :)

[1] https://lkml.org/lkml/2010/10/28/264


--=20
Regards,
Namhyung Kim
