From: Tzu-Jung Lee <roylee17@gmail.com>
Subject: Do we have a convenient way to refer to a specific commit in an
 already filtered rev-list?
Date: Sun, 25 Sep 2011 00:46:20 +0800
Message-ID: <CAEvN+1jPD53-e8a31g+iz6vMB0-e2LECjouBELkBOXBV5=oGBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 18:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7VMx-00019e-8Q
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 18:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab1IXQqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 12:46:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63677 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759Ab1IXQqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 12:46:22 -0400
Received: by bkbzt4 with SMTP id zt4so4403674bkb.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=goh72zXqsM46SvHgfb72bX+21vDmM0s3pIrMpYdN+ao=;
        b=k+gaRTreh9S4eNXgJhHH35F+6jglnEpGb6wVRMavElglACIYSGfkpe4t0eKuzr6bpz
         Vgo5Up+rSA0LcF0irjSDCGksEmM/7bAvBkSxWCp4dOi45Lqim+ciICPPgLv9IJu5r26j
         JNSinExloGXM1CrSwoE1VMZFW4hqXUYniMaZo=
Received: by 10.204.144.21 with SMTP id x21mr3128782bku.336.1316882780670;
 Sat, 24 Sep 2011 09:46:20 -0700 (PDT)
Received: by 10.204.24.68 with HTTP; Sat, 24 Sep 2011 09:46:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182033>

Hi Folks,

Do we have a convenient/symbolic way to refer  to a specific commit of
an already filtered rev-list? For example, I'm interested in the
commits with some constraints:

    git log somepath --author=someone

Without gui/tui tools, I have to frequently CUT & PASTE the commit-ID
for further manipulation (show, cherry-pick, ...), and possibly repeat
the parsing couple of times if I didn't save the output. I wonder if
we have a convenient way to refer to the discrete commits? like
HEAD~4, HEAD@{3} or something magic.

Thanks,
Roy
