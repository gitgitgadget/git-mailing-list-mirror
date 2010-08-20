From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/17] Documentation: remove stray backslash from "git
 bundle" manual
Date: Fri, 20 Aug 2010 05:33:48 -0500
Message-ID: <20100820103348.GJ10407@burratino>
References: <20100820101902.GA10356@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	"David J. Mellor" <dmellor@whistlingcat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 20 12:35:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmOwh-0004By-GW
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 12:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab0HTKfb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 06:35:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40702 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab0HTKf3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 06:35:29 -0400
Received: by iwn5 with SMTP id 5so687857iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sAnCNNpa5Xd6+ch6muxN7G8Ha8AKRjI/Fy57MWTfuW0=;
        b=oSNHA/3VmER/fXkpx1rs2zgmFaVRJgemWrKhO2wNydppcXfvTJ7MdCQMZi3zKg/Vay
         UUsB3PbELMdplo5SutEViEVyMI6y3sR7itYnYOFbt0B+m5sxbTsIc1RpfwBK6LzNUIAd
         H2UV74CkifwdBAisHoGdxHpDTgAfuhP9mN21o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vkayLNQEKlhoYqhKYt7CMA4yb/nMmvNfF8R8PsBCOhhxsF1nqKtwZIw/tABBsFHgdE
         SBA961kTLMXg+ItIJCmjZrBoOZEcgTuwSnkrU/1TkIsM+d9FP+l9hfnfa271vHWbcsft
         gWGyjBMgKi8QRtgnMdSLKUbZkGqkfbSD4DDSg=
Received: by 10.231.153.5 with SMTP id i5mr1414866ibw.105.1282300529116;
        Fri, 20 Aug 2010 03:35:29 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm2496948ibk.21.2010.08.20.03.35.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 03:35:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820101902.GA10356@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154005>

In v1.6.2.2~6^2~4 (Documentation: minor grammatical fixes
and rewording in git-bundle.txt, 2009-03-22), backslashes were
introduced before ~ to avoid introducing unintentional
superscripts.  In one paragraph there is only one ~, though,
making that not a candidate for quoting, and asciidoc 8.5.8
passes the backslash through so the man page says "\~10..master".

Maybe there is an asciidoc behavior change involved.

In any case, we should replace tildes with a {tilde} entity which
means the same thing regardless of where it is found.

Reported-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
Cc: David J. Mellor <dmellor@whistlingcat.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-bundle.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.tx=
t
index a5ed8fb..f0b75c7 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -60,7 +60,7 @@ unbundle <file>::
 [git-rev-list-args...]::
        A list of arguments, acceptable to 'git rev-parse' and
        'git rev-list', that specifies the specific objects and referen=
ces
-       to transport.  For example, `master\~10..master` causes the
+       to transport.  For example, `master~10..master` causes the
        current master reference to be packaged along with all objects
        added since its 10th ancestor commit.  There is no explicit
        limit to the number of references and objects that may be
@@ -79,12 +79,12 @@ SPECIFYING REFERENCES
=20
 'git bundle' will only package references that are shown by
 'git show-ref': this includes heads, tags, and remote heads.  Referenc=
es
-such as `master\~1` cannot be packaged, but are perfectly suitable for
+such as `master{tilde}1` cannot be packaged, but are perfectly suitabl=
e for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
 contained in the union of the given bases.  Each basis can be
-specified explicitly (e.g. `^master\~10`), or implicitly (e.g.
-`master\~10..master`, `--since=3D10.days.ago master`).
+specified explicitly (e.g. `^master{tilde}10`), or implicitly (e.g.
+`master{tilde}10..master`, `--since=3D10.days.ago master`).
=20
 It is very important that the basis used be held by the destination.
 It is okay to err on the side of caution, causing the bundle file
--=20
1.7.2.2.536.g42dab.dirty
