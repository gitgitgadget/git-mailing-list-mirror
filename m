From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Thu, 20 Aug 2009 10:23:08 +0200
Message-ID: <200908201023.09380.jnareb@gmail.com>
References: <1250509342.2885.13.camel@cf-48> <200908200937.05412.jnareb@gmail.com> <fcaeb9bf0908200048v4c918a16o6c0e0fb545742f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Tomasz Kontusz <roverorna@gmail.com>,
	git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 10:23:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me2vg-00046f-04
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 10:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbZHTIXT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2009 04:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbZHTIXS
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 04:23:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:63854 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbZHTIXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 04:23:17 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1192281fga.17
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=p1Pqh/4D3CXBoiaayNZpYhHg9Qg0smgO+7P7OFRGoB8=;
        b=LiSZRARlvvyIuDtyZ+GghVK2izFW333Pdv0P49odX5C8SIQpLL/Z6ca2z3aRSbfZXD
         k5VaRKpfCjv71f8VqITNu4UUuREZhwK2FAaG2+RXKKZPipI+7Nzky1FbFX+u+Cc7C3tB
         mtg1ln6AHDtKSwYFZ/ttY926QnXAxSqsSFuok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=SUFaZKtaXrhk6XCaclcpliTv6NWSxWnr/1aO51grfSZv+thnEv9NAd1BA63vwlmrUH
         vk9OWBIRZ1E0TrzBMbhDUQcsa85bYHsL2PWbgtYN8Zs2QaMMhziJJ/vrERwf2HL/juk1
         1T7tlDy1vjLmIARSgLV/o4vfC2Fbm3zE2Vis4=
Received: by 10.86.220.11 with SMTP id s11mr4882028fgg.47.1250756597415;
        Thu, 20 Aug 2009 01:23:17 -0700 (PDT)
Received: from ?192.168.1.13? (abvn197.neoplus.adsl.tpnet.pl [83.8.211.197])
        by mx.google.com with ESMTPS id 4sm2106353fge.11.2009.08.20.01.23.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 01:23:16 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0908200048v4c918a16o6c0e0fb545742f2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126615>

Dnia czwartek 20. sierpnia 2009 09:48, Nguyen Thai Ngoc Duy napisa=C5=82=
:
> On Thu, Aug 20, 2009 at 2:37 PM, Jakub Narebski<jnareb@gmail.com> wro=
te:

> > *NEW IDEA*
> >
> > Another solution would be to try to come up with some sort of stabl=
e
> > sorting of objects so that packfile generated for the same paramete=
rs
> > (endpoints) would be always byte-for-byte the same. =C2=A0But that =
might be
> > difficult, or even impossible.
>=20
> Isn't it the idea of commit reels [1] from git-torrent?
>=20
> [1] http://gittorrent.utsl.gen.nz/rfc.html#org-reels

Well, I didn't thought that this idea didn't occur to anybody else.
What I meant here was that it is a new idea mentioned in this subthread=
=2E

--=20
Jakub Narebski
Poland
