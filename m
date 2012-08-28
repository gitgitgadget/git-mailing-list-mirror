From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: diff/merge tool that ignores whitespace changes
Date: Tue, 28 Aug 2012 18:26:39 +0200 (CEST)
Message-ID: <12945e4d-6a76-4c5d-a4ee-132552a5da4d@zcs>
References: <c58cfa61-84c0-4bbe-80a6-59f156317007@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 18:35:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Ole-00072V-67
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 18:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab2H1Qfq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Aug 2012 12:35:46 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:30017 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753178Ab2H1Qfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Aug 2012 12:35:46 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2012 12:35:45 EDT
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id A67444608D8
	for <git@vger.kernel.org>; Tue, 28 Aug 2012 18:26:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDEm0E8imeAt for <git@vger.kernel.org>;
	Tue, 28 Aug 2012 18:26:39 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 4CE394608D6
	for <git@vger.kernel.org>; Tue, 28 Aug 2012 18:26:39 +0200 (CEST)
In-Reply-To: <c58cfa61-84c0-4bbe-80a6-59f156317007@zcs>
X-Originating-IP: [91.43.187.47]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC18 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204430>

Hi folks,

I'm looking for a diff / merge tool that treats lines with
only whitespace changes (trailing or leading whitespaces,
linefeeds, etc) as equal.

The goal is to make reviews as well as merging or rebasing
easier when things like indentions often change.

Does anybody know an solution for that ?


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
