From: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Subject: Re: git archive --worktree-attributes doesn't exclude .gitattributes anymore
Date: Wed, 5 Jun 2013 08:20:48 +0100 (BST)
Message-ID: <1370416848.58042.YahooMailNeo@web172702.mail.ir2.yahoo.com>
References: <20130605031349.GA6727@sigill.intra.peff.net>
 <1370412601.77980.YahooMailAndroidMobile@web172702.mail.ir2.yahoo.com> <20130605071055.GB14427@sigill.intra.peff.net>
Reply-To: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 05 09:20:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk81f-0004Jk-DP
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 09:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab3FEHUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jun 2013 03:20:51 -0400
Received: from nm13-vm0.bullet.mail.ird.yahoo.com ([77.238.189.195]:38732 "HELO
	nm13-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752376Ab3FEHUu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Jun 2013 03:20:50 -0400
Received: from [77.238.189.231] by nm13.bullet.mail.ird.yahoo.com with NNFMP; 05 Jun 2013 07:20:48 -0000
Received: from [212.82.98.109] by tm12.bullet.mail.ird.yahoo.com with NNFMP; 05 Jun 2013 07:20:48 -0000
Received: from [127.0.0.1] by omp1046.mail.ir2.yahoo.com with NNFMP; 05 Jun 2013 07:20:48 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 858355.18701.bm@omp1046.mail.ir2.yahoo.com
Received: (qmail 58135 invoked by uid 60001); 5 Jun 2013 07:20:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.it; s=s1024; t=1370416848; bh=gJ7ycN8WCjGOOIhGJUibPXJNSdIK0mw0XhAFe7LQXMI=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=5jakOULhITt1cveUebqp06irc6sDtYlGU2FLMISwEUf3isbiyVxNMXP8NPRWjokuBIao2ARDmJUGYWZs/w37F4U8HjWJhg0sGMTESBXydIEBgqpwa/uQ0wxwlU45QDWutNWv2Sf9KhUKYgJW+U2M61tRVALesqp2p37QTqgO52o=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jDsdapDS5Lhv4844Msyv4sxx5f5e3CBizwuzVVq6duqHPFuHqrEnt0/sP3gX1TDZGcKyeGuRbU7wApMsPcDwMOKOnOAoSfQY37E92D8XCjowVssYDu5qUGIylf2r8lEKYIvX32Xe7vtiaV/yLIDOaDrhHpn5XoB9z0MGIDPVsoY=;
X-YMail-OSG: NJklhGkVM1lokGCuQU.Xput71lep0TsWlTKa7IGSTZeh_9p
 _4t7NcqV0jzBdFZ9EdWO3hUpuR3T32GAnEMuM6pOXlEPYbpv4kdm6Jghsewf
 yWgTr_5UAcSTZj3opucakCOFpmZJlz3rSa2SgY4Fep5a.GIwVo46MfOLRLBZ
 byWTc6Vp1lYxbQ.gKrJN5xOhV0t35oU9wglL.q9OeZu7HiwY9qR2_KftAQEn
 TD3SfPS975divDU2aIXR1jOJ2iqnTF4eaJJxZco32Ndv2hXcIsXl9x6Y7mkG
 9D3serczKScB1hsKwpPRNZ4pmZ3c29Wz.8kBP2pfMZa1x0J3Ea3aqDrvBmUf
 uwxUaEO71ZQjNK_eIZCLaaRZytuvcEk3YYTY_u8btIE171OWWUtp7DicKT3e
 y16j16QfjEoORxEOeAncSdbb2jIdjsroo0fRhzPA614AfqnS8vtfRo5fPsL_
 PMjRTI.7lOuScsOsyG28HwNuzn64Dt4Bs4Jg_.DHpwd4ovNjmrsQeECmyFhc
 a.VJBcw4bK3B4PAXlzMQZESoBNHqbd4yg3e_D7M7jl9g7tlDKp_fSG02BM9b
 Jk64hn2fGdNPRjca8kBRgTzxjYN79pMXhjDGAyx8F2ljnk_lZff4ip79dnpw
 PYgGicPXf2vSbWe4N8ni7YA--
Received: from [130.192.232.19] by web172702.mail.ir2.yahoo.com via HTTP; Wed, 05 Jun 2013 08:20:48 BST
X-Rocket-MIMEInfo: 002.001,T0gsIEkgc2VlLi4uCgpKdXN0IHVidW50dSBpcyBzeW5jaW5nIGZyb20gZGViaWFuIGV4cGVyaW1lbnRhbC4uLgpodHRwczovL2xhdW5jaHBhZC5uZXQvdWJ1bnR1Lytzb3VyY2UvZ2l0CgoKCgpHaWFuZnJhbmNvCgoKCj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo.IERhOiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ.Cj5BOiBHaWFuZnJhbmNvIENvc3RhbWFnbmEgPGNvc3RhbWFnbmFnaWFuZnJhbmNvQHlhaG9vLml0PiAKPkNjOiAiZ2l0QHZnZXIua2VybmVsLm9yZyIgPGdpdEB2Z2VyLmtlcm4BMAEBAQE-
X-Mailer: YahooMailWebService/0.8.145.547
In-Reply-To: <20130605071055.GB14427@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226438>

OH, I see...

Just ubuntu is syncing from debian experimental...
https://launchpad.net/ubuntu/+source/git




Gianfranco



>________________________________
> Da: Jeff King <peff@peff.net>
>A: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>=20
>Cc: "git@vger.kernel.org" <git@vger.kernel.org>=20
>Inviato: Mercoled=EC 5 Giugno 2013 9:10
>Oggetto: Re: git archive --worktree-attributes doesn't exclude .gitatt=
ributes anymore
>=20
>
>On Wed, Jun 05, 2013 at 07:10:01AM +0100, Gianfranco Costamagna wrote:
>
>> Just a question, is it possible to add a new test for handling this
>> kind of regressions?
>
>Yes, I added one in commit efa5f825.
>
>> And second, is it possible to have a patch for this problem? I'll be
>> glad to backport in debian, or to take care of updating the whole gi=
t
>> package (it is already in experimental BTW)
>
>The fix took a fair bit of refactoring; it's in commits
>9db9eec..efa5f825. You can either cherry-pick that range, or just use
>"git diff" to generate a patch.
>
>However, for Debian, I don't see much point. Everything up through
>unstable does not have the bug (it is all 1.7.10.x or older), and the
>version in experimental is already 1.8.3. So as far as I can tell, no
>Debian release is currently shipping a buggy version.
>
>-Peff
>
>
>=A0
