From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: git-archive's wrong documentation: really write pax rather than tar
Date: Wed, 10 Aug 2011 04:08:34 +0100 (BST)
Message-ID: <1312945714.193.YahooMailClassic@web29510.mail.ird.yahoo.com>
References: <4E3D8EA9.3000609@lsrfire.ath.cx>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Aug 10 05:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqz9t-00018g-Tk
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 05:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab1HJDIh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 23:08:37 -0400
Received: from nm6.bullet.mail.ird.yahoo.com ([77.238.189.63]:24703 "HELO
	nm6.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752288Ab1HJDIg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Aug 2011 23:08:36 -0400
Received: from [77.238.189.232] by nm6.bullet.mail.ird.yahoo.com with NNFMP; 10 Aug 2011 03:08:35 -0000
Received: from [212.82.108.237] by tm13.bullet.mail.ird.yahoo.com with NNFMP; 10 Aug 2011 03:08:35 -0000
Received: from [127.0.0.1] by omp1002.mail.ird.yahoo.com with NNFMP; 10 Aug 2011 03:08:35 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 97106.81051.bm@omp1002.mail.ird.yahoo.com
Received: (qmail 14946 invoked by uid 60001); 10 Aug 2011 03:08:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1312945715; bh=Sx0uENkpvA7l/MQEDIO79kUe3lQLxz+KEJhpT3rIR9g=; h=X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=wjwr0SK54GMslyxXnPdei9rviw2l2vv690Wbv1rYXO+e9FLql5nW6LK8iMVDXNs+cxdmCJ9IQf30+9iyeQb/jgYSWO8O6/ejgvLA0AVI6Go3qCXawF09339uS8TfVkWgqWGt7jAqyG9k4TblGYWlSnd6EyV56Yb5MH8iiPVossw=
X-YMail-OSG: HMm2rJkVM1kZM2c57k.6VtgafpwuOZeqC4pOWFMqSZ.WkPH
 7MPi6SPYZAmBenAOOcun.LbeOxSXD9mugNKaptUi4scZXTHrEHaoEtQAggEi
 MiaYcuaHT.nSJ4Itf3ItesaVwMm3q6CL_Geqwt2LU1lyC0yX2yxk60BPTEh7
 SvFz6tJB9IfHoHFK5wXhORktG4pPcSKWz.Q.MVA0ZrtOaAa4lFvY9gziEU0Q
 51LlPzjDexbHMJtfoe67tGdN1T05Y_1J7sODITd6FdsmYjPxgnpZMtkyBv4u
 NXdz_SRRELzBmBjbBmLOveDM5JolR8xMgdUcnsX6sxaQt1CvvIYu5r9dAOgP
 mllqbxSGuhL.9cXx6gfJgVS2I87oDND4FWgZi7bg9an1dBEQKye55_R0jDTP
 IhRkUJo5s1J_paC26RqvT7xf6Nt3UbQOADRFL_KDrecDKQAE5vr7uDwKhnnG
 iUE1mPYgB21CbAqxD2uVWplc4kAsUC7_PdSVLMyvQtMZDMxyjTfeU3BMYflo
 npBx2c5eRTnU6MPQM
Received: from [81.101.129.153] by web29510.mail.ird.yahoo.com via HTTP; Wed, 10 Aug 2011 04:08:34 BST
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/14.0.4 YahooMailWebService/0.8.113.313619
In-Reply-To: <4E3D8EA9.3000609@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179056>

--- On Sat, 6/8/11, Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

> That doesn't sound good.  Looking at the R source,
> however, I can see
> that they use a two different algorithms to compute the
> checksum than
> the one specified by POSIX (even though I don't fully
> understand what it
> actually is their doing, since I don't know R).  So
> worry too much about
> the warning; as long e.g. "tar tf <file>" doesn't
> complain your archive
> should be intact.

I filed the bug,
https://bugs.r-project.org/bugzilla3/show_bug.cgi?id=3D14654
and they have fixed it bug has a few comments to make:

---------------
=46ixed in R-devel and patched (your checksum field has more than 6 dig=
its which
is highly unusual [since it can't be larger than 6 digits] but technica=
lly
allowable).

I should add that the original tar format mandated that checksums are
terminated by NUL SPACE, so in that sense your tar file is invalid (the=
re can't
be more than 6 digits since the checksum field consists of 8 bytes). un=
tar2
will now be more forgiving, but whatever program created that tar file =
should
be fixed.
-----------------

Please feel free to respond directly at the R bug tracking system, or I=
 can cut-and-paste bits of e-mails also...
