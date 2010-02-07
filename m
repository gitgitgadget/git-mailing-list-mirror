From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: Improve escaping
Date: Sun, 07 Feb 2010 21:47:50 +0100
Message-ID: <20100207204539.11146.36972.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 07 21:48:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeE3W-0001LY-Fx
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 21:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab0BGUsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 15:48:20 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:54976 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab0BGUsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 15:48:19 -0500
Received: by fxm3 with SMTP id 3so6723322fxm.39
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 12:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=vhw5dNrXdekgxX7uOw0cbobsmX9/RsQ5F8WcyP5Vmh0=;
        b=iGvHMrfcM9RNdqjn/ulaRsPw+K2NO5j9jjmBmtktndzH8wcnJZK8vKkIyWHQalPIyg
         05WRNeoPggCgTUGUT1LmCfyCPJVcde49Wnf2PEUqFv4AVcs3rmJBjNigQCUl8dGnmBP4
         Md7XLGJyLeuK8mu3awamHOQK+nvDbmRYIMyko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=pEmJICOhSXbld1jsqdRUQ1L8NiiWSzoKWvYZ6SwL1IIGtrpZsqP8cTJop4d1aJQPKH
         S8bqBbmQzDw7fz9EmQAyUcqDESAg0igIhwKi49XhxNBbku9BFCthV5btI+L4yoLWZ8NY
         oqz8eOlFsFQKO+SRL+TXUEHlrh6Z+M8NP4vCU=
Received: by 10.87.61.4 with SMTP id o4mr226205fgk.31.1265575697072;
        Sun, 07 Feb 2010 12:48:17 -0800 (PST)
Received: from localhost.localdomain (abvv164.neoplus.adsl.tpnet.pl [83.8.219.164])
        by mx.google.com with ESMTPS id 3sm8555449fge.11.2010.02.07.12.48.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Feb 2010 12:48:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o17KloAt011199
	for <git@vger.kernel.org>; Sun, 7 Feb 2010 21:48:01 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139253>

Those two patches are dependent on each other only because of single
change in second patch, showcasing the feature.
---
Jakub Narebski (2):
      gitweb: esc_html (short) error message in die_error
      gitweb: Protect escaping functions against calling on undef

 gitweb/gitweb.perl |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
Poland
