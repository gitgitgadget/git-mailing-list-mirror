From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/17] Documentation: remove backslash before ~ in
 fast-import manual
Date: Fri, 20 Aug 2010 05:34:29 -0500
Message-ID: <20100820103429.GK10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOxN-0004dW-3f
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab0HTKgN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:36:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58220 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab0HTKgL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:36:11 -0400
Received: by iwn5 with SMTP id 5so688459iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=7Bzk++vHCAeKL5V1FiBEPt2yg1FYn26vUFY5qmcS/Ek=;
        b=gUZ4wfxJy2V6CGaElo1P+RS3/8ife5BXAZZRBYkN32908ui+gm/1UKElVfUlMhx5mZ
         xnmU6ATZHH7Va1odrHWrAGzySwl7ubNxne1hcLJgCrLBmB1Vpx9OVQg4B6WUjPqbYe6+
         UG2RzOTimaEIwWv1Bu944db76NjKAXWTAKDko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=QjVL99Xj3ZAvIQNhkdr6JjI4L8/pzOMrDMg9dP2MAAzVWZ2F05F5dKFB7F5U1Gnw0p
         f4rLoFxwbvZoGNmLTJJOLdITANJ/tf4wxbDTyiX/JeRi1SaUBH681rXtjqbq8eapEbHx
         Wgslmf8piKEBsUXd0Q+X0I6G57q2mbP0af1ys=
Received: by 10.231.34.139 with SMTP id l11mr85611ibd.141.1282300570193;
        Fri, 20 Aug 2010 03:36:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm2500305ibh.10.2010.08.20.03.36.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:36:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154006>

Use the {tilde} entity to get a literal tilde without fuss.
With \~, asciidoc 8.5.2 (and probably earlier versions) keeps the
backslash in the output.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-export.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast=
-export.txt
index 98ec6b5..cbc31c1 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -93,7 +93,7 @@ marks the same across runs.
 [git-rev-list-args...]::
        A list of arguments, acceptable to 'git rev-parse' and
        'git rev-list', that specifies the specific objects and referen=
ces
-       to export.  For example, `master\~10..master` causes the
+       to export.  For example, `master{tilde}10..master` causes the
        current master reference to be exported along with all objects
        added since its 10th ancestor commit.
=20
--=20
1.7.2.2.536.g42dab.dirty
