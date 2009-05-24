From: John Bito <jwbito@gmail.com>
Subject: [JGIT] Bus error (SIGBUS) on Solaris
Date: Sun, 24 May 2009 11:13:24 -0700
Message-ID: <3ae83b000905241113u6895a7edlc1f81f0ea54a0c53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 24 20:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8IDM-0006Po-1N
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 20:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbZEXSNZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 14:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbZEXSNY
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 14:13:24 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:40049 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZEXSNY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 14:13:24 -0400
Received: by yx-out-2324.google.com with SMTP id 3so1619819yxj.1
        for <git@vger.kernel.org>; Sun, 24 May 2009 11:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=SN8sLpmvc7TxeuoMnNTaG+wZLSWg0oNRbk2Zgl7P760=;
        b=HQRpU2yl1AHK2ZEPS0qsmp40UF0vYjs55GLga9jyy3I3EQLDUvCLKF09WjRwxDmvE/
         dAvqbllEns/jIsarkr7tTsuIkftQzpmk1n5vnEwlxUffSwZPcBuz/CXXfaHVTI3h1RE9
         DyfG6PBuso8NsDUqZuz3mzxWh6SQvCH18C1I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Ya6WJM9IeqD63q8bvE83w6rxeGWsUwuEPTsSlzeQ0YROwGgzByaDkqgbrFAVLtouB2
         K2LtGezktNlSxj9lDMVQznACfirsMHQccemrJ1NkJZbQkyiAe5BxUXXt9Lt5R50PjMNb
         MH6zFIJSpNXCVw4mR73zizlGr0reVrdvvzstQ=
Received: by 10.100.141.12 with SMTP id o12mr10075242and.141.1243188804819; 
	Sun, 24 May 2009 11:13:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119847>

I updated with the integration build on the update site today, after
restart, Eclipse failed with a bus error.

> #=A0 SIGBUS (0xa) at pc=3D0xf88162fc, pid=3D15191, tid=3D23
> #
> # Java VM: Java HotSpot(TM) Client VM (11.2-b01 mixed mode solaris-sp=
arc)
> # Problematic frame:
> # j=A0 org.spearce.jgit.lib.OffsetCache.getOrLoad(Lorg/spearce/jgit/l=
ib/PackFile;J)Ljava/lang/Object;+17

I haven't updated my WinVista workstation, yet.=A0 Shall I create a bug
report with the full error log, or is this something that's already
known?

The failure seems repeatable with my current workspace configuration.
