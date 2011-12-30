From: bill lam <cbill.lam@gmail.com>
Subject: permissin of /usr/share/locale changed after make install
Date: Fri, 30 Dec 2011 08:09:49 +0800
Message-ID: <20111230000948.GE2868@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 01:10:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgQ33-00074l-Ln
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 01:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab1L3AKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 19:10:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59501 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754826Ab1L3AKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 19:10:07 -0500
Received: by iaeh11 with SMTP id h11so24389092iae.19
        for <git@vger.kernel.org>; Thu, 29 Dec 2011 16:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=/eKoI2gpylfiRLf0J5/El9izMlP8D7GYH/jOe3teH1o=;
        b=CM4LDQTr67rjdxOpn+plS0QjQDR4BFEx4hWhHiUXQ7vXHEGF6y8J1q0yQE8v17bNaY
         7Gzo6WYCJ/jIQJbIZjfMC7xut8wSJ1N2PCtPl95N8hIq7z2TPbfz0pwlmGF4yH3ufdau
         cg5ozopXc5XzUx/ZVu7aQMQ3LfO9ONYPenl+o=
Received: by 10.43.47.135 with SMTP id us7mr39005042icb.31.1325203805928;
        Thu, 29 Dec 2011 16:10:05 -0800 (PST)
Received: from localhost (n11649101176.netvigator.com. [116.49.101.176])
        by mx.google.com with ESMTPS id aq5sm82126658igc.5.2011.12.29.16.09.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Dec 2011 16:10:04 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187789>

In recent git versions (git version 1.7.8.2.302.g17b4), I found that the
permission of /usr/share/locale was changed to drwxr-x---  after
"sudo make install" in my debian.  I (non-root) use umask 027 if that matters.

Thanks!
-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
