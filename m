From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Usability improvement request: git show revision -- file
Date: Thu, 31 Mar 2011 08:45:07 +0200
Message-ID: <AANLkTi=JPVXD7Je7Rz9yhKHnJo+K2rs5WnwTY22c3h6L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 31 08:45:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Bd9-0002hB-Vq
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 08:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933760Ab1CaGpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 02:45:09 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38383 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932720Ab1CaGpI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 02:45:08 -0400
Received: by vxi39 with SMTP id 39so1621306vxi.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 23:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=AUc0oyhC79s2+kH6CITwACvqcPUWGqZWnsCtxbhjTxc=;
        b=EiKoz9I788t1vtIIgnX9lv7E7qkjRAM/koo/0f7h7Ft0dxlV+XYNvdh9wFqTerqckU
         2E9+pCBFGMwTCHWzWdnedEzMbRHZRKP4pyc5eT0pPNfhRp4hcTszhwUmbWhDHPFOi92n
         kVDX5jXH/Adc3lsORuaZjkWEDWj31rQv81wDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rg6jiKdxoyhnq1178i8JKpGTP9ape1cUjWMHqyWT4nVxRp7xW+yQh8tcPwylJxk/RL
         tS0ZBXTnyN2Eo37OFRGmFs1Rhmot5E61tgsMfqZ0rOlI+8s8k3k4PhNVMe6g4bpmPXYG
         LEeZ+QLaVEp0d1R1d7692P0+MD4GuI/f08J2U=
Received: by 10.52.95.135 with SMTP id dk7mr3076243vdb.93.1301553907420; Wed,
 30 Mar 2011 23:45:07 -0700 (PDT)
Received: by 10.220.210.16 with HTTP; Wed, 30 Mar 2011 23:45:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170457>

Hi,

if there's existing way to do this please tell me.

There's this file "src/subdir/file". I'm in the "src" directory and want to
see the "file" at specific revision.

Knowing about git show I'd expect something like this to work:

   $ git show master -- subdir/file

But it shows nothing (no output, no warning). Following also does not
work as expected:

   $ git show master:subdir/file
   fatal: Path 'src/subdir/file' exists, but not 'subdir/file'.
   Did you mean 'master:src/subdir/file'?

Of course following works:

   $ git show master:src/subdir/file

but it's not very convenient to have to specify full path, and it's not what
you would expect given that most other commands accept "-- relativepath"
syntax.


-- 
Piotr Krukowiecki
