From: =?utf-8?B?UGFwIEzDtHJpbmM=?= <paplorinc@yahoo.com>
Subject: Re: Parallel refactoring and git merge nightmare
Date: Thu, 12 Apr 2012 06:52:48 -0700 (PDT)
Message-ID: <1334238768.18499.YahooMailNeo@web160601.mail.bf1.yahoo.com>
References: <1334160803.74554.YahooMailNeo@web160603.mail.bf1.yahoo.com> <CAJDDKr6v6uPLoAQ96fP7JM5F0_WHqfbaD=QKyfrWPWd2St7tKQ@mail.gmail.com> <1334208237.82681.YahooMailNeo@web160606.mail.bf1.yahoo.com> <CAFfmPPMbr-db+OnTwK-ry+wGQSEeunsD+QrmAVS2fzDH+hGnbg@mail.gmail.com>
Reply-To: =?utf-8?B?UGFwIEzDtHJpbmM=?= <paplorinc@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 15:52:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIKSE-0001wR-LY
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 15:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933741Ab2DLNwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 09:52:50 -0400
Received: from nm25-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.156]:34893 "HELO
	nm25-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756656Ab2DLNwt convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 09:52:49 -0400
Received: from [98.139.214.32] by nm25.bullet.mail.bf1.yahoo.com with NNFMP; 12 Apr 2012 13:52:48 -0000
Received: from [98.139.212.239] by tm15.bullet.mail.bf1.yahoo.com with NNFMP; 12 Apr 2012 13:52:48 -0000
Received: from [127.0.0.1] by omp1048.mail.bf1.yahoo.com with NNFMP; 12 Apr 2012 13:52:48 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 278382.81466.bm@omp1048.mail.bf1.yahoo.com
Received: (qmail 44872 invoked by uid 60001); 12 Apr 2012 13:52:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1334238768; bh=AXp7ePvaJvpDpJtQPIBSFxzkKjqQogTyf1k9RjialAA=; h=X-YMail-OSG:Received:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding; b=4ucA3/58/htAAiV9A8/uZx4wH20IYwl4PpqYBiO3SWJnRHCGn6PWpbRD2nADGAgixe9jKIzzXHtLja/HepPzXbGRJMFKQVBkh0y1rzTPaxPUeqn24KRYl3Z4s2iU4nS6pEES6qrfy5F00o7b9X+Qt+Rc6EL/G/BOzoIuMI8a5C8=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=u7ocCuYGsdo8IysrGX17kUAlQXb/uSTZA6a+I+I18l1+iF7Jr98UupRccLoVqzUb2R5rvLMGzp2VVQ725kAxKwaFzqaW6X3TzSJ5B+YgZiHTU2QzI7P23nJk35TPlSVJibrgTwKYbYVm5IYXhr120+OOXpXJ1gW1o/BC0hdZW1g=;
X-YMail-OSG: tK1XRYoVM1mFtRL8cjGWpMD2IeTcbbLdRIgoZ_QaE.yuGVN
 KJhutUi4xCanYM8Yk4Frz4gZlKJN6nIIWjqPA_If437iSZ9cCg66.J_LlvcI
 uY.1vTV5Lo2wBveF8XHMvjccnp9RE7RhpIrlmCrzTOaOgK1bScoYVJlvQHeY
 beBA3qt19DwvMFHLUEaPTNjXv7cCy6sNbOGKY20D9D_sTTrUcRI4una0T4M0
 0.t38CdZu8wrX5DdQnBrdUFWhZicRb.erPQsWtIdF.KGj1H5xxVQLpVh.1R7
 u.n7Lxux1W9waTyAO14ZLFEcHLxhMEbsbQvb_SQ1xCSRaoIGDJ3w2BzYWXgc
 rs4yvK1bPxoGie8JD2_FqWlcEu7.tzNmVQja.iqG_FPdzK9A.8qqL1_TosxP
 xU6MCND7Gk3_8.H.YaZQgjDcgBHy6_m6eWqkGLpsJCHFuvYs5gs_IatsmcmV
 7MALer1eHqfbhPs68hFHstWI-
Received: from [82.79.70.220] by web160601.mail.bf1.yahoo.com via HTTP; Thu, 12 Apr 2012 06:52:48 PDT
X-Mailer: YahooMailWebService/0.8.117.340979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195328>

Thank you all for the answers! :)


I have already set the rename limit to 0, and upon committing and fetch=
ing the renames are calculated and found.


The commands are (I use tortoise git now, but tried the console and oth=
er GUIs, as I said in my first post) "git svn fetch" and "git merge rem=
oteBranch".
I figured now, that this was the problem, I should have used rebase ins=
tead of merge (I still don't understand why merge doesn't work, but reb=
ase and conflict resolution with a GUI (where I can resolve more files =
at once) seems acceptable). Thanks David! :)

L=C5=91rinc
