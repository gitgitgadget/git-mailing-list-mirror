From: Jay Soffian <jaysoffian@gmail.com>
Subject: failed to lock
Date: Wed, 14 Apr 2010 16:49:09 -0400
Message-ID: <j2o76718491004141349l53b53347v7f4c0edcab69e4c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 22:49:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29WO-00087B-L2
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 22:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744Ab0DNUtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 16:49:11 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:43266 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756621Ab0DNUtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 16:49:10 -0400
Received: by pzk42 with SMTP id 42so560225pzk.4
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=JwG1mnp0Z6Qyu+gPWhdT5BSF5qa2iXs27dKYlNTEm7w=;
        b=ZkXevBDyKj+o7DpqJGrdEdX3Cm9v8MxeLWcvipvCU8BTk62gM3q/eH84e/4FqIlz58
         ogt/mLsaijkDQsNae3coBPJ5DWbhgp860Ad/aFcybuWSYxfcqUjMhtAx1aIXRO/TbsQL
         abZuWE6KJPVo24U+ou5W1J+Q3Z6ibOwYbgwqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=NaSDmUgbV6CZrPwL2jkhzXlOkqpSFp7Ew1C09eYIhcTzUDfcSu8Ce2WgoDgJEtMiK9
         QuyhEG7TWW50/eLTcnENhnmCdFVV+p4OD+S3zgPgoJd7CBq1xpFHuy4uKc+xmePOp81q
         vyETZEpOD/N3iWWgnwvG4cvHAqLvRruaEw6QQ=
Received: by 10.231.36.9 with HTTP; Wed, 14 Apr 2010 13:49:09 -0700 (PDT)
Received: by 10.142.2.34 with SMTP id 34mr3896718wfb.9.1271278150030; Wed, 14 
	Apr 2010 13:49:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144912>

With git-1.7, I regularly get this when pushing to a non-bare repo:

remote: error: failed to lock refs/remotes/origin/master
...
 ! [remote rejected] origin/master -> origin/master (failed to lock)
error: failed to push some refs to 'ssh://remote/repo'

I see this pushing from a Mac, to either a Mac or to Cygwin. I have
seen it on various versions of the 1.7 series and possibly before. In
the instance above:

local git version 1.7.0.3.436.g2b878
remote git version 1.7.0.3

In addition, the ref is (apparently) updated just fine. If I push a
second time, no update occurs.

The problem is reproducible. Any idea where I should start debugging it?

j.
