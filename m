From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Sat, 24 Oct 2009 12:44:47 +0300
Message-ID: <1256377489-16719-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 24 11:45:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1dBQ-0004ht-G6
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 11:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbZJXJo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 05:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbZJXJo7
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 05:44:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:64087 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbZJXJo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 05:44:58 -0400
Received: by fg-out-1718.google.com with SMTP id d23so532718fga.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2009 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=haL1U9YjrNQMjjUSOdZRV0/GuAl9Ba2JeOpKZ0jgL5o=;
        b=gp3hplrlnMyAv6VABBed6CAtKM3hpYRSFEKy7CXiYITmm//wdKIwmtDwWTYrAp8PQF
         ej071SzlxyQEZq758Jq+G1X6q0/TYsvXCibJU/T1UzLnoBht7cyuDtzTrW9Mp6A36RXu
         WjhhtutE3LUA+D1XaURx/n4XAwUsfXdnLrWik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=kTEn25LFkWilC9oXzuLeofc3Tg0GeL8f/5/sJbrVa7DoRYJRHDw2aQVXeRpKFAIUDk
         fXw2V03fBjZXtS2VZoXXcwD+nz9ph+xl4MVpfdf04JlgUC1pUBT5xo2zohF0x1nGYAv2
         Pxyy08hPboQfBVHSKmiophNPqmXqOCor1qdFs=
Received: by 10.86.192.34 with SMTP id p34mr6589122fgf.28.1256377502446;
        Sat, 24 Oct 2009 02:45:02 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 4sm4829682fge.4.2009.10.24.02.45.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Oct 2009 02:45:01 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131150>

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

v2:

Reworded the getting started section based on comments from Michael J Gruber,
Jonathan Nieder and Junio C Hamano.

Felipe Contreras (2):
  user-manual: add global config section
  user-manual: simplify the user configuration

 Documentation/user-manual.txt |   37 ++++++++++++++++++++++++++++++++-----
 1 files changed, 32 insertions(+), 5 deletions(-)
