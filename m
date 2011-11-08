From: Prasad Deshpande <prasadgdeshpande@yahoo.com>
Subject: git log --quiet bug?
Date: Tue, 8 Nov 2011 06:36:18 -0800 (PST)
Message-ID: <1320762978.3614.YahooMailNeo@web84005.mail.mud.yahoo.com>
Reply-To: Prasad Deshpande <prasadgdeshpande@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 15:36:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNmmp-0006H9-HJ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 15:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668Ab1KHOgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 09:36:23 -0500
Received: from nm14.access.bullet.mail.mud.yahoo.com ([66.94.237.215]:25243
	"HELO nm14.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932645Ab1KHOgV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 09:36:21 -0500
Received: from [66.94.237.197] by nm14.access.bullet.mail.mud.yahoo.com with NNFMP; 08 Nov 2011 14:36:19 -0000
Received: from [66.94.237.112] by tm8.access.bullet.mail.mud.yahoo.com with NNFMP; 08 Nov 2011 14:36:18 -0000
Received: from [127.0.0.1] by omp1017.access.mail.mud.yahoo.com with NNFMP; 08 Nov 2011 14:36:18 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 977879.12979.bm@omp1017.access.mail.mud.yahoo.com
Received: (qmail 36357 invoked by uid 60001); 8 Nov 2011 14:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1320762978; bh=g02FFwYnMW0DhH31GYFlpECj0ElMg6t2ScK7X5SGH3k=; h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=6SigfHfZz83TFp/+/Y9F1Hy4dcQ6brh4+PK9hhECIbUqXhdGJtOuKnA3zCO1DHUB8Z5qDWmyzf1EQXaMniPjH9c8phj3oGWJiPKswBya9JYHSMPxGunLgqcVt7lUNxEoa2v688A1KSlUf9Y/h4gR+6lEGScSav0JT7mRl1mgqoc=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wylSCx+n5PW+RNRyeSRKWJREr2GXXb9ViSc2MERuY5HXN0pDv2oO0EFswvKEKaAafL2FNtPX2gZr0PybHu3JOV2PAJ2OR7OpPnW2sFGdwpQ3PkZ4VHDgmp5gdhTAiIrQo5NgxeQuzesQ+h2uUkXfT0MpLuCZiBLZjlq6E/CObiQ=;
X-YMail-OSG: d4GtVCQVM1mQSZaEuBA8_uolW3X4CUoNo0lW72Z5pyZVnM_
 7v09LLPiz.E15YnFbVEYsjkSFOB.X5RfJ5qSAD3577yTOGV2r9PTYk_o_BPD
 OmpYd0P2uZEodaJIlwVhduU7S4wwHKPwBiJh6u5RzoHesQD6BDCmkXlgRT2i
 15yXMpKSM_W93ie4tIcA5EmPkF1rDpda1t7EAcNXChfX0l3QtDUYQMaI6n1s
 3WG59NDKPs7TQv3XiAEUG8DrcChyyo_df3lZL3xKgzFqVlbg9kmJMjLQVKZI
 zoSBb784tOAOQBeHP.7OyADGKeWVuv12WtlC7wlPYmlxA8NFAGHmL.kssiuk
 qESnvll1dhdaF8F_EG7O3kvXakeDqu1PPOFli8RUv5eWQgenQ9Jng61iHtHV
 xCBfA6VOYuKgymLcLh5yt3t1NGWMhnk7TrNAzWWqsP2gFuDKMRUr6qFF7Y5E
 XZxk869dtsA--
Received: from [38.97.100.54] by web84005.mail.mud.yahoo.com via HTTP; Tue, 08 Nov 2011 06:36:18 PST
X-Mailer: YahooMailWebService/0.8.115.325013
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185088>



Hi,

=A0 I am new to the list so please let me know if I need to take this q=
uestion somewhere else.

=A0 I am seeing a bug with git log --quiet. It=A0doesn't=A0seem to be q=
uiet :-). Also I have seen cases where the exit status returned is not =
correct i.e. its 0 even if there is some output (although I cant seem t=
o reproduce that problem at present).

--------------------------------------------------
[~/Work/ws/tools-common] git --version
git version 1.7.0.4

$ git log origin..HEAD=A0
commit 632ff3eed4004ad76b7cd253643c66ce0f9223f1
Author: XXX
Date: =A0 Tue Nov 8 09:30:31 2011 -0500

=A0 =A0 test
$ git log origin..HEAD --quiet
commit 632ff3eed4004ad76b7cd253643c66ce0f9223f1
Author: XXX
Date: =A0 Tue Nov 8 09:30:31 2011 -0500

=A0 =A0 test
[~/Work/ws/tools-common] echo $?
1
--------------------------------------------------


thanks
-prasad
