From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 22:03:31 +0100
Message-ID: <201102162203.40480.jnareb@gmail.com>
References: <20110216032047.GA2858@elie> <7v1v37kb3p.fsf@alter.siamese.dyndns.org> <20110216195931.GA22884@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:04:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpoXb-00005R-HH
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab1BPVD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 16:03:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63481 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab1BPVD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 16:03:56 -0500
Received: by fxm20 with SMTP id 20so1851417fxm.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 13:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=1cg7D8U1Fw5Q0maKwr7O3JSUdlhJZG84u+GAaOF0fIc=;
        b=l2Mc6/zmuCGsoEKnlom0wtz0AXVSdS/6YYw8xsrgQiqwnAo5YVI2M9erfrizGD7RH+
         Ll9Zu+7dsH5xjl4pT+rUQC2Gy0f+hqIollyQK21wiUjNfsJ/46tkYpnbxOGX9TD8BpRz
         hDbYsjl+viQkrqu3FX3ygdcl9HVzZkEv2udog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D04nnLKDvSZmahad2cXIWDmH56JaE8fyjF2HLCInVxVs0BSXMe1FAqvoEjghywJvEK
         4kd6XIPSA+93iQVEGxYb2CKQk9gYzs0jpI5cFAOvV8RkWHVU3fqTFC+zN1yEu9PhKAro
         4jBL5/L1HomTw037Th5s3L1Yy9s1lSQR7BPJQ=
Received: by 10.223.72.197 with SMTP id n5mr1355507faj.8.1297890235261;
        Wed, 16 Feb 2011 13:03:55 -0800 (PST)
Received: from [192.168.1.13] (abvl215.neoplus.adsl.tpnet.pl [83.8.209.215])
        by mx.google.com with ESMTPS id c11sm118756fav.2.2011.02.16.13.03.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 13:03:53 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110216195931.GA22884@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166999>

Dnia =C5=9Broda 16. lutego 2011 20:59, Jeff King napisa=C5=82:
> On Wed, Feb 16, 2011 at 11:55:54AM -0800, Junio C Hamano wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > > But as I said, I am not against a config option if it is such a c=
ommon
> > > problem. I certainly would not turn it on. And I don't think it s=
hould
> > > be on by default.
> >=20
> > I think we are pretty much on the same page, except that I am not v=
ery
> > interested in the index-log either.
>=20
> To be fair, I am not sure I am that interested in the index-log eithe=
r.
> I just see it as a superior solution to the same problem, but I don't
> consider it a very important problem.
>=20
> So I think we are really on the same page. :)

Also it would be not as easy as reflogs - you would have either to save
copy of index, or create a tree out of it and save reference in reflog.

--=20
Jakub Narebski
Poland
