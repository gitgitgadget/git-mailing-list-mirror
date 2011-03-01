From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/POC 0/2] grep --full-tree
Date: Tue,  1 Mar 2011 10:53:28 +0100
Message-ID: <cover.1298972832.git.git@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 10:57:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuMKD-00055t-41
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105Ab1CAJ44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 04:56:56 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54908 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754461Ab1CAJ4z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 04:56:55 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5A909206EC;
	Tue,  1 Mar 2011 04:56:55 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 01 Mar 2011 04:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=BBXtQu8rbU5QPnhWAhnvmWLwJiA=; b=XrYP2PXa2F6kvQYzFKjsRuxF4h41OwzQgg71VlIrqdEJsXmQgmOjNCZOE2OGd/Clprz0Lfnq42KvN90eQgM/IR9ZaJQFV3IsljSc4zbQDpyGDcrLRn/jyrRXk1sFacm+o1Q04tUtVmUSn7b17zIVXdrQdmxJV9JNlrnvCMY67xc=
X-Sasl-enc: 1Q10z4ZRKGrEmju0wl6H54F3SkPxKzBBihtrVaEYLu6m 1298973414
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D20A44413B8;
	Tue,  1 Mar 2011 04:56:54 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.257.gb09fa
In-Reply-To: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168204>

I think we could make --full-tree useful with pathspecs like below. There are
no tests yet and no doc because I actually favour a pathspec based solution,
and that would possibly lead to mixed pathspecs (relative+absolute),
interacting badly with an overall option.

But I have to look at the pathspec stuff first. Or maybe at format-patch, if I
interpret the latest What's Cooking correctly...

Junio C Hamano (1):
  grep: --full-tree

Michael J Gruber (1):
  grep: make --full-tree work with pathspecs

 builtin/grep.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

-- 
1.7.4.1.257.gb09fa
