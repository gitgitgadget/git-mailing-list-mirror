From: Joshua Shrader <jshrader83@gmail.com>
Subject: can git-describe learn first-parent behavior?
Date: Tue, 21 Sep 2010 01:58:43 -0400
Message-ID: <AANLkTi=6o15y-6Q+tn40=hrPf9pmo+Y1Jd97hGxr5mH2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joshua Shrader <jshrader83@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 21 07:58:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxvsQ-0003x8-Hb
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 07:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705Ab0IUF6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 01:58:44 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42522 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463Ab0IUF6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 01:58:44 -0400
Received: by gxk23 with SMTP id 23so1528483gxk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 22:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=z28BBV+25UCCDE9uWz8bpDY5U/8YcX1GjbYeCi++yuk=;
        b=d/zI3GpbP7YtQHoahk1vkQHt2XmEUq+vnjoXgOldBSrimCqRRz40Mkwr8+AuGlKi0e
         aJkkO1IabnupLLYchTuXkWNZS0cSa24CFfybdG69DwwS9HxD6s7Ui2g5juBga8hSxdGu
         W5DuWpMbRvgq61X5H49OKtP7kpBZTVIZm2ZnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Po1YODon7jl9ASYbj1DsZIQLhXB2rEFYIZ/JtVe2CDNl4WD+gGDhAqLh09G393eGw8
         WBQiKJmbUUziJLjgcHJE3ZOQ+4JLj1/REd5PC5HdcCzWIKtyrwZu/+FCC8ZQoLY4nfws
         ONjQwdd+QPnWlvSKlYTygKktA7erXUCB1dhoA=
Received: by 10.150.250.40 with SMTP id x40mr10494829ybh.135.1285048723425;
 Mon, 20 Sep 2010 22:58:43 -0700 (PDT)
Received: by 10.151.145.14 with HTTP; Mon, 20 Sep 2010 22:58:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156690>

This seems like it would be a rather useful feature.  Suppose a
maintenance branch, maint/v1.0, is forked from master, and the branch
point is tagged something like "v1.0-stable".  The next commit on
master is tagged "v2.0-base", indicating that it is the first commit
of the new release.  Suppose two releases are made - a release for
public consumption of version 1.0, and a release for internal testing
from master (currently 2.0), and we want to embed the output of
git-describe into the builds.  If bugs were fixed on 1.0, and then 1.0
was merged into master, it seems perfectly possible to run
git-describe on master, but get the v1.0 tag in the output.

Is this just a poor workflow?  Am I using git-describe incorrectly?
Or, does a first-parent option to git-describe seem useful?

Thanks for the input.

Josh
