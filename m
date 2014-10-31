From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: Re: Regression and failure to clone/fetch with new code Re: git-svn performance
Date: Fri, 31 Oct 2014 02:30:17 +0000
Message-ID: <1414722617.89476.YahooMailBasic@web172305.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Fri Oct 31 03:30:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xk1yp-00060a-Gs
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 03:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161600AbaJaCaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2014 22:30:20 -0400
Received: from nm2-vm6.bullet.mail.ir2.yahoo.com ([212.82.96.86]:51977 "EHLO
	nm2-vm6.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422652AbaJaCaS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 22:30:18 -0400
Received: from [212.82.98.127] by nm2.bullet.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 02:30:17 -0000
Received: from [212.82.98.77] by tm20.bullet.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 02:30:17 -0000
Received: from [127.0.0.1] by omp1014.mail.ir2.yahoo.com with NNFMP; 31 Oct 2014 02:30:17 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 273181.95344.bm@omp1014.mail.ir2.yahoo.com
Received: (qmail 52923 invoked by uid 60001); 31 Oct 2014 02:30:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414722617; bh=pZ4Unbkvu6EkAPAdsCLRYERStkn6pcoL1gOmrzHtZHU=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=NbcK90St/ij3OufPYsivjUi9Yl5IiJyRxkIokxdCUlbvt2LIvnZzv8gio45FZu25nsjqC8LGOt2SbrmPNQEXadHYHDDaHwGIX8+DmrpomfiIb/73cYwUrf6tabD030oaDxuNWRHgp8CMMIs6Hj0IUAfFaGZlycQeS3GL8gxge/A=
X-YMail-OSG: NIL5SIcVM1nbSiKtSdihWlecmh0csh7iFdf8t4YoNkq_89L
 vbyHN4aO.guS838EcIot8FveMAiWRQrA3_dTqsy1hV1RzB1P8gnef75Yk6dv
 LMGQP04l5ADwC3lrRVFOQOXTy.wD87eB2k5ArW9eVWB5fYd4V6TZOdCslaFL
 ywgxt7yzOwu_xkyW5WpG9krcCyYBgwegTo65qCxNjq0BNIeBzfgQDtIw6_OH
 dW3ngCgrHmQMOPvuMTP0_FS3TOnURxrOhXQ3_IMT78BO0Ow1JnuzyoUEJQaD
 e21X_r5W_02FIbbx5.yaAicsHhJtRN4QOs.ejdjrUsvBqr_zXrFiR1CA82D9
 L0r1My4VJ1v2gP1VTqtk_8qTl9XZzf9H25exjT0zDF_EZ6CUx2Ucep4ydcO1
 tqlngh.cIGby9EDYFD_c32J7bnufC23a8FWGtEL5tYe5gyDCBJ.5G4EytoSd
 ScfdF3S37ZzUUdHCjMRHc.o5lb5TjNdWA8xjDlOxYBl21_UDe0N7wTNnJ9Gm
 KFfRp03ox.431wialW96eeJMgIKSGafpLehtP7FoDWINO0Mju.oT54BSZH.J
 B.k0pN0WtoCP1AKC1MkH_RWHZFUaEPKZsm92XDjzt7ntLm4bG8aBpGKCMssF
 0y9AgPUh4pINew2ovNWV66B2mbF5paUF8IXbMgHiJuCixnwmwYTH2937w.24
 aTvYUH8fj._SZfe3P
Received: from [86.30.137.134] by web172305.mail.ir2.yahoo.com via HTTP; Fri, 31 Oct 2014 02:30:17 GMT
X-Rocket-MIMEInfo: 002.001,KGFwb2xvZ3kgZm9yIHRoZSBlbXB0eSBtZXNzYWdlIGFnYWluIC0gc3RpY2t5IGZpbmdlcnMgaW4gc21hcnQgcGhvbmUuLi4pDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KT24gVGh1LCBPY3QgMzAsIDIwMTQgMDg6NDYgR01UIEVyaWMgV29uZyB3cm90ZToNCg0KPlRoYW5rcywgSSdtIG5vdCBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUsIGJ1dCBjYW4geW91IHRyeSB0aGUNCj5mb2xsb3dpbmc_DQo.DQo.ZGlmZiAtLWdpdCBhL3BlcmwvR2l0L1NWTi9SYS5wbSBiL3BlcmwvR2l0L1NWTi8BMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(apology for the empty message again - sticky fingers in smart phone...=
)

------------------------------
On Thu, Oct 30, 2014 08:46 GMT Eric Wong wrote:

>Thanks, I'm not able to reproduce the issue, but can you try the
>following?
>
>diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
>index 75cdac9..82d6108 100644
>--- a/perl/Git/SVN/Ra.pm
>+++ b/perl/Git/SVN/Ra.pm
>@@ -153,6 +153,7 @@ sub url {
> sub check_path {
> =A0=A0=A0 my ($self, $path, $r) =3D @_;
> =A0=A0=A0 my $cache =3D $self->{cache}->{check_path};
>+=A0=A0=A0 $r =3D int($r);
> =A0=A0=A0 if ($r =3D=3D $cache->{r} && exists $cache->{data}->{$path}=
) {
> =A0=A0=A0 =A0=A0=A0 return $cache->{data}->{$path};
> =A0=A0=A0 }
>@@ -169,6 +170,7 @@ sub check_path {
> sub get_dir {
> =A0=A0=A0 my ($self, $dir, $r) =3D @_;
> =A0=A0=A0 my $cache =3D $self->{cache}->{get_dir};
>+=A0=A0=A0 $r =3D int($r);
> =A0=A0=A0 if ($r =3D=3D $cache->{r}) {
> =A0=A0=A0 =A0=A0=A0 if (my $x =3D $cache->{data}->{$dir}) {
> =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 return wantarray ? @$x : $x->[0];
>---

I added those two lines to my git and there is no improvement. It still=
 won't svn fetch the next
revision. I think it may be important/interesting to find out when or h=
ow it becomes non-int,
so I have tar'gz'ed my wont-fetch virtual box .git and in the middle of=
 uploading here:=20

http://sourceforge.net/projects/outmodedbonsai/files/R/

I am also uploading my old R clone also - maybe you'd like to see why i=
ts .git/svn/.caches
is so big compared to a recent one, as well as how and why there were a=
n extra merge
and two missing merges compared to a recent clone?

(FYI - I have some local stuff on my old R clone. They are mostly
there because the R devs don't agree etc but there is nothing confident=
ial about them).
