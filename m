From: bill lam <cbill.lam@gmail.com>
Subject: unmerged files listed in the beginning of git-status
Date: Tue, 1 Sep 2009 22:52:13 +0800
Message-ID: <20090901145213.GB4194@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 16:52:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiUiu-0000bQ-L1
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 16:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbZIAOwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 10:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbZIAOwa
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 10:52:30 -0400
Received: from mail-px0-f203.google.com ([209.85.216.203]:33755 "EHLO
	mail-px0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbZIAOw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 10:52:29 -0400
Received: by pxi42 with SMTP id 42so41953pxi.20
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=SwhB9s7la2o5xayeP5Iu9/QxJ/4mvsTpvpcemcxaDqc=;
        b=DVFsRiDu3TVjqqUiEpy/hegiA9qCep2wHs5NE665x79yRn9+ZpbESzudYmC18jKQpc
         1V8AiqvJVK2uyYNTuoFPrqAQxxL0zPFT/LuuLVZgJLufjPly5xieev7cPnVrjpn+rgW5
         cnV8QHWWjZsoghLKUFN+VmvD2ifBATkSXTic8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=GqgSIyusskYpXu+xc5L2DOvUOE0xnoffIImDMx+hwqFQNffqqLA/PuL14h5Y88jvBg
         egMhtjqIfWjtRWqJXZNhUhLn6d5Hd5RT+iP75yo/9wmc2cUzl8AUAHiHOuiTWytkQ5wG
         Ksu2BN8iE+gDkC6+TPcUtUsRhVsAWA8MzBxaU=
Received: by 10.140.157.9 with SMTP id f9mr1635536rve.116.1251816751530;
        Tue, 01 Sep 2009 07:52:31 -0700 (PDT)
Received: from localhost (n219078080082.netvigator.com [219.78.80.82])
        by mx.google.com with ESMTPS id 23sm1503658pzk.0.2009.09.01.07.52.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Sep 2009 07:52:30 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127539>

I noticed in the new git 1.6.4.2 . git-status show unmerged files
with a clause of explanation.  This is very helpful. However these
unmerged files are listed in the beginning and followed by modified
files,  I imagined the normal case will be there is only a few
unmerged files but a much large number of other files.  Thus it needs
to shift pageup or redirect to less in order view these unmerges
files.  Previously these unmerge files are listed after modified files
and easily seen or copy-and-paste using mouse.  Is there any specific
reason to change the order of sequence?

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
