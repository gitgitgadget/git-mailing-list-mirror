From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms  from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
Date: Wed, 30 Sep 2009 23:13:10 +0000 (GMT)
Message-ID: <949779.47404.qm@web27804.mail.ukl.yahoo.com>
References: <20090930211646.GM14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonas Fonseca <jonas.fonseca@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, Jason van Zyl <jvanzyl@sonatype.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 01:13:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt8MK-0006mv-LQ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 01:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbZI3XNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Sep 2009 19:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbZI3XNI
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 19:13:08 -0400
Received: from n27.bullet.mail.ukl.yahoo.com ([87.248.110.144]:25323 "HELO
	n27.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754258AbZI3XNH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 19:13:07 -0400
Received: from [217.146.182.177] by n27.bullet.mail.ukl.yahoo.com with NNFMP; 30 Sep 2009 23:13:11 -0000
Received: from [87.248.110.116] by t3.bullet.ukl.yahoo.com with NNFMP; 30 Sep 2009 23:13:11 -0000
Received: from [127.0.0.1] by omp221.mail.ukl.yahoo.com with NNFMP; 30 Sep 2009 23:13:11 -0000
X-Yahoo-Newman-Property: ymail-5
X-Yahoo-Newman-Id: 69893.78400.bm@omp221.mail.ukl.yahoo.com
Received: (qmail 48336 invoked by uid 60001); 30 Sep 2009 23:13:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1254352390; bh=PTaos29Yy9BJSOa4OMhv9ppNalIk/AKNjcbd/ucTnOU=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=MMl3vPkhPoVG4p7ktuFtQecjsVvfORN5xjNHtHd/s3sxyiIhqArORCFrgcuG8zALJb53WujEcHozaalUUC7Mo3+FrfXUseKBHbBj6FhqI5GbPSTIr83PMc/XjWK9zHTAR5z8RloM80uZwbfpITiSHHNMqeg8CzyL184SoI6KHI4=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pG6IH/KDGmm5y3xGNIgC/WqDXSx8rwfoZ1vdwAp1QO+zAR5EID7gcUJE45Fx+LjLcau83SXjCYaz04XlfyELr0f8jmdMFZOm7N2qkuFV6E8HJqOpVVDv/NrCiCJVJL5ZextHEOpxK/tJ69W8Wfx53SByxSn2PPv1Ncv7kQpTODA=;
X-YMail-OSG: uf8ocQMVM1mKL_MvcC.sMXzxnDS_qo0FPiRtbgxXya_MGwVsqfeK0t7Fozh44xnX.Oz6aQsVTlTOLUNU9UhxdiEJCEww_f_dmlpiJjwK7yz4cxh9Z6mN_T68Y6K5ZNgtqH6365Q5BnY8O5axZuT9.L9M1oUcZWAPTVUYG_3k0UOzueHZJvAAKyIB0egjegvN.zl70p3ivD6Ls7eirgMbkBORDJgnHXz5UgJyYKqaGDym2phhAhbyfyPh3dghKLaNFfiJs1y3WctDQaCiZvn0LA39ACbNzOeJOaWuUcGY34PF3MzKBYHYHRQaZ5be5IgncA3vUauY3r0deYPHRLb_Tx61WUcsbv8.CXOriW634Uo-
Received: from [62.178.39.60] by web27804.mail.ukl.yahoo.com via HTTP; Wed, 30 Sep 2009 23:13:10 GMT
X-Mailer: YahooMailClassic/7.0.14 YahooMailWebService/0.7.347.3
In-Reply-To: <20090930211646.GM14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129364>

Hi!

I now squashed all my changes into 2 commits and omitted the eclipse pa=
rts. They are available at=20

http://github.com/sonatype/JGit/commits/mavenize2

As Shawn pointed out on IRC, the next step would be to migrate this pat=
ch over to the eclipe.org-post branch which I will do tomorrow evening.

LieGrue,
strub

--- On Wed, 9/30/09, Shawn O. Pearce <spearce@spearce.org> wrote:

> From: Shawn O. Pearce <spearce@spearce.org>
> Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initi=
al poms  from Jasons branch Signed-off-by: Mark Struberg <struberg@yaho=
o..de>
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: "Jonas Fonseca" <jonas.fonseca@gmail.com>, "Robin Rosenberg" <rob=
in.rosenberg.lists@dewire.com>, git@vger.kernel.org, "Jason van Zyl" <j=
vanzyl@sonatype.com>
> Date: Wednesday, September 30, 2009, 11:16 PM
> Mark Struberg <struberg@yahoo.de>
> wrote:
> > > From: Jonas Fonseca <jonas.fonseca@gmail.com>
> > > actually
> > > removes features (by not keeping the JGit
> specific
> > > settings), which
> > > you then try to amend later in the patch series.
> >=20
> > I'm not sure what JGit specific settings you speak
> about?
>=20
> I think he's talking about the Eclipse settings
> files?=A0 Or is it
> something else?
> =20
> > > In terms of making the patch series more
> manageable for
> > > you, I think
> > > the best approach is to start with the patches
> not relevant
> > > to the
> > > mavenizing (renaming PathSuffixTestCase).=20
> >=20
> > In fact the fix of the PathSuffixTestCase came a few
> days later
> > after I found the reason why I miss a few tests. This
> should be
> > fixed in the current master anyway and has not so much
> todo with
> > the mavenization itself.
>=20
> But it should be earlier in the series because its easier
> to apply.
> Use rebase -i to swap the order of the patches.
>=20
> > I had the following in mind: every single commit
> should be
> >=A0 compileable and working. So it's not easily
> manageable to move the
> > directory structure in one patch and apply all the
> changes into
> > the poms in another commit.
>=20
> Well, you need to edit the pom to change the source
> directory and do
> the move in one commit, and then edit the pom further in
> another,
> possibly removing the source directory directories once it
> is the
> standard maven layout.
>=20
> > We could for sure squash the later few commits, but I
> didn't
> > liked to rebase and push since there have been a few
> forks of the
> > mavenize branch and I hoped I could pull back a few
> commits from
> > others and later do a rebase -i.
>=20
> True.
>=20
> At this point we need to rebase the patches on the new
> history in
> the eclipse.org-post branch, which contains a massive
> rename of
> org.spearce to org.eclipse.=A0 That may make the tree
> reorg patch in
> your Maven series harder to bring over to the new history,
> sorry.
>=20
> Worse, we now have to start following the Eclipse IP
> process[1]
> for submissions to JGit...
>=20
> [1] http://www.eclipse.org/projects/dev_process/ip-process-in-cartoon=
s.php
>=20
> --=20
> Shawn.
> --
> To unsubscribe from this list: send the line "unsubscribe
> git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20


     =20
