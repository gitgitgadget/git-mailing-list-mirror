From: Luben Tuikov <ltuikov@yahoo.com>
Subject: (resolved) Re: Problem in fetch (kernel)
Date: Tue, 24 Aug 2010 00:50:50 -0700 (PDT)
Message-ID: <46131.81436.qm@web31811.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 09:54:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnoKq-0000ys-1F
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 09:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752979Ab0HXHux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 03:50:53 -0400
Received: from web31811.mail.mud.yahoo.com ([68.142.207.74]:27231 "HELO
	web31811.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751190Ab0HXHuw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 03:50:52 -0400
Received: (qmail 81467 invoked by uid 60001); 24 Aug 2010 07:50:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1282636251; bh=MBYojS9jpFa9ydFYbbHnr8khheevr0altYuV0hJBib8=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=gXFOfqyPP69YByD9JO0KOI/OcmHL8Ya7YKXXJYA0acyhBf+qjKp9sXoy8R0k+eciq6mJwpwtx4R9ha/umS6ocWl+KN2mW79ooYqazOVPbcLlBpSS9VHAB7TYPTRLWFX5MEEi2AKzeGiAHqK4GkuC8QBGA6h0WkTLw+a4O2a7y14=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4Z9qtQuvu0/n0kSXB1AeMwKuIFeNscnEH87q/d3IGLt+OVzk06XuWTG5kjgNTzWPYMTRm2qi2TeTryEfMDnXHxatWmsbAnXl9W2I53r5lLHIwP0nfqH3twVVWYoQnFb33iI8YAGH6RyESpw9IX/O5phT/M1OPJUrxKo/D+24wTA=;
X-YMail-OSG: S4UIqvEVM1kSe2Qg5HxCU6Nl4bCulOKwN.ACzIOPP.vOaqA
 qia293AjuwjD5eL9YEzl_N_OF7QpsX_DnqL1p7w0bR5jdmdkVc_vLkuUmvr3
 I47GpjIRQ23GlKsm1jzQZOXRacTAmNdoNfsO9svqr33fdSUn6L9o4ItmL0gP
 xuuUrdohe6qLDYqQdWNPNX4I68CsYttUE3_3FCWydGc.qY4cezXmh727IGXc
 H.iSZDV.np0lRXo.VcOR3vDFHSrRKIHNiiAuIZEqhNm0.Gf4oSj.X_JU_OVc
 _ppAqX3Ej4OsIKL2nXV4s2FknToATANEyeETfIKvfkiVf7e6ieeI.EzUy4yT
 1kHbV1mh.zVFSNkzn1bPUPKkOgGvU
Received: from [71.132.202.60] by web31811.mail.mud.yahoo.com via HTTP; Tue, 24 Aug 2010 00:50:50 PDT
X-Mailer: YahooMailClassic/11.3.2 YahooMailWebService/0.8.105.279950
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154307>

Sorry for the noise. Third time's a charm.  :-)

   Luben


--- On Tue, 8/24/10, Luben Tuikov <ltuikov@yahoo.com> wrote:

> From: Luben Tuikov <ltuikov@yahoo.com>
> Subject: Re: Problem in fetch (kernel)
> To: git@vger.kernel.org
> Date: Tuesday, August 24, 2010, 12:32 AM
> Okay, I updated git to latest
> (1.7.2.2.165.gbc382) and after a "git reset" this is what I
> get:
>=20
> $git pull -v --verbose linus
> walk d1b113bb028999e82a8528e1484be8c23fb5a7d9
> walk 9c5ea3675dbe4853eea747542da257c3e6f18de2
> walk cca77b7c81876d819a5806f408b3c29b5b61a815
> Getting alternates list for http://kernel.org/pub/scm/linux/kernel/gi=
t/torvalds/linux-2.6.git
> Getting pack list for http://kernel.org/pub/scm/linux/kernel/git/torv=
alds/linux-2.6.git
> error: Unable to find
> 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a under http://kernel.org/pub/=
scm/linux/kernel/git/torvalds/linux-2.6.git
> Cannot obtain needed blob
> 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a
> while processing commit
> cca77b7c81876d819a5806f408b3c29b5b61a815.
> error: Fetch failed.
>=20
> How do I resolve this?
>=20
> Thanks,
> =A0=A0=A0Luben
>=20
> --- On Tue, 8/24/10, Luben Tuikov <ltuikov@yahoo.com>
> wrote:
>=20
> > From: Luben Tuikov <ltuikov@yahoo.com>
> > Subject: Problem in fetch (kernel)
> > To: git@vger.kernel.org
> > Date: Tuesday, August 24, 2010, 12:18 AM
> > Hi guys,
> >=20
> > While trying to pull the kernel I get this:
> >=20
> > git pull -v --progress linus
> > error: Unable to find
> > 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a under http://kernel.org/pu=
b/scm/linux/kernel/git/torvalds/linux-2.6.git
> > Cannot obtain needed blob
> > 8faa6c02b39ec3896bd4e989c82ce7f6dbdaf04a
> > while processing commit
> > cca77b7c81876d819a5806f408b3c29b5b61a815.
> > error: Fetch failed.
> >=20
> > This is with git 1.7.1.
> >=20
> > How can I resolve this?
> >=20
> > Thanks,
> > =A0=A0=A0Luben
> >=20
> >
>=20
