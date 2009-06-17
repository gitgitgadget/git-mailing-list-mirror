From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [EGIT PATCH2/2] fixed-toString-for-CommitTimeRevFilter-wrote-JUnit-tests
Date: Wed, 17 Jun 2009 07:58:51 +0000 (GMT)
Message-ID: <324918.80855.qm@web27805.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 09:59:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGq39-0000XW-Ua
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 09:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbZFQH6v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2009 03:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754232AbZFQH6v
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 03:58:51 -0400
Received: from web27805.mail.ukl.yahoo.com ([217.146.182.10]:22211 "HELO
	web27805.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752570AbZFQH6u convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 03:58:50 -0400
Received: (qmail 81040 invoked by uid 60001); 17 Jun 2009 07:58:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1245225532; bh=x45KbP4fWYX5tzItKiVwr75bkFNVTTPLaLVRbxD0i+g=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=1qlEdlc5tgWyo/B2jYmHPeEBrja7cVBsme6ma3/IxKFqi5swS6snPUh+mfHIWKAChXmxQJ34stnqlU2j6Qre4PDjtxAhDdtVEmhDKBB9+VPzv6+NAsVUCC0etuw1cyAUVy7jtsusDFu8RHK/9TuihCze+I1DpYM6DqSQ/aV4ifc=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=UBdG477DRU/np2NrQYk8Abjt28h9TkD+4b41BsORnr1kTHCAHVaFnx2yiawAkpwcaFv+E7PeEiwI3rW+7fTdmc3rWeufop+oiKYIroouJTNo4gqNR7BopJW8SAI6oyUU9EABZLX2d5hDy+QlbqmL7FYT8cPAaJ++Idqk+d3T8uw=;
X-YMail-OSG: lyL1F2sVM1nbbBErxuUUe1tVyGDSn2TEvJ.rIo_jtd26vbnMtlSWe18pKQCjzbR7hjh5V85JXMBn.JKWNsEEBooMfb1pj2dkAoFStPLQFu9MMcMebMfpbLWSsoCGczsH.GLTAoPX6vyn0HD8Mmxynj0jRSNCXf0bYwG.E4f.S0yMShcKwey9CVERnd11hyU0aRhmDHf_wFOfHP5uo1fxPLmUkg9MbLOAnkO7KCATJVUot2kPOTTjMMAlyHjbBv2zDQ_hHrZsohh._ZL2ARkwYZshOjVXtjadFgniw3z0vaczheoLfXXKiMMK6Sy0Gu5b3JmEGCq8p1QW0YqHNKXNVxSnuZ4FKFqRyPAa8RhliawyOVA-
Received: from [213.235.230.200] by web27805.mail.ukl.yahoo.com via HTTP; Wed, 17 Jun 2009 07:58:51 GMT
X-Mailer: YahooMailClassic/5.4.12 YahooMailWebService/0.7.289.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121728>


Thanks Robin!

I'm currently working on a larger change by introducing a SimpleReposit=
ory class [1] which wraps most of the jgit interna for easier use in ex=
ternal projects, mainly maven-scm-provider-jgit [2]. Since this isn't y=
et ready to be merged into master as a whole, I had to chop the commits=
 later. This is the reason why the subject doesn't perfectly fit, apolo=
gise.

LieGrue,
strub

[1] http://github.com/sonatype/JGit/tree/72dd9d071ce140f267b8b4effd34d1=
22627135e6/org.spearce.jgit/src/org/spearce/jgit/simple
[2] http://github.com/struberg/maven-scm-providers-git

--- Robin Rosenberg <robin.rosenberg.lists@dewire.com> schrieb am Mi, 1=
7.6.2009:

> Von: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
> Betreff: Re: [EGIT PATCH2/2] fixed-toString-for-CommitTimeRevFilter-w=
rote-JUnit-tests
> An: "Mark Struberg" <struberg@yahoo.de>
> CC: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
> Datum: Mittwoch, 17. Juni 2009, 0:19
> m=E5ndag 15 juni 2009 23:36:35 skrev
> Mark Struberg <struberg@yahoo.de>:
> >=20
> > From 72dd9d071ce140f267b8b4effd34d122627135e6 Mon Sep
> 17 00:00:00 2001
> > From: Mark Struberg <struberg@yahoo.de>
> > Date: Mon, 15 Jun 2009 08:07:53 +0200
> > Subject: [PATCH] fixed toString for
> CommitTimeRevFilter + wrote JUnit tests for after, before
> and between walks
>=20
> What is the connection between the toString and the rest of
> the patch? Should be
> separate patches.
>=20
> You should sign off the patches.
>=20
> Start the subject with a capital letter.
>=20
> Technically it seemed ok, but I shouldn't have pushed them,
> as I did, by mistake when pusing
> Shawn's latest patch. The formal errors should have been
> fixed firsts.
>=20
> -- robin


     =20
