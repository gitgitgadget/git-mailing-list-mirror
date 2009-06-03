From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 14:29:24 +0200
Message-ID: <200906031429.28967.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200906022339.08639.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 14:29:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBpbD-0003UH-Cl
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 14:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbZFCM3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jun 2009 08:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754563AbZFCM3c
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 08:29:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:29287 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbZFCM3b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 08:29:31 -0400
Received: by fg-out-1718.google.com with SMTP id 16so3368335fgg.17
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 05:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=C9qt1l5soQ7aNCYhBwYn+T+NnLoslBdQaqjBSC7CG2k=;
        b=AwJRA0pzrUbHXx9Zbzjb3eXptEnf67WniGXv9kkzhH6JMAccO/1ExCImQCur2DC2bh
         8Luo7sOKZzKFz3Rn+Cg0vmUA4/jXrF8VTzdRDHwc3DV6M3X+Q2D4tyYDy3zgnHJ4XHEA
         KQYofalHFKO8qKnZrptcpl19JDcVyek0OFAk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FOP0+mKED8UlTsd9IBqGm4AP0Pe7nCP5JCuBBXMy6zN0+OT/Bb8t9Q7CyNbHIDtcEP
         +PpqkBlby0tn4czFpjiGCBts+n0UQjkgz6jqN8VYD9Fj9SUL1RYgTJZky9yjGAKMOFxQ
         Vyn8ciQ7KO2QoZJYyf9q+WQxqSlR7jpZJ8Kms=
Received: by 10.86.25.10 with SMTP id 10mr1021947fgy.79.1244032172766;
        Wed, 03 Jun 2009 05:29:32 -0700 (PDT)
Received: from ?192.168.1.13? (abws210.neoplus.adsl.tpnet.pl [83.8.242.210])
        by mx.google.com with ESMTPS id e11sm2196165fga.11.2009.06.03.05.29.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 05:29:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200906022339.08639.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120606>

On Tue, 2 Jun 2009, Jakub Narebski wrote:
> Should we describe here, or in appendix, or in sidenote, or
> in a footnote, all currently supported client capabilities
> and server capabilities?=20
>=20
> =C2=A0* multi_ack (why not multi-ack?)
> =C2=A0* thin-pack=20
> =C2=A0* side-band=20
> =C2=A0* side-band-64k=20
> =C2=A0* ofs-delta=20
> =C2=A0* shallow=20
> =C2=A0* no-progress

There is also another capability

   * include-tag

What does it mean? Is it about sending tags if we are sending objects=20
they point to, or is it about sending all tags?


P.S. Is hexdigit length case sensitive i.e. 0-9a-f, or is it not
     case sensitive i.e. 0-9a-fA-F?
--=20
Jakub Narebski
Poland
