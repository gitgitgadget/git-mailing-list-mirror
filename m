From: bill lam <cbill.lam@gmail.com>
Subject: how to add an empty initial commit
Date: Sun, 30 Aug 2009 08:52:24 +0800
Message-ID: <20090830005224.GC10952@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 30 03:25:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhZAw-0003yu-Sq
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 03:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbZH3BWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 21:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbZH3BWB
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 21:22:01 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:39126 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbZH3BWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 21:22:01 -0400
Received: by gxk1 with SMTP id 1so3883008gxk.17
        for <git@vger.kernel.org>; Sat, 29 Aug 2009 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=z17ELYU7ZgZ8OyMbiyPcGJ2mnJinzBiiDSi6KSgi6kI=;
        b=Z+Ifcp92tCpuSosy1rORnQj+IlvW6E6XhSFz8G3LFOVkvQAuya6vBRXkiWDBgbcbNJ
         cbFmJ2KxN/UvmQPffYzQaPWNurHszKuWqNQUGC/dKWoQcbZEPjBMy3lGvt7ER53OnZwQ
         pudhR1qLv1jLdsIRLUQgveAoEIYZWnZ5at7Ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=oNwMZZdwLIHLeMle4NkRk0bb1ZHCL3xtdfDM8R9oFXWHxj4j3YtMwMfZGYJ34HmQXo
         ePqg4xREtFUlXwUpsVOnJ2XlET8thi1U13T3yB0fnGrBYNXYZS+ZMVZ6cb4FGvEmVKRd
         A0iubJbK+zy+p/M3xTfWJPw7GRuDVba3GzaLg=
Received: by 10.150.131.17 with SMTP id e17mr5375080ybd.279.1251593549956;
        Sat, 29 Aug 2009 17:52:29 -0700 (PDT)
Received: from localhost (n219077019153.netvigator.com [219.77.19.153])
        by mx.google.com with ESMTPS id 23sm672716pzk.8.2009.08.29.17.52.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 29 Aug 2009 17:52:29 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127388>

I want to insert an empty initial commit so that I can rebase and edit
files in the real initial commit. There is a --root option in
git-rebase but I can not find example of how to use it. 

I googled some said it needs to create a new branch, I tried but it
failed to merge.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
