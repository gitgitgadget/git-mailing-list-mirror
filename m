From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Simplify some gitweb URLs generation
Date: Thu,  1 Nov 2007 13:06:26 +0100
Message-ID: <1193918789-16421-2-git-send-email-jnareb@gmail.com>
References: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 13:04:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InYmj-0008UE-Ui
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 13:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755093AbXKAMED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 08:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755126AbXKAMED
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 08:04:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:35088 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbXKAMEA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 08:04:00 -0400
Received: by ug-out-1314.google.com with SMTP id z38so453888ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 05:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8H8LUSg4lRJi5K3D6XneeZTHGinJsNId/4653HUGGZU=;
        b=OgR7oZ7TG9Cd81fzMu4OUTzQvToYrA8GS6+H634rb0fMPJrUIBAP1gyV1YMu0riCDTiHMklBDfOiabzgXuXaoLOwmJBuPun2kFq10OmXhRJNDS6/jpzJKqgY6PpISH3UiyeeMx71eOf86yKfPHEnGPEFDHJdXwyINsME7E/+riA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tp4sPSVM8q0nmjEaT/TwsTCjP+YJ38GGXMMECW3rf2W+k16SL+nmBZaGgRPIkYmdNANA93uvCNKEWpDWtjHENow0P19Vt5kMZav2VHYtMDFZs09xU28ZnFdiRdU0o/asBIURJEsMn5PEewBhqKBZlB5WAvrxASrauCrB1/Th9VM=
Received: by 10.67.27.15 with SMTP id e15mr3192545ugj.1193918639340;
        Thu, 01 Nov 2007 05:03:59 -0700 (PDT)
Received: from roke.D-201 ( [83.8.199.125])
        by mx.google.com with ESMTPS id g30sm5756567ugd.2007.11.01.05.03.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 05:03:58 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA1C6V1w016530
	for <git@vger.kernel.org>; Thu, 1 Nov 2007 13:06:31 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA1C6Vak016529
	for git@vger.kernel.org; Thu, 1 Nov 2007 13:06:31 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62942>

 gitweb/gitweb.perl |   82 ++++++++++++++++++++++-----------------------------
 1 files changed, 35 insertions(+), 47 deletions(-)
 gitweb/gitweb.perl |   82 ++++++++++++++++++++++-----------------------------
 1 files changed, 35 insertions(+), 47 deletions(-)
 [PATCH 1/3] gitweb: Easier adding/changing parameters to current URL
 [PATCH 2/3] gitweb: Use href(-replay=>1, page=>...) to generate pagination links
 [PATCH 3/3] gitweb: Use href(-replay=>1, action=>...) to generate alternate views
