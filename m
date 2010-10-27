From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Wed, 27 Oct 2010 14:38:27 +0200
Message-ID: <201010271438.28026.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <1287917136-26103-11-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 14:39:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB5HR-00071B-BW
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 14:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761106Ab0J0Mis convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 08:38:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64188 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab0J0Mir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 08:38:47 -0400
Received: by bwz11 with SMTP id 11so525774bwz.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 05:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=3e3RvjGmzowsr30nLEbNpehhkS1irpyUHt6QYyRiH+k=;
        b=pyNpJIc96N2BekImifhJ6l4bHKNHKt2fYBXwrAAQGD/KWSxrJdr2Jna9F6SpinVLTV
         ubuxiXEwch751Y+o+8eOYFmQRdysed8LcnkdP4e7G0RjY8Dj3Ohcn2W1sMfOqANUHDVe
         0StSgklzkVg9CeRn3855EjW2pNDcmkoHmabvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=F6xcrdllLkm0FxM9wAyjaaE2/xUlGG4vl+qG27mGL5CAIRhUiiPp436rOQYHLV6rHj
         4wW8cXjmH2miqwU55CdXlSZgM75grPDc+0cp2mnN3r0Wem0CQHQsPuMvNrgPC1oaPlwO
         xU0rXezVzzvP3fMAv+nyZjex8qDZA3me6OqVI=
Received: by 10.204.113.195 with SMTP id b3mr6473106bkq.210.1288183125941;
        Wed, 27 Oct 2010 05:38:45 -0700 (PDT)
Received: from [192.168.1.13] (abvr250.neoplus.adsl.tpnet.pl [83.8.215.250])
        by mx.google.com with ESMTPS id y19sm6923969bkw.18.2010.10.27.05.38.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 05:38:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287917136-26103-11-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160036>

On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:

I forgot to mention this:

> +=A0=A0=A0=A0=A0=A0=A0foreach (keys %$remotes) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0my $remote =3D $_;

Why not simply

  +       foreach my $remote (keys %$remotes) {

--=20
Jakub Narebski
Poland
