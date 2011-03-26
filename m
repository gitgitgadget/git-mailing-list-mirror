From: Francis Moreau <francis.moro@gmail.com>
Subject: Listing top tracked files and directories only
Date: Sat, 26 Mar 2011 17:18:50 +0100
Message-ID: <AANLkTi=OMXTJm=mvr70KudS+S9c857z7Kv1qVE1FFdD_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 17:18:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3WCX-0004q5-BY
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 17:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab1CZQSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 12:18:51 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33585 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab1CZQSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 12:18:50 -0400
Received: by pzk9 with SMTP id 9so296699pzk.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 09:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=UTH3CFaVoDKQQ8nMnU5LxrSa0M17vrzi7r3lxDzP73w=;
        b=eVmTg903+ZVktbgvohQfVpPMeKMGWsudjKzbpBoQidnHO+Bp2VgaUYCEUtjdG+QB+2
         W0yXTnGVfcPBDr9KGhaM5oNjsjTVqNrRqm2O4I0wl1BIg4Kf6NNl0nmcS2lgDorBJwTp
         0BoXhVuf7O0dqYX1fuCMNC644JtM4/EaYsNO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=it0CSurMF/28lCLptJTxf3LyW7tSFSZPPRb25WAgwT00B98AV+t22mJf0BFkRRFHBF
         cXnf3MncpV6p+VerdW6Z5rOvpqtvAdK+/bErniBSz5ow5tuDi4jXstkAteSeDL6tEeWa
         Ns+EgswuZOsn4Xe69h3lmkUkGU908jK5OmmMM=
Received: by 10.142.250.14 with SMTP id x14mr1536218wfh.432.1301156330376;
 Sat, 26 Mar 2011 09:18:50 -0700 (PDT)
Received: by 10.143.177.4 with HTTP; Sat, 26 Mar 2011 09:18:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170056>

Hello,

I'd like to find a way to list files and directories tracked by git
but which are only in the top directory of the tracked project.

For example, in a kernel repository:

  $ git-magic-command --magic-options
  .gitignore
  .mailmap
   COPYING
   CREDITS
   Kbuild
   MAINTAINERS
   Makefile
   README
   REPORTING-BUGS
   Documentation/
   arch/
   drivers/
   kernel/
   ...

I tried to come up with something using git-ls-files but fails.

Thanks for any suggestions.
-- 
Francis
