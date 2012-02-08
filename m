From: Eric Scouten <eric@scouten.com>
Subject: git p4 submit bugs (submit fails due to keyword expansion mismatch
 and gives bad instructions for how to proceed)
Date: Wed, 8 Feb 2012 13:49:50 -0800
Message-ID: <CAEe=O8o-BG0xNGQEweezPu8cj+Brt1Km_anhEJBg0W7Q=rLbkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 22:49:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvFOm-0000F5-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 22:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434Ab2BHVtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 16:49:52 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:42826 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754781Ab2BHVtv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2012 16:49:51 -0500
Received: by obcva7 with SMTP id va7so1349643obc.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=eSCTpo2StgHV6ET6dFIqjhF+Kll8VYsdTRHwOIGBo8Q=;
        b=h8EnIb1ke3f0SD8MkkfbI9vsKyXVA9pBOz4UePLs/ADRF+fJmCZVyGWoNQZBpKKRuM
         vnR7mPKJuu4c75ksdWaT7z+sSDtGVuGpNgT+OJio0Yh3mrkHgkJMHVK6UnLfWFHD6keE
         AW1BS2uWc9XfBzcO67hAQ0mni8gtSK9gFKDnQ=
Received: by 10.182.222.74 with SMTP id qk10mr27558721obc.75.1328737790498;
 Wed, 08 Feb 2012 13:49:50 -0800 (PST)
Received: by 10.182.97.168 with HTTP; Wed, 8 Feb 2012 13:49:50 -0800 (PST)
X-Google-Sender-Auth: dkJA4Pwtz3heuA5bIPBXVMWGptc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190257>

I've been experimenting with git-p4 as a front-end to Perforce as
described in http://www.perforce.com/blog/120113/git-perforce-client,
but two bugs are causing me major headaches:

(1) git-p4 doesn't work with P4 keyword expansion. (I gather there's a
fork of git-p4 that makes it work, but the current official distro
doesn't.) This can lead to some ugly failed submits down the road.
Which leads me to ...

(2) When a git p4 submit fails, the error message for how to resolve
it is bogus. The instructions say "Please resolve and submit the
conflict manually and continue afterwards with git-p4 submit
--continue", but when I do that, I get:

$ git p4 submit --continue
Usage: git-p4 submit [options] [name of git branch to submit into
perforce depot]
git-p4: error: no such option: --continue

Ugh.

(P.S. If there's a better place to post bug reports, etc., please
inform. Thanks.)

-Eric
