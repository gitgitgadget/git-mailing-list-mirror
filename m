From: Leo Razoumov <slonik.az@gmail.com>
Subject: smudge/clean filters and SHA1 hashes
Date: Fri, 2 May 2014 17:05:57 -0400
Message-ID: <CADsUFkQLtUDpoiSqj-UYeyz1a-WZPh9vN+RW4ti8ut=22QwL4g@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 02 23:06:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgKeg-0006A7-1E
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 23:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbaEBVF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 17:05:58 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:59847 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbaEBVF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 17:05:57 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so1021210obc.41
        for <git@vger.kernel.org>; Fri, 02 May 2014 14:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=+FN0HifVHr/mRDyn6FqYPo1oHcLpqdh4KwOtq0x0zNA=;
        b=tdt2RsLMvXHtSy1d0iarXVpZiwKcl+VUmbIQ230Hq6mbwHwD0IqxZm+xb8jZGetf9N
         s4taQfdfxEBmFPJsOyEvOkHlrnV58E7LSXd0wYxwQPQvEbczsjj8T4Nl/5pf9yd/vXbd
         iE8tZKHJaKChj5JagIPdplAp82Yfh2L4wXIT6UNGzRsxrXyoVIXgX0Y72bak68y5Hwel
         LV6BG92PJYBevFda8TV33keabfFvcQ91temCcxW0IFsrTFv8aiteE7lKI0mIAkMxLB7G
         byjsAVisVy+v7KkRBLGesTFAd9Rj6Q+zIVMDsDnMijhDo3O+Tag9c7HDB2WoOPl5OjZc
         1w0A==
X-Received: by 10.182.97.97 with SMTP id dz1mr5078753obb.13.1399064757342;
 Fri, 02 May 2014 14:05:57 -0700 (PDT)
Received: by 10.76.73.196 with HTTP; Fri, 2 May 2014 14:05:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247981>

Hi All,

surprisingly, searching this list and by way of Google
I cannot find an answer to a simple question:

In presence of smudge/clean filters which SHA1 hash
(clean content or smudged content) gets stored in the repository?

Thanks,
--Leo--

P.S. Very similar question [1] was posted here in 2012 but went unanswered.

[1] http://git.661346.n2.nabble.com/workflow-clarification-sha1-merge-patch-diff-ws-smudge-clean-td7561818.html
