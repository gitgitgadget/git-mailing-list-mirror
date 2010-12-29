From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/4] git-instaweb: Three fixes and one improvement
Date: Wed, 29 Dec 2010 17:43:40 +0100
Message-ID: <201012291743.41213.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tadeusz Sosnierz <tadzikes@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 17:50:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXzEW-0004pD-88
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 17:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab0L2Qub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 11:50:31 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab0L2Qua (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 11:50:30 -0500
Received: by bwz15 with SMTP id 15so11085534bwz.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=371ts3yoIFiPiL/EEeA17MBD3D+qaBwZbeF1JM1na94=;
        b=uD+0OQqB1zf/3Vm4b6L9E5QjwLKmu7iGRhm3hDxKtqFBBzKOrLyLkky6/kWxPrwerp
         wVqykW0uoMttfGiBOqf4xdW4b8iCFsCpW3GsiQZ9+QuysApuKmCuN5Z/W9tqJ4NXy73u
         0IsIJfu8fXDm6Qz/n3pr8b8oGqOZonXIjbEBI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-disposition
         :content-type:content-transfer-encoding:message-id;
        b=eat/rQjaffx9/U7PImUSFauzqlvlibMzXAO7puoucjzuqnluSUUQoveSMxEkVsKZCY
         h47Aj/tQ3MoRWDOVLgA2tYf1XZIffvfEXkwo75afS2HzfyystoRdnIhLDaPNOtO+f3q/
         dy2dv+mY60K8FYSA5tQswtr+VsoOMUYMN9obQ=
Received: by 10.204.75.142 with SMTP id y14mr12277206bkj.114.1293641429279;
        Wed, 29 Dec 2010 08:50:29 -0800 (PST)
Received: from [192.168.1.13] (abvs18.neoplus.adsl.tpnet.pl [83.8.216.18])
        by mx.google.com with ESMTPS id x38sm7505600bkj.13.2010.12.29.08.50.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 08:50:27 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164315>

Actually only the first patch is a proper bugfix for issue noticed by
Tadeusz So=C5=9Bnierz ('tadzik' on github, https://github.com/tadzik) i=
n
GitHub private message; second and third are hardening git-instaweb
against differences in configuration and environment.

Junio, could you at least apply the first one before 1.7.4?  This is a
fix for a real bug, if for not often used "git instaweb=20
--httpd=3Dplackup".

tadzik, does the first patch fixes the issue you noticed?

Jakub Narebski (4):
  git-instaweb: Fix issue with static files for 'plackup' server
  git-instaweb: Static files are under "static/" in gitweb_conf
  git-instaweb: Add checks that web server can be started and is
    started
  git-instaweb: Use "git-instaweb" as sitename (for page titles)

 git-instaweb.sh |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

--=20
Jakub Nar=C4=99bski
Poland
