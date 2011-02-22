From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 22/73] gettextize: git-checkout describe_detached_head messages
Date: Tue, 22 Feb 2011 23:41:41 +0000
Message-ID: <1298418152-27789-23-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wv-0001H8-P6
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab1BVXq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:58 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab1BVXny (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:54 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=n+ydgjlbu97d+7pZAf2dh3TXTrbyDyLhi5QzgXGyiI4=;
        b=C8ovIPj+UjYSjSmWmbaq7Zn3lG+v6OKeA79mjSq8Fpe9MXP5DH1RSgRuY4BEfECmPG
         AQsh5diAb1POxGVtx7ZFuci1j87kXgvSA0UwtmFelXpfS09pctKJoFYk9PyQwZvxc94W
         N075t73lO96labDdT2DiDHTNZ+F4xO7qDR+ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=G3fYnwmM/aJYDGfw2MDpAUiLwDFBG0l1SbmEfJ0AyVe6IpPj7vQfggotEKDottYw22
         MCxwBpg+EmUEdef42adAGSVdHTfpqKlV/hBnYBdSSYFLBFGplUdapbTaLiHuMsoJ6qLz
         yH/yX8URVTQuzld6p4XAcDPJmweji6jpseOo8=
Received: by 10.204.129.83 with SMTP id n19mr3051881bks.207.1298418233034;
        Tue, 22 Feb 2011 15:43:53 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.52
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:52 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167657>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7ba0788..698ac63 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -613,7 +613,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 	 * to remind the user that it might be lost.
 	 */
 	if (!opts->quiet && !old.path && old.commit && new->commit !=3D old.c=
ommit)
-		describe_detached_head("Previous HEAD position was", old.commit);
+		describe_detached_head(_("Previous HEAD position was"), old.commit);
=20
 	update_refs_for_switch(opts, &old, new);
=20
--=20
1.7.2.3
