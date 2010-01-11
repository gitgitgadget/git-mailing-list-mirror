From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 1/6] Documentation: clarify one-line description for
 merge
Date: Mon, 11 Jan 2010 02:27:55 -0600
Message-ID: <20100111082755.GA23806@progeny.tock>
References: <cover.1263081032.git.trast@student.ethz.ch>
 <e330d8ca1a9ec38ce40b0f67123b1dd893f0b31c.1263081032.git.trast@student.ethz.ch>
 <20100110044949.GA8974@progeny.tock>
 <7vskaefp2v.fsf@alter.siamese.dyndns.org>
 <20100111021322.GA8480@progeny.tock>
 <7vzl4lbcfl.fsf@alter.siamese.dyndns.org>
 <20100111041318.GA9806@progeny.tock>
 <20100111082123.GA23742@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 09:28:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUFd2-00084y-I2
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 09:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab0AKI15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 03:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364Ab0AKI14
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 03:27:56 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:64536 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296Ab0AKI14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 03:27:56 -0500
Received: by iwn32 with SMTP id 32so4477218iwn.33
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 00:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PujLqAzChqsewNVO/m1BJiVCu5GKOlMinHHGlevBlbQ=;
        b=lWZvevM6gUs0QHdQ+XJMOIjFA5vMmc5cZT7fw1oUX+tQ/HB1S5egvq9C8rNtCZlPGX
         ZTkx92pR39QuO8aZvhnrwoIQ1OfMaju7L130klk5d//s5MlIaPIp4KVsJJzcnOSklouB
         ZjM76ItKZdpP+xi+FZxmcj4/jBivuPOM4OPUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=I6RRuFYr/dVuDZvhOn+aiAv/5DH5MnRq305qd2+bEtF0mzThR31700gmz/uLzYrlHM
         QdRR8ZE0omaA21Gg2xoSr/Nb78S9B3RipRGqZAHzoWmU5TfdNR5inEbqU5822g7S7hPX
         GBuOSHsVcPUqCfiWfdGesNYHKOEThMxyfa1zQ=
Received: by 10.231.25.199 with SMTP id a7mr2455934ibc.51.1263198475500;
        Mon, 11 Jan 2010 00:27:55 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm4625221iwn.1.2010.01.11.00.27.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 00:27:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100111082123.GA23742@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136618>

The 'git merge' command is generally not used to tie completely
independent projects together (though it can be used to do that)
but to reconcile branches of development that may have diverged.
Try to make this clearer in its one-line description.

Cc: Petr Baudis <pasky@suse.cz>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I am not sure this is an improvement at all.  Mostly I wanted to
convey the idea of code forks being reconciled, but the resulting
phrase is not nearly as nice.

 Documentation/git-merge.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e886c2e..394ad0a 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -3,8 +3,7 @@ git-merge(1)
 
 NAME
 ----
-git-merge - Join two or more development histories together
-
+git-merge - Re-join diverging branches of development
 
 SYNOPSIS
 --------
-- 
1.6.6
