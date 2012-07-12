From: Douglas Garstang <doug.garstang@gmail.com>
Subject: git cloning paths
Date: Thu, 12 Jul 2012 15:17:09 -0700
Message-ID: <CANmEAK_jGdzR9R=0DexC+-_0U6mb_7o_v5zSKTuhgoaYCaSiFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 00:17:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpRhI-0005q4-V2
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 00:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759255Ab2GLWRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 18:17:13 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53895 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab2GLWRK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 18:17:10 -0400
Received: by ghrr11 with SMTP id r11so2988886ghr.19
        for <git@vger.kernel.org>; Thu, 12 Jul 2012 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=a3K4BrJHNkeq39fUg6MV1X3hbQ/TDWDhan6ke5MtyVs=;
        b=t+SQguy6adhV4Df00cmVNEgVUrj4+ahE3Ix/4XbqkWn6/wpOZJXk3+yBNEDV/AsMGR
         zxRgPr/my3J6g71cKLteTDocl8ouEeChpP0xLUg422N/h1QORhL3wwY5GrV3mEsL+aKa
         SxqP/LNPd8z/XBhvJHm4cTpyU1eFij3TF/ClYevxiv9bdEaC+zwZbNES/hmXvZOgwulV
         Q9QKTWFp26bQ3Up0KcZtKo813Dkkct/kFGpcQyZEoXEE/sL/NM78f6T5Db8wfoZwjszr
         /fd3/E8DKpkPnCScor12dKjsfsJKYJ6a9fQS4Gy/5JsIenhqwCC7z93eHyLm9z6Y2HW0
         85Gg==
Received: by 10.50.85.230 with SMTP id k6mr18535184igz.49.1342131429898; Thu,
 12 Jul 2012 15:17:09 -0700 (PDT)
Received: by 10.231.216.234 with HTTP; Thu, 12 Jul 2012 15:17:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201386>

All,

I'm a relative newcomer to git and I've just inherited a setup where
all of the company's code is in a single git repository. Within this
repository are multiple projects. It seems that git doesn't natively
allow cloning/checking out of individual paths within the repo (ie
projects), which would seem to make integrating git with a continuous
build system rather difficult. That is, the build system has to clone
the entire repo, and therefore a change to any project will result in
the entire contents of the repo being built.

Correct....?

Doug.
