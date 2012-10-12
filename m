From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: filter-branch IO optimization
Date: Fri, 12 Oct 2012 17:59:44 +0200 (CEST)
Message-ID: <d4a00074-5134-4314-aa61-f222f41712bb@zcs>
References: <9de87aac-7e15-48d9-832a-e9a030c5ed43@zcs>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Oct 12 18:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMhel-0007GF-EK
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 18:00:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945943Ab2JLQAA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Oct 2012 12:00:00 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:42066 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945918Ab2JLP77 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2012 11:59:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 776FB460008;
	Fri, 12 Oct 2012 17:59:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o8n3cbXtXY8z; Fri, 12 Oct 2012 17:59:44 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 43C46460001;
	Fri, 12 Oct 2012 17:59:44 +0200 (CEST)
In-Reply-To: <9de87aac-7e15-48d9-832a-e9a030c5ed43@zcs>
X-Originating-IP: [91.43.215.119]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207551>

<snip>

Did some more experiments, and it seems that missing index file
isn't automatically created.

When I instead copy the original index file to the temporary
location, it runs well. But I still have to wait for the final
result to check whether it really overwrites the whole index
or just adds new files.


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
