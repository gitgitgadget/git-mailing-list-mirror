From: Yuval Adam <yuv.adm@gmail.com>
Subject: Maintaining historical data in a git repo
Date: Fri, 30 Mar 2012 16:34:08 +0300
Message-ID: <CA+P+rLeyEcZPudhLWavB74CiDAqpn+iNkk4F8=NK_yGaJPMmyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 15:34:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDbyM-000645-4Z
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 15:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035Ab2C3Nea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 09:34:30 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34217 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511Ab2C3Ne3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 09:34:29 -0400
Received: by iagz16 with SMTP id z16so992021iag.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=9HtNBWhk/mWu3d0tFU27Gl+ztQhdUhHmSCN+j8H4Gt8=;
        b=KxrOPac0oNIgDNRR7U9FsH72FZBpmUaHGQ9G8GZwfHRWKpSVV3NTvKiQ0dl3ozauHM
         CRE7KiXxgY59eJ1II0DMOWtkufmvn06cJ+Li3v7mYSqarUrIQCsqys3viL8LZ4O869/W
         cEuTWKWqQJ34rNmZsZE0gvNB+aptttBRwTAd/yl20qN37ijUaXMZQWQpmTfcmFPKi8gZ
         PKaWYYv03rJq5GTd4nuSLDRmmUSIt1bl4+WlJBFOBa7hOnWk0It0V+TpGHs2FPv7mAvf
         NqYaL9tH35XdtnIGpZqdyYDXJr+LXIrFwMNUVSbvgmwjCivyWY8q4ugQnpSKgvpAQ6Qa
         YFZw==
Received: by 10.50.194.232 with SMTP id hz8mr1369852igc.38.1333114468875; Fri,
 30 Mar 2012 06:34:28 -0700 (PDT)
Received: by 10.42.137.66 with HTTP; Fri, 30 Mar 2012 06:34:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194358>

As part of a public project to open-source the Israeli law code, we
are looking into ways of represent such data in a git repository.

The main challenge is to represent historical data _in a semantically
correct way_ within a git repository, while having the ability to
change data that has occurred in the past.
For example, we might have revisions B and C of a certain legal
document, commit to repo, and at a later time want to add revision A
to the proper place in the git commit tree (probably with rebasing or
replacing).
Allowing decentralization and updates is a major requirement.

We're trying to map out the various pros and cons of the different
options of maintaining such a repo.
Has anyone ever attempted something like this?
Are there any projects that build on the git plumbing which provide
wrapper APIs to handle historic data?

We really could use any reference or advice we can get on this subject.

Thanks,

--
Yuval Adam
http://y3xz.com
