From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: How can I tell if anything was fetched?
Date: Thu, 11 Oct 2012 20:29:05 +0200 (CEST)
Message-ID: <369f3feb-20e5-444f-b718-15d7dc8f2c61@zcs>
References: <m28vbdkley.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Phil Lawrence <prlawrence@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Oct 11 20:29:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMNVm-0008W1-BK
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 20:29:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759016Ab2JKS3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2012 14:29:10 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:8706 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925Ab2JKS3I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2012 14:29:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 6D45D6228BF;
	Thu, 11 Oct 2012 20:29:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kx6vM9e5ee91; Thu, 11 Oct 2012 20:29:05 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 1583E6228BB;
	Thu, 11 Oct 2012 20:29:05 +0200 (CEST)
In-Reply-To: <m28vbdkley.fsf@igel.home>
X-Originating-IP: [91.43.169.65]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207501>


> I think you'd only need to record the state of all refs (eg. the
> output
> of `git for-each-ref') to reliably detect any changes.

I would just record the output of `git ls-remote . | sort -u` somewhere
and compare it next time (maybe you even wanna grep for the desired
ref namespaces).


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
