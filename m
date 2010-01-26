From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/12] Makefile: remove wt-status.h from LIB_H
Date: Tue, 26 Jan 2010 09:46:16 -0600
Message-ID: <20100126154616.GD4895@progeny.tock>
References: <20100123144201.GA11903@progeny.tock>
 <7v3a1u6bfz.fsf@alter.siamese.dyndns.org>
 <20100126154357.GA4895@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 16:46:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZnct-0001Sa-MR
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 16:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550Ab0AZPqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 10:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546Ab0AZPqV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 10:46:21 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53998 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab0AZPqV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 10:46:21 -0500
Received: by yxe17 with SMTP id 17so3732834yxe.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 07:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tpIMPgkbgdJlZGn51VCMlS3AGKcVMn0RJuMXcL5h218=;
        b=cBT2irmVHZCaT7xk3ptM5TQk1pOqVTtpFNr+xUisZpeLm3H1Uk4XQ8YYytcTqo0/oO
         oNh/2ONIBHzfLctRY0cQri/RiihSl3dzDQShwEeTX5GkWqZVpAVH3KND5ahj6aOaLinh
         Wmf4UbOjWltPh3+S01o73yu8/dqVNURG1wVpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CrfqJwGXsgRu/HPZ68dmTU3sapU0r97ze7jVW/egCzHNPIHqAuNTGmYZQgH52Vl4PW
         nvhhONCQyn1ZbT9fM8O2637i9rkiupWFWpioOZl2oEE7IvAkwiAISG4nFqEa5RIQ1ZHp
         tUZ6sWWKW/k05miCc6bnuaCH3TsINVQEqi7OA=
Received: by 10.150.183.3 with SMTP id g3mr4149966ybf.224.1264520776526;
        Tue, 26 Jan 2010 07:46:16 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm6170907iwn.15.2010.01.26.07.46.13
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:46:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100126154357.GA4895@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138044>

A list of the few translation units using this header is
half-populated already.  Including the dependency on this header
twice (once explicitly, once through LIB_H) makes it difficult to
figure out where future headers should be added to the Makefile.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1670ee8..8cf6383 100644
--- a/Makefile
+++ b/Makefile
@@ -512,7 +512,6 @@ LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += userdiff.h
 LIB_H += utf8.h
-LIB_H += wt-status.h
 LIB_H += xdiff-interface.h
 LIB_H += xdiff/xdiff.h
 
@@ -1664,7 +1663,7 @@ builtin-clone.o builtin-fetch-pack.o transport.o: fetch-pack.h
 builtin-send-pack.o transport.o: send-pack.h
 builtin-log.o builtin-shortlog.o: shortlog.h
 builtin-prune.o builtin-reflog.o reachable.o: reachable.h
-builtin-revert.o wt-status.o: wt-status.h
+builtin-commit.o builtin-revert.o wt-status.o: wt-status.h
 builtin-tar-tree.o archive-tar.o: tar.h
 builtin-pack-objects.o: thread-utils.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
-- 
1.6.6
