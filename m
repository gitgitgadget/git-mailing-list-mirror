From: Eugene Sajine <euguess@gmail.com>
Subject: Fwd: git cvsimport implications
Date: Tue, 14 May 2013 18:09:09 -0400
Message-ID: <CAPZPVFZLDwLNazvBh5n=Jg_=CZUNz3yTme4JW2NutPgjPzwtLg@mail.gmail.com>
References: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 15 00:09:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNPH-0007W4-FI
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758645Ab3ENWJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:09:10 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40478 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758562Ab3ENWJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:09:09 -0400
Received: by mail-ob0-f174.google.com with SMTP id un3so1215057obb.19
        for <git@vger.kernel.org>; Tue, 14 May 2013 15:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=ITNkcvGdGex4n0vAbw4rqPIyQNoNam0d+4TZ905T3nw=;
        b=T9/s2AaJOglfQn4etUe+dtcRBOhkBVOjcF2PHIT3LORzUgIDuxGi9qCb6MvT/d6/UG
         vECD4MMwk1y0lI3Ozdsaga/aMuV+3uvovN2Ld1Jmj95cRibaSdEOAenFMfZwd51Y/uFQ
         hhdyeIRaIM1T64GCi8SNCUfvwP2J+aswQcGhaEXpl0fd05aMhlF8Qi18DCS/cPjQ+eR4
         z4+J0HcsQklVhSL9snfTVR+FRY8KF37cGMVcGiOvw/4UBHFEz6gyPcffu2NPwHFz61lY
         lEQcLKQ0jRLzbIqF88PHAKXaJ7a7pavwMqdfOL1DXAn6qCVIdu1zzkwFVSE+YH82x3WX
         sblw==
X-Received: by 10.60.116.138 with SMTP id jw10mr7906847oeb.64.1368569349335;
 Tue, 14 May 2013 15:09:09 -0700 (PDT)
Received: by 10.76.170.161 with HTTP; Tue, 14 May 2013 15:09:09 -0700 (PDT)
In-Reply-To: <CAPZPVFYFL6OS2HWbF0BKNKtNsZ6CfpWmKCypGxeTs7W8-76q8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224355>

Hi,

We are using git cvsimport heavily but mostly the projects are not
using branches that much. We are also migrating our repos only once,
so there is  no commits to CVS repo and no incremental imports allowed
after the migration. we have migrated more than a thousand projects
already.

we use the simplest way (from the CVS checkout folder)

$ git cvsimport -C /path/to/new/git/repo

Just recently it was brought to my attention that we can have problems
with that tool. So my question is if anybody could advise which
scenarios are safe to use this tool for, and what is not recommended?

What if there are a lot of branches in the CVS repo? Is it guaranteed
to be broken after import?

Do i understand correctly that it might put some files into a branch,
that were not originally in this branch in CVS? In which cases it
might happen (i'm sorry i didn't quite get the "issues" in the man
pages for cvsimport)?

Thanks,
Eugene
