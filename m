From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Auto-repo-repair
Date: Fri, 16 Nov 2012 18:51:45 +0100 (CET)
Message-ID: <dbae3a06-c14b-4c06-9863-ae4771968fe1@zcs>
References: <0c0e34a4-16ab-40a0-9293-af94e34e4290@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 18:52:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZQ5B-0000q8-1a
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 18:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab2KPRvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 12:51:47 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:48609 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106Ab2KPRvq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 12:51:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id BFDFA62289E
	for <git@vger.kernel.org>; Fri, 16 Nov 2012 18:51:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNjhNRmF7Im7 for <git@vger.kernel.org>;
	Fri, 16 Nov 2012 18:51:45 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 524E2622259
	for <git@vger.kernel.org>; Fri, 16 Nov 2012 18:51:45 +0100 (CET)
In-Reply-To: <0c0e34a4-16ab-40a0-9293-af94e34e4290@zcs>
X-Originating-IP: [91.43.211.84]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209888>

Hi folks,

suppose the following scenario:

I've broken some repo (missing objects), eg by messing something up
w/ alternates, broken filesystem, or whatever. And I've got a bunch
of remotes which (together) contain all of the lost objects.

Now I'd like to run some $magic_command which automatically fetches
all the missing objects and so repair my local repo.

Is this already possible right now ?


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
