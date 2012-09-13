From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Failing svn imports from apache.org
Date: Thu, 13 Sep 2012 15:32:07 +0200 (CEST)
Message-ID: <d5b32995-59c6-4669-bf4d-2532a1d58d2a@zcs>
References: <7c3575e3-dab1-4cd2-a0e0-74778316c8b4@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 15:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TC9Wm-00040S-3b
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 15:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab2IMNcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Sep 2012 09:32:11 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:54691 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754347Ab2IMNcJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 09:32:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 14B616228C2
	for <git@vger.kernel.org>; Thu, 13 Sep 2012 15:32:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wxRnYafpwTtp for <git@vger.kernel.org>;
	Thu, 13 Sep 2012 15:32:07 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 9F056622271
	for <git@vger.kernel.org>; Thu, 13 Sep 2012 15:32:07 +0200 (CEST)
In-Reply-To: <7c3575e3-dab1-4cd2-a0e0-74778316c8b4@zcs>
X-Originating-IP: [92.206.203.224]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205371>

Hi folks,

I'm currently trying to import apache.org svn server, without success.
See:

git@moonshine:~/projects/common/libs$ git svn clone --stdlayout http://=
svn.apache.org/repos/asf/commons/proper/discovery/
Initialized empty Git repository in /home/git/projects/common/libs/disc=
overy/.git/
W: Ignoring error from SVN, path probably does not exist: (160013): Fil=
esystem has no item: '/repos/asf/!svn/bc/100/commons/proper/discovery' =
path not found
W: Do not be alarmed at the above message git-svn is just searching agg=
ressively for old history.
This may take a while on large repositories
mkdir .git: No such file or directory at /usr/lib/git-core/git-svn line=
 3669

Does anyone have an idea, what might be wrong here / how to fix it ?


thx
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
