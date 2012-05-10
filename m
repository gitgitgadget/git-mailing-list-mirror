From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Equivalent of "fixup" for git filter-branch
Date: Thu, 10 May 2012 18:30:26 +0200
Message-ID: <CAGK7Mr5D0WQn-Tc1B5=F7+3OgZd1uy54Be-ZrbyFv0CP8JY5bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 18:31:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWH0-0000cq-QY
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758444Ab2EJQbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:31:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56998 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758291Ab2EJQa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:30:57 -0400
Received: by yhmm54 with SMTP id m54so1638076yhm.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=bZDFX0V5Rorbsa/JDVXXwJ6N/9DMRGDSFo83lAf21yg=;
        b=ANEYLw9NtW9shFFq32haaEYyuOeF2pp1/Aoburp9ELGDKiSHyS1ErtRDL6gj8lFlnz
         cuXCIezhmV22Vx38t90JkyC1IBtnz5pRuqrla8lL6WBkAgtNcynR/bC6o3mSxJKkuQst
         quj/ra1o2YIfR4yIWY7nemxZ1pbT0jqfgSEhhyOuJ6O1qcSL/qS2g2cY/4lS28yKSk8P
         4nzIYr4GsMEPqDkB9QrloWKvJ/CN4Z/6sm1ZYUeP7JcMNEXRYL2iQ2BgtqKnyG0RF2lj
         +rul3p8/MPrOYruCVBaSHx7Vf/j/N1aFqijXy+Bh/lUl47OeRaBOEaBn7J1PaWWvT6BX
         6woQ==
Received: by 10.50.190.202 with SMTP id gs10mr3063854igc.45.1336667456571;
 Thu, 10 May 2012 09:30:56 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 10 May 2012 09:30:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197592>

Hello,

I know there is `skip_commit` for git filter branch with
--commit-filter which squash the current commit with the next one,
however I have trouble finding a "fixup" equivalent that'd squash the
commit with the previous one (just like git rebase -i allows).

Yes, I know I could probably use git rebase instead but rebase doesn't
keep the existing commiter date like git filter-branch does.

Philippe
