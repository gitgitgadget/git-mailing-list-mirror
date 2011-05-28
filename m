From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id) in notes
Date: Sat, 28 May 2011 11:54:23 +0200
Message-ID: <201105281154.25223.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 11:54:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQGEE-0002VX-Pt
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 11:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab1E1Jyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 05:54:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47996 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879Ab1E1Jyg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 05:54:36 -0400
Received: by bwz15 with SMTP id 15so1836634bwz.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 02:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=h1UvkglC00LJHVlRHvz0+DvDftU7GhNAtLLtA9hTIFQ=;
        b=tpr+k4RIVqJCX96nU3WUlLPj2Y03b946TsWxWZUDWdjo+l+hHghsPTlPBLv7Ccacgq
         dsP55x48uvdVRCzauXvxjkZFkFOoM+M5LlvyasYl8AO+gsfYUlozU0fb62OS1Xtpahpq
         gYepLRL4D27vLEP/ixL5zN5fiXyt+Sm0C3vjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=cmzqrc59j5ScjTetiKLxz86JJUS+i736nYFMnnWyKp/k3aUiKurjY/4yxPKKNjzKzY
         B10B+iDIUdM+Lw1NUC2Njd8REXSm9xF4csKMzAZoaGa7K++9rW8tzbzpGochHf3My+v1
         FV+IFGGF1p6g4zHCZwfHQLcvNhY/LP1PWUv80=
Received: by 10.204.139.199 with SMTP id f7mr1375445bku.23.1306576475203;
        Sat, 28 May 2011 02:54:35 -0700 (PDT)
Received: from [192.168.1.13] (abvz93.neoplus.adsl.tpnet.pl [83.8.223.93])
        by mx.google.com with ESMTPS id af13sm1891298bkc.7.2011.05.28.02.54.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 May 2011 02:54:34 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174657>

Now that git supports annotating comments with `git notes` utility,
could we have an option to git-svn which would make it store SVN 
metadata, i.e. git-svn-id: lines using git-notes (separate svnmetadata 
or git-svn notes ref)?

This way we wouldn't have those ugly git-svn-id lines in log (unless 
requested), and droping them would be as simple as deleting ref - no 
history rewriting required.

Of course this requires git-svn to make use of those notes to get SVN 
metadata...


Eric, from what I remember you don't have time nor inclination for 
adding new features to git-svn, is it?

-- 
Jakub Narebski
Poland
