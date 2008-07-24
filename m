From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: git reset musings
Date: Thu, 24 Jul 2008 20:51:14 +0200
Message-ID: <bd6139dc0807241151p177bb8eey6ff0fbd0a5d9008@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:52:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5vD-00067N-N5
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbYGXSvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752662AbYGXSvP
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:51:15 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:25641 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbYGXSvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:51:14 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3596020wfd.4
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=KCcOKLBEDy4OC2xscbRk2eSOAd8tReWOmQzREE5FAxI=;
        b=bc5RDB4KLJn/7kVTdRAKOoff9plO7BmlSOTXUxOdaFXZ/msM+JxILxSo4slUofUmY0
         I824Y4BcZHM1RqpDYAoSSt5xayg42N/nnKafUP6WjB72zfQP+FWfm0D28CpnDNZtG672
         VeZLERPkTBCRq90Xf/cIoMDuc9IHihQhLZmyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=l9EToaxjs+z69WrziztD0tNlwzKZr4sS6dRov1+pecsZddfhYNEHrY5AXwT1qwbRKv
         n6H+OBDmeAxfwMmJxqqcunjnU0PwI+/szklOb47BkqT7R4VRIf1TtzBXOZ8kgkfKNPXM
         yF5/STK21M9Nxfw+Vpe7E3GjyESmd/o7XsVAo=
Received: by 10.143.42.6 with SMTP id u6mr215353wfj.140.1216925474494;
        Thu, 24 Jul 2008 11:51:14 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Thu, 24 Jul 2008 11:51:14 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89938>

Heya,

After doing "git reset" you always get a whole bunch of lines saying
"foo: locally modified". Now I have a "OMG?!" reaction to that every
so often, where for a brief moment I think something went wrong. A bit
silly surely, but I suspect that some other users (especially those
new to git) have had similar reactions. Maybe it would be worth
letting the user know what's going on? E.g., before suddenly spitting
out an un-asked-for status report, let the user know that a status
report is following? Why not just do a 'git status' instead of this
we-hacked-up-a-quick-status-listing thing?

-- 
Cheers,

Sverre Rabbelier
