From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Splitting off old history to ancillary repo
Date: Thu, 28 Aug 2008 14:40:23 +1200
Message-ID: <46a038f90808271940w3aaf5c4ek6329e8066724c778@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 04:41:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYXSA-0008WJ-29
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 04:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYH1CkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 22:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753503AbYH1CkZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 22:40:25 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:22749 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbYH1CkY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 22:40:24 -0400
Received: by wf-out-1314.google.com with SMTP id 27so147587wfd.4
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 19:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=pxPrwWbQLkx5C0j9qznxogONpRDT8xCaAO3qlbg3FAk=;
        b=J0tTCyJza5tNP2UaL6ewW/yIIEyP9F5VYSHwjSIz9VBJw2xj4tP7PEpMFDnKAI46s1
         EO2z0H8kL8ftGZjS6l3jXjDxTtKAnyH4+e0kFasvnJzgCTZNVC34HWl2wrg2J/UVVH2E
         ns/A/y/o5W/0pcieOLDdhpdMGtXpclWcEvamo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Z7nOIM78f8GfeNX5dYvQN+T+uINc8w/ySK4MvxISFx36Dr6gr/Xeb+DI6U+BIhChCn
         up5knnnYTCzkT88U1em++JvwE/eV+Zpls/Gb22ZR51oFcux+mmPscOB1sjPLyW41sFvE
         DRzFuwGzXBr1ouGAsKX4f3n+dMc5+apdGgNYA=
Received: by 10.142.139.14 with SMTP id m14mr251670wfd.291.1219891223925;
        Wed, 27 Aug 2008 19:40:23 -0700 (PDT)
Received: by 10.142.43.6 with HTTP; Wed, 27 Aug 2008 19:40:23 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94027>

A project I've inherited has a codebase ~500KB in size. However, in
early history some large binary blobs were committed to the repo.
We've gotten rid of those, and they are not interesting to current
development. But an initial checkout still has to retrieve 60MiB, when
I'm sure the recent (and interesting) history fits in less than 1MB.

What is the state of grafts from a "keeping the repo mostly
transparently usable for newcomers" POV? Is there a new mechanims I
should look at?

Do we have a documented "here's how you split your repo with minimal
downsides to end users"? If you give me enough hints I could write it
:-)

The repo in question is http://dev.laptop.org/git?p=projects/xs-config;a=summary

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
