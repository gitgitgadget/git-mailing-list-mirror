From: bill lam <cbill.lam@gmail.com>
Subject: how to suppress progress percentage in git-push
Date: Sun, 22 Nov 2009 22:53:53 +0800
Message-ID: <20091122145352.GA3941@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 22 15:54:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCDpP-0002WY-1X
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 15:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754580AbZKVOyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 09:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754317AbZKVOx7
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 09:53:59 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:65203 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150AbZKVOx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 09:53:59 -0500
Received: by pwi3 with SMTP id 3so2950677pwi.21
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 06:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=28mvCTE3X+fStNpfxQ9zr0cLuXx/2OeuYK9rvpgr1HA=;
        b=fczg4ODpkdHDvboUxBo7rHorP/uuND3B3LPVxshP+0LXS2qQ2YR1YfByeLd4q1Vj4C
         s/S7wLd7yU7vyvZSDrWPRyx3BaqYV5Zcv6UzIwNEdKU0dCOMg9uQkcwwx7Ctvs0qy8+2
         P9UERyASzrKWrEhUi/hsdsM4MJisX6jQAJtkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=Yiv921CgFOl5UrZCTidJXchZMupAtR3tFASf+tN4wWBF+bB3fngQin5i5l/w2m8GDY
         bNxKnchVs9qeFZDX/AxevdNFm9afkhzRaZ1BR8A2ALCKiYQEmIPl73KSU6WGbVkgxIpy
         26CZJEOObbSFjNad+iQ+jxClxiEjxeQhFpWRA=
Received: by 10.115.80.14 with SMTP id h14mr6269442wal.133.1258901644882;
        Sun, 22 Nov 2009 06:54:04 -0800 (PST)
Received: from localhost (pcd406002.netvigator.com [203.218.196.2])
        by mx.google.com with ESMTPS id 20sm444960pxi.7.2009.11.22.06.54.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Nov 2009 06:54:04 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133433>

I set crontab to push to another computer for backup. It sent
confirmation email after finished.  It looked like

Counting objects: 1
Counting objects: 9, done.
Delta compression using up to 2 threads.
Compressing objects:  20% (1/5)
Compressing objects:  40% (2/5)
Compressing objects:  60% (3/5)
Compressing objects:  80% (4/5)
Compressing objects: 100% (5/5)
Compressing objects: 100% (5/5), done.
Writing objects:  20% (1/5)
Writing objects:  40% (2/5)
Writing objects:  60% (3/5)
Writing objects:  80% (4/5)
Writing objects: 100% (5/5)
Writing objects: 100% (5/5), 549 bytes, done.
Total 5 (delta 3), reused 0 (delta 0)

Often the list of progress % can be a page long.  I want output but
not those percentage progress status.  Will that be possible?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
