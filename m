From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 0/3] Alternates API
Date: Wed, 30 Mar 2011 21:40:43 +0000
Message-ID: <cover.1301521243.git.mfwitten@gmail.com>
References: <7vlizwmm4o.fsf@alter.siamese.dyndns.org>
            <5ed7886ec5e12c8e3a5f45d19625a4f5d2cdd38a.1301521243.git.mfwitten@gmail.com>
            <a0e5204fe8c03b3b6af2150198bad51f86b126c4.1301521243.git.mfwitten@gmail.com>
            <3c357acd119aa836f6cd3298d62cc5098f4c053c.1301521244.git.mfwitten@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 00:20:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q53k8-0007Xu-EG
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 00:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933061Ab1C3WTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 18:19:54 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35130 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933018Ab1C3WTx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 18:19:53 -0400
Received: by pwi15 with SMTP id 15so289824pwi.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:references;
        bh=XtvFssh2MsR3gIVHaKzIp1Qxq+l1m81C3gZ6xl8MdYw=;
        b=GMGmjYVyjczNwOIyjgBwNhhMoH8rT83rllJMhjFToLe7VKbYUwUcL47CBaAcCmR5Si
         LAdJyPvvF3LkmaA/xzTXTdTD574sap7jcqpLn4MDfAaIVwueA3SAWS2B3uR3WfJC4wYX
         PlEUjp6+K6wrRx1WcWJ1JMhDFqHjuKqef52JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:references;
        b=aVMVYcp15/oZ0C+Gio7ttaRgYxDmHj49g8J7CtUAszhiHAyoNeZumhep1vEeXuM1R2
         9z1ULyVcovSQo9spSXPy0PLc8BTdgtKRK2ObGmQktuBlErsJ4lrnOflfS0OyDzj4LfcS
         pwYdp17nSn1wnpgHHXasrjJp/d4t8Ob3hPQBA=
Received: by 10.142.211.17 with SMTP id j17mr1394896wfg.86.1301523592192;
        Wed, 30 Mar 2011 15:19:52 -0700 (PDT)
Received: from gmail.com (raskin.torservers.net [74.120.15.150])
        by mx.google.com with ESMTPS id s41sm616786wfc.15.2011.03.30.15.19.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 15:19:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170427>

Michael Witten (3):
  Alternates API: Untangle the interface
  Alternates API: Improve naming
  Alternates API: Remove unused parameter

 builtin/fetch-pack.c   |    9 +++++++--
 builtin/receive-pack.c |    9 +++++++--
 cache.h                |    4 ++--
 sha1_file.c            |    8 ++++----
 transport.c            |   11 +++++------
 transport.h            |    4 ++--
 6 files changed, 27 insertions(+), 18 deletions(-)

-- 
1.7.4.18.g68fe8
