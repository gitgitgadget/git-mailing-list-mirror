From: Hin-Tak Leung <htl10@users.sourceforge.net>
Subject: differences between old clone and new  Re: git-svn performance
Date: Tue, 28 Oct 2014 05:40:07 +0000
Message-ID: <1414474807.30075.YahooMailBasic@web172303.mail.ir2.yahoo.com>
References: <1414452388.89217.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Reply-To: htl10@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Tue Oct 28 06:40:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XizVz-00026l-Ck
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 06:40:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756452AbaJ1FkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2014 01:40:12 -0400
Received: from nm4-vm8.bullet.mail.ir2.yahoo.com ([212.82.96.106]:49335 "EHLO
	nm4-vm8.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751461AbaJ1FkJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 01:40:09 -0400
Received: from [212.82.98.49] by nm4.bullet.mail.ir2.yahoo.com with NNFMP; 28 Oct 2014 05:40:07 -0000
Received: from [212.82.98.83] by tm2.bullet.mail.ir2.yahoo.com with NNFMP; 28 Oct 2014 05:40:07 -0000
Received: from [127.0.0.1] by omp1020.mail.ir2.yahoo.com with NNFMP; 28 Oct 2014 05:40:07 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 532663.76127.bm@omp1020.mail.ir2.yahoo.com
Received: (qmail 54467 invoked by uid 60001); 28 Oct 2014 05:40:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1414474807; bh=AeFOd3s9KX77ManLTnZnQlSz3mo3uGxxfHfv3xSbMEg=; h=Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=MuCLA5bRI6vM1gksVoVJqFZPrhws/mJTh9rc9YLGRF5lj81IF8T/cv2rBkWXYBa3HAmmuM3H+Gpo7DTCGgEMReRty1IPfNHQFJlWWs3kQP3ly6ouVynYBkmpb/Q/VhCSxvi0mWXozogg/xLltfRdbY4FWeGOyweNoc1xLF3WIWg=
X-YMail-OSG: mOOhECYVM1n.XaFTZDfnmY9ZV7FQKn1ccExoQECV9YL79Uy
 bXi5rHgP1ZUc0MhqmF7Fjk4y42yK0GwImNvWoNdaSeqbHxtxblYP.7AYnEY1
 uqNHSNBk.H3ijmFx.Bm9_PFnq_sKKknnTr8HYa5lJ3RpEBZ5Rffdh16BYLrW
 Xfomuhytb1UN3h9b_sMZbK.cicoh5CSzc.qpfxzPCX5zJfArwiM4Wc2ezW58
 MStjWD_3R7aBXkR0Db3wSOth7sU7WqaFCYWR_GmYVC8wSY314HRLJ_fRN_Uq
 y2AnKHZE5NYmF9CzBOqJMcAZdbyhisj9M8u7oPgMbA.MLt4V6pkwJbErRBxG
 TIdmfbUdtSdUR.OLQlM8MCIT3.CD0nNR8xWwB9QB5A6bOzCjYIQX6K5nXfYT
 hUrSTWmSujX0j9t_hl.arxODYKZvGJ0XPmh5y236hQ7XMhoxwdzmvIOhpi8D
 4_m4IPnU4CyxkewMHu65rCJn3..U0Vj43xcCpFbr_6wi7ya1iFV9xn8DpJoX
 ziqUqUvXCMgVFvp8awlECFtgWYHIw1cXFahbhmmipaT3TxG7t1p1_a97sBKS
 E2A--
Received: from [86.30.137.134] by web172303.mail.ir2.yahoo.com via HTTP; Tue, 28 Oct 2014 05:40:07 GMT
X-Rocket-MIMEInfo: 002.001,VG8gY29tcGFyZSB0aGUgb2xkIGNsb25lIHdpdGggdGhlIG5ldywgSSBkaWQ6DQoNCmdpdCBicmFuY2ggLXIgfCBzb3J0IHwgeGFyZ3MgLW4gMSBnaXQgbG9nIC0tZGVjb3JhdGU9ZnVsbCAtbiAxDQoNCkl0IHR1cm5lZCBvdXQgb3RoZXIgdGhhbiB0aGUgZW1wdHkgdnMgMyB3b3JkIGNvbW1pdCBtZXNzYWdlcw0KYWJvdXQgdHdvIHllYXJzIGFnbyBvbiB0cnVuayAod2hpY2ggYXJlIGluaGVyaXRlZCBpbiBhbGwgdGhlIG5ld2VyDQpicmFuY2hlcyksIHRoZXJlIGFyZSB0d28gb3RoZXIgZ3JvdXBzIG9mIGRpZmYBMAEBAQE-
X-RocketYMMF: hintak_leung
X-Mailer: YahooMailClassic/810 YahooMailWebService/0.8.203.733
In-Reply-To: <1414452388.89217.YahooMailBasic@web172306.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To compare the old clone with the new, I did:

git branch -r | sort | xargs -n 1 git log --decorate=full -n 1

It turned out other than the empty vs 3 word commit messages
about two years ago on trunk (which are inherited in all the newer
branches), there are two other groups of differences.

One branch on the old clone has an extra merge from trunk (
and some extra trunk commits) listed in 'git log', while
another branch has the exact opposite - on the old clone
has one fewer merge.

I see the merge seem to be genuine - the subversion log
often says so e.g. "ported from rXXX from trunk", but
the extra/missing pattern isn't consistent.

So the histories are largely the same, except due to the 
extra merge, don't have the same sha1 sums.
