From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] cat-file: add --batch-all-objects option
Date: Fri, 26 Jun 2015 11:48:22 -0400
Message-ID: <20150626154822.GA30273@peff.net>
References: <20150622103321.GB12584@peff.net>
 <20150622104559.GG14475@peff.net>
 <CAPig+cT-VC7eQgLec+ATux76GHdRBVwG9BqcR9QiqXntf+s4eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <charles@hashpling.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 17:48:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Vrw-0007vZ-Gh
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 17:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbbFZPse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 11:48:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:52281 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751379AbbFZPsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 11:48:25 -0400
Received: (qmail 12412 invoked by uid 102); 26 Jun 2015 15:48:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 10:48:24 -0500
Received: (qmail 17681 invoked by uid 107); 26 Jun 2015 15:48:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 11:48:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jun 2015 11:48:22 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cT-VC7eQgLec+ATux76GHdRBVwG9BqcR9QiqXntf+s4eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272783>

On Fri, Jun 26, 2015 at 02:56:58AM -0400, Eric Sunshine wrote:

> > +test_expect_success 'cat-file --batch-all-objects shows all objects' '
> > +       # make new repos so we now the full set of objects; we will
> 
> s/now/know/

Yeah. I don't think this series otherwise needs re-rolled. Here it is in
an autosquash-able form:

-- >8 --
Subject: [PATCH] fixup! cat-file: add --batch-all-objects option

---
 t/t1006-cat-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 18dbdc8..4f38078 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -548,7 +548,7 @@ test_expect_success 'git cat-file --batch --follow-symlink returns correct sha a
 '
 
 test_expect_success 'cat-file --batch-all-objects shows all objects' '
-	# make new repos so we now the full set of objects; we will
+	# make new repos so we know the full set of objects; we will
 	# also make sure that there are some packed and some loose
 	# objects, some referenced and some not, and that there are
 	# some available only via alternates.
-- 
2.5.0.rc0.336.g8460790
