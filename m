From: "Quilkey, Tony" <trq@thorpesystems.com>
Subject: Workflow Help
Date: Tue, 21 May 2013 10:59:17 +1000
Message-ID: <CAMATmi3bU7hrD-YLY1iVXbekxOx_XZfZ5yYNBfzV_VFSc_W5jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 02:59:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeavC-0002vN-V2
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 02:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096Ab3EUA7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 20:59:18 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:58597 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab3EUA7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 20:59:17 -0400
Received: by mail-da0-f46.google.com with SMTP id e20so43122dak.19
        for <git@vger.kernel.org>; Mon, 20 May 2013 17:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=bmfPKPkOKc4YZdQQvLs5RjYeJKMOwY53DvRJkAddr1o=;
        b=Gy3ZRvvPuIpxVZKrL4iEH88vElYh4WRe4VYBDuBdpKNuNFMbGuTTN9LzQF7NNhzlqc
         prE6IGPX2GYyiqdt6hIq+REAG0Q5Zg80S7m5D7sNIvU0iTg82t0weddpr21fZYbPB9zA
         BgW2uik0QOCnODbwb60auWsC/sgyx731zP75jovKeU/HwLU3r02A1w0jIpsahVuFEwyJ
         +3Phk9lT5bQZehnFdgM6nohSe/wfE2Kapro0gQAOMn6nH/Lpaf4EFnYBKUK/YAMIjxB6
         Y2lfbl2meaQMQ/BjSd20FL6PQajkJFYblim9OTZnHZnVFSDr5JzPnmP5crkMN3BMQcZt
         i6lQ==
X-Received: by 10.66.163.133 with SMTP id yi5mr585407pab.93.1369097957275;
 Mon, 20 May 2013 17:59:17 -0700 (PDT)
Received: by 10.68.237.129 with HTTP; Mon, 20 May 2013 17:59:17 -0700 (PDT)
X-Gm-Message-State: ALoCoQli619YuNedNbaIMeFWrsLgQSOaeLBbTJ65hcQeeVmnmOwhGVJIf8bxVK59DWYKgvPxnpYu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225007>

Hi,

I am looking at formulating and then documenting our vcs workflow
using Git at work. I have an idea of how I want things to work, but am
a little hazy on some of the details.

Our basic workflow will be based around:
http://nvie.com/posts/a-successful-git-branching-model, with a few
exceptions.

We would like to create our release-* branches from the last release
tag. From there, we would like the ability to cherry pick (or take the
complete diff) commits from the develop branch.

So, we are after is:

1) Create topic (feature) branches from develop, and merge back into
develop when complete.

2) Once it is decided we are packaging a release, make a release-*
branch from the previous release tag.

3) Cherry pick/merge/whatever any commits we want from develop into
the new release-* until it is complete.

4) Merge the new release-* branch into master and tag it.

Repeat as necessary.

At the moment I am a little stuck on how exactly we can cherry pick
stuff from develop into a release-* branch. I'm not even sure this
approach is exactly what we should be doing.

Our main concern is that at this stage, there is no guarantee that all
commits within develop can be pulled into a release.

In regards to how we can achieve the above results any input would be
much appreciated. Or if there are any other better options available,
I'm all ears.

Thanks,

Tony Quilkey
