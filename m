From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/2] http fixes
Date: Mon, 23 Nov 2009 11:03:47 +0800
Message-ID: <20091123110347.d47728f8.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Martin =?ISO-8859-1?Q?Storsj=F6?= <martin@martin.st>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 23 04:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCPLg-0001ni-IV
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 04:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbZKWDMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 22:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756157AbZKWDMI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 22:12:08 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:59863 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756155AbZKWDMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 22:12:07 -0500
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Nov 2009 22:12:07 EST
Received: by ywh12 with SMTP id 12so4802317ywh.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 19:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ZwqtCX8DOLLhSfdmzgAlcLuG6EY355mddmnNyeLzNJ4=;
        b=G0Xa/nEIN8TiHu0sBDTpzUdf5xVzYVMXuHggJqKi8dFVQf2PRW8bTp1hBJP87uJ/gj
         famaqBQBBggkbsvowQHls8cjcZOo1YgVDp8eKQhY2grIHC+DNvIbVJD1gMwbfxv6Yjc0
         EDQUvfsTJdOUMIwXjQbd94QQp7/c8u5z0wf1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=kEb6QPfxGmE4Uwy53WikDsamClbs1TeBqljPyn7st2GJaN8F5oxdrNB0lCYdcL4lJ8
         TxZ5YoeWi5GpEaCapaypQmN+J1UtvU+FI0Y9yt+absuHUObNCIjhVcqZ20YKFfHrhO+9
         XVTqTMbg8ZV6KShEUGrAdZNnVzw2p+3uwM1q4=
Received: by 10.151.94.35 with SMTP id w35mr7489125ybl.194.1258945434876;
        Sun, 22 Nov 2009 19:03:54 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 7sm1328111ywc.51.2009.11.22.19.03.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 19:03:54 -0800 (PST)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133478>

Patch 1 ("Do curl option disabling before enabling new options"):
  This is a workaround for a fairly recent curl issue that affected
  versions up to 7.19.4.

Patch 2 ("remote-curl.c: fix rpc_out()"):
  Fixes issues that affect chunked encoding.

 http-push.c   |    2 +-
 remote-curl.c |   19 ++++++++++++-------
 2 files changed, 13 insertions(+), 8 deletions(-)

--
Cheers,
Ray Chuan
