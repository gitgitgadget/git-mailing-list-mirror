From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 14 May 2009 22:27:07 +0200
Message-ID: <200905142227.10669.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200905141024.17525.jnareb@gmail.com> <alpine.LFD.2.00.0905141353040.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 14 22:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4hWd-00067t-FP
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 22:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833AbZENU1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 16:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754010AbZENU1X
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 16:27:23 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57746 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbZENU1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 16:27:22 -0400
Received: by fxm2 with SMTP id 2so1547011fxm.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=tlK7sb7C08KL0NRxVjK+IkJmpIWweZhxaWZg5AlS7L0=;
        b=rE6ncQFIleuyXLQWkfnDiWcv3KVQAcluirD6ZBTZP1CBCG3iXFgD9ZaxbTKJd23vmR
         xKMKHRfDEEPx2b1Jw1ZR95TdiCqUKzmhPVBRuGT8yaaLacPVdXAhVcHFJ3STFJ8kXyBs
         lmL6E8R3LIkacbhA9cU+/0DHhkucS1BfpDb/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IgeR9r2Oia0Aq+muTvHSO4a7bU0IiLSkKR8vSJPOxpffVTGTaAJPLxeJm2qJxipcps
         9XbL22BN6MERDmC6NfiEb5qlBs8w5GEldHG2Juvq0sltCTiNLJdgp7SGtWx7J2XWq2X4
         rQ9YkTFfahagdLI920XfN/mcEICC4UMNOttLw=
Received: by 10.86.59.18 with SMTP id h18mr2926134fga.44.1242332842547;
        Thu, 14 May 2009 13:27:22 -0700 (PDT)
Received: from ?192.168.1.13? (abwb23.neoplus.adsl.tpnet.pl [83.8.225.23])
        by mx.google.com with ESMTPS id l19sm6245458fgb.2.2009.05.14.13.27.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 13:27:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0905141353040.6741@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119221>

On Thu, 14 May 2009, Nicolas Pitre wrote:
> On Thu, 14 May 2009, Jakub Narebski wrote:
>=20
> > I was afraid of this: that the people who know pack protocol good
> > enough to be able to write it down are otherwise busy. But we get
> > detailed / updated packfile and pack index format descriptions some
> > time ago (thanks all that contributed to it!). I hope that the same
> > would happen with pack _protocol_ description.
>=20
> If someone with the wish for such a document volunteers to work on it=
=20
> then I'm sure people with fuller knowledge will review and comment on=
=20
> the result as appropriate.

Well, but still somebody with time and at least some expertise in
the area would be required to start it.
=20
> > I was hoping of document in RFC format; dreaming about having it
> > submitted to IETF as (at least) unofficial RFC like Atom Publicatio=
n
> > Protocol (or is it proper RFC these days?), and then accepted like
> > HTTP protocol.
>=20
> I think we'd have to move to a new version of the protocol for that. =
=20
> The current protocol, even if it does the job, is not particularly=20
> elegant.

Are all RFC (including proposals / informational RFCs) defined protocol=
s
elegant? Well... perhaps they are. The quality of IETF standards is way
higher than, say, ECMA :-)

But I accept that having RFC to be on the list of 'official' RFCs, even
as an "experimental" RFC is just a dream. Nevertheless I think that=20
following RFC format, which includes using a common set of terms such=20
as "MUST" and "NOT RECOMMENDED" (as defined by RFC 2119), Augmented=20
Backus=E2=80=93Naur Form (ABNF) (as defined by RFC 5234) as a metalangu=
age,
would be a good idea for technical / protocol documentation.

--=20
Jakub Narebski
Poland
