From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 0/4] Miscellaneous Improvements
Date: Wed, 30 Mar 2011 16:13:18 +0000
Message-ID: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
References: <ca8eabbf-ed1b-4b46-a7f7-4b068a2de5b7-mfwitten@gmail.com>
            <5bddd028-bf38-46b9-a189-bdb09038dfdd-mfwitten@gmail.com>
            <a59d19d0-f279-43fe-8ac6-06c4bd13c941-mfwitten@gmail.com>
            <d92be3a1-6f30-4b04-ac38-39058e5a6959-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:02:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4yms-0001L3-16
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 19:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932971Ab1C3RCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 13:02:14 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:40054 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932933Ab1C3RCK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 13:02:10 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so298886pxi.10
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:references;
        bh=I/g9j97vppPjkWwvM/Tb4X2QpI/LT3yKLxCALNsZPJI=;
        b=lmGMb53UnnJ0Ko0t6YGSkgU30vaOk5M2VUcsgqrKJfjLi8gcneZW6Nec5hxNGxsVRq
         vZcUyJajufy3/sH9tEWR51tm4YLqEF3Rm+I1Eundp0YBpv8coT6BNt2m++OkslWh7nIo
         KQuagBournsURFHTAK3lfs99qCIfZ9I32Rlws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:references;
        b=qMM1oeAhZQnBbXasN0vVQTtLiSrwX7RjmUXHlMLiiNxL9LbCSHiHIogi8UYCnkcw2a
         XSvf9E6D3LD6uqa2PnVNoYYhT0TK88i2X3insIBXAFhYGY9lHTgJ5cM8bPLRnf630SQc
         xYIfqFjZ9GuIJD3wyPo9T7Ce+CZR/1GWFaNk4=
Received: by 10.142.148.16 with SMTP id v16mr1086718wfd.447.1301504529966;
        Wed, 30 Mar 2011 10:02:09 -0700 (PDT)
Received: from gmail.com (u199-48-147-004.appliedops.net [199.48.147.4])
        by mx.google.com with ESMTPS id m10sm306990wfl.23.2011.03.30.10.02.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 10:02:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170391>

Michael Witten (4):
  Typos: t/README
  Clean: Remove superfluous strbuf 'docs'
  Clean: Remove unnecessary `\' (line continuation)
  Clean: Remove useless parameters from both get_commit_info() functions

 builtin/blame.c     |   14 ++++----------
 reflog-walk.c       |   18 ++++--------------
 strbuf.h            |   37 +------------------------------------
 t/README            |   11 +++++------
 t/t8001-annotate.sh |    2 +-
 5 files changed, 15 insertions(+), 67 deletions(-)

-- 
1.7.4.18.g68fe8
