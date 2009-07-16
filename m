From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Thu, 16 Jul 2009 08:37:21 +0100
Message-ID: <e2b179460907160037t17e276fas8a713eff55bba7f3@mail.gmail.com>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
	 <057D2A1F-0383-4AE4-A431-54D6C1F90D85@comhem.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tommy Nordgren <tommy.nordgren@comhem.se>
X-From: git-owner@vger.kernel.org Thu Jul 16 09:37:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRLX1-00006d-BR
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 09:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbZGPHhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 03:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbZGPHhX
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 03:37:23 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:51404 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZGPHhW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 03:37:22 -0400
Received: by bwz28 with SMTP id 28so1874199bwz.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EdwB3uC8IGbQaWddZdOUWy60fAE30YQCsFFty+poGzw=;
        b=JLSm6Fs7v+7HLIsBInejxqDp3avf5/byb3/qnhTtltjUCnixn9l3NZTlIGnXA8ME6k
         KDIupdt1egJYgcaCuFkSLCXcs4PyxZYrNgXAP2vzsyPqSpStLCXoMOp3hnQiNCnZgYHV
         rB+icdIyZGlLzQN7siZKNRJfr43kYar2Af6L4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UvOsdjKIWVIIBWSKyAlwVK9+1CtbbXMAXPkiTyOk0K/rhSiBRe+uooZnXTTRrR3qDj
         OWISZ5yNiS7ZwwMe8CWmA5GUweTWTMCpp9/cTR4nzIUnCohnXECtDMkfcONCf/3hbz9s
         opvfaW5aP7MFk5P3UrOKZwDanmemy6V3W/3/4=
Received: by 10.223.107.135 with SMTP id b7mr4310098fap.30.1247729841658; Thu, 
	16 Jul 2009 00:37:21 -0700 (PDT)
In-Reply-To: <057D2A1F-0383-4AE4-A431-54D6C1F90D85@comhem.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123378>

2009/7/16 Tommy Nordgren <tommy.nordgren@comhem.se>:
> Testing a build of this version fails at a late stage, with an error that
> aborts testing.
> My system is Mac OS X 10.5.8
> Fragment of output at failure:
> *** t9200-git-cvsexportcommit.sh ***
> ..snip
> * FAIL 14: re-commit a removed filename which remains in CVS attic

I posted a fix (well, a sticking plaster) for this yesterday. Could
you confirm if this fixes it for you?

http://article.gmane.org/gmane.comp.version-control.git/123317

The issue is intermittent on AIX (and Junio has seen it as such on
Linux too) so you may need to run the t9200... script a few times to
verify all is ok.

Thanks also for testing the rc, and the detailed report, very much
appreciated by all I'm sure.

If you can regularly build git.git snapshots, there are some scripts
at http://repo.or.cz/w/git/gitbuild.git in the platform branch, and
tags get pushed there describing the state of the build and tests on a
few 'non-core' platforms.

Cheers, Mike
