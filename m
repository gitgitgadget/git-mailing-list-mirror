From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/2] user-manual: reorganize the configuration steps
Date: Sun, 11 Oct 2009 23:43:04 +0300
Message-ID: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 22:49:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5Lx-0001qp-DV
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 22:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbZJKUpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 16:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbZJKUpJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:45:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:27464 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZJKUpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 16:45:08 -0400
Received: by fg-out-1718.google.com with SMTP id 16so285175fgg.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=q7kpUrDU/h2v1j01KcLPTqObJo2XPlDGFkzJwVsnFsM=;
        b=AttsgDvCAdwp2d2Irun5d347BrmBK9tDweEv6o/EP3cLoLhyXUiALEcLPJSBkBOFhG
         oCjJlSaY+99a0s6J9uiwR7SdMsspu22FGWk4KgVCIQUlIm1FyJCWcqVPXwLjD568u7tK
         7f6mKtJ3doxVPw7qxpTFYFvyBF22k3YIDAEio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=B94ohI505hUIWpsfofFS9AiYQN+wFL3c3UOrWlFHbdh9amSxYHViiskoNnKcrVrbUm
         lNHHcWnuSMzDk+q4y3g2avsch8fAR6R2SlWg5kdakJq2oUHR8Yq131TyseO6s3UkI1o8
         mZ/ERzoym5svXrHqylR7FdXxi1iuartBph1Mk=
Received: by 10.86.159.37 with SMTP id h37mr1039691fge.79.1255293799279;
        Sun, 11 Oct 2009 13:43:19 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 12sm2561830fgg.11.2009.10.11.13.43.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 13:43:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.4.g31fc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129950>

This basically introduces the "getting started" section so users get familiar
with the configuration from the get-go, and also, most people prefer to teach
'git config --global' to setup the user name and email. Here are a few
examples:

git tutorial:
http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html

GNOME:
http://live.gnome.org/Git/Developers

SourceForge:
http://sourceforge.net/apps/trac/sourceforge/wiki/Git

github:
http://help.github.com/git-email-settings/

Felipe Contreras (2):
  user-manual: add global config section
  user-manual: simplify the user configuration

 Documentation/user-manual.txt |   35 ++++++++++++++++++++++++++++++-----
 1 files changed, 30 insertions(+), 5 deletions(-)
