From: Peng Yu <pengyu.ut@gmail.com>
Subject: changing files and large files
Date: Fri, 7 May 2010 14:07:47 -0500
Message-ID: <j2v366c6f341005071207x7cba4b50jcb9dd3f2c2872a62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 07 21:07:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAStv-0004zv-5v
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 21:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab0EGTHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 15:07:49 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:41617 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757799Ab0EGTHs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 15:07:48 -0400
Received: by ywh36 with SMTP id 36so820934ywh.4
        for <git@vger.kernel.org>; Fri, 07 May 2010 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=EkAdkR19r5eQl/vqNCEXGlyXfusqN2+gEOcH4oC/Kjk=;
        b=uAKrR88rjQULi5/PQ4vYWUakmy/jzcc6LIdUmgKkCL1nYZq3AEWSYyByBbtdO0ftBH
         v4uQz5c5uMKD/q2pendyrD0cixcdc0+cSR9TdPaSdeRWfAEmRcRsTDXkBy/4IznrUgj0
         fA66XJh+IbNuEuChbdhM/FSnwIsm6lEiS6GC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Lm2bGuXFUjGkrR2NMymRh7nBZ9vmZ3JqA0Ayxr/CfwoxYG3t4VgRc+AqfHO6rND5zw
         KtUD/7FBj5Y+hWLmxzZLD5XGP5avZHhyZ9CtcF09ojLm8xOvIHiSOdwIXK00lhEJGcQL
         LNnDaaUyf6O2htBdtMhC1aC1Jtc+C+gE8B/Pc=
Received: by 10.151.88.22 with SMTP id q22mr4193163ybl.149.1273259267657; Fri, 
	07 May 2010 12:07:47 -0700 (PDT)
Received: by 10.151.50.11 with HTTP; Fri, 7 May 2010 12:07:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146556>

I'm considering using file control systems. I'm wondering if git could
handle the following situations. Would you please let me?

1. Change file names: whether it records the lineage of files that
undergoes name changes?
2. Files are extremely large (of hundred of MB or even GB).

-- 
Regards,
Peng
