From: =?ISO-8859-1?Q?Mads_D=F8rup?= <mads@dorup.dk>
Subject: Fwd: [PATCH] Improve font rendering on retina macbooks
Date: Sun, 21 Jul 2013 14:25:32 +0200
Message-ID: <CAMtfEwQJub1C7uak5jiCtLJ4obLPvSZYyPfiVW6BLbw0RK4=xA@mail.gmail.com>
References: <CAMtfEwTGTCKhuFK116-z2ePE70T1iXdPx7BB1xLxRdfsAfws=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	=?ISO-8859-1?Q?Mads_D=F8rup?= <mads@dorup.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 21 14:26:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0si5-0000WB-Bx
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 14:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab3GUMZe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jul 2013 08:25:34 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:53982 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab3GUMZd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jul 2013 08:25:33 -0400
Received: by mail-qc0-f175.google.com with SMTP id k14so3111045qcv.6
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 05:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=0yISTNvjB8vzCuxtLI6wnc0mN2jBQjIvRZhQ2YORFxE=;
        b=D6ECcKXed892eHODPR3GNaAen2+wPOCHPSz1lFWUrlD4PACMZ0ejqite+OtCH2tmnk
         wXHLrRmOt6zqNGLMcizNqhgxjuYPJ84kFeCB0fGpq2LaSQsQHuu9qqUyzIxiWZgud7Nv
         zLqPYSf9xM4tjneRZ42QJxE8tle9yD1QCSojPu4cT7QJKfzagD8BQyrTU0ZX8UOIGwn6
         JyvCwZWJzIweRGV034mElrVYhskzrsn6Tl+sCbSRDo2E5CNvBZx/dib0tcIM8kLbOqa+
         AUenYJ9/cPZia8O14geolaooGZwdPmZBfAE3XB/1Dkva94zoISMjZ7YSLUUEyNCC8FUw
         QKKQ==
X-Received: by 10.224.28.129 with SMTP id m1mr4668058qac.115.1374409533011;
 Sun, 21 Jul 2013 05:25:33 -0700 (PDT)
Received: by 10.49.88.106 with HTTP; Sun, 21 Jul 2013 05:25:32 -0700 (PDT)
X-Originating-IP: [94.144.63.214]
In-Reply-To: <CAMtfEwTGTCKhuFK116-z2ePE70T1iXdPx7BB1xLxRdfsAfws=Q@mail.gmail.com>
X-Gm-Message-State: ALoCoQmPLlNX8ZeEneXiHChU7mVBNgHZhC6dKjvyt9O6eK6BzjKhq9OTMAtdim/RxQfNXkgk/gu+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230926>

Hi there

I've created a very small change to git gui that considerably improves
the experience on my machine at least:

diff --git a/git-gui/macosx/Info.plist b/git-gui/macosx/Info.plist
index b3bf15f..1ade121 100644
--- a/git-gui/macosx/Info.plist
+++ b/git-gui/macosx/Info.plist
@@ -24,5 +24,7 @@
        <string>GITg</string>
        <key>CFBundleVersion</key>
        <string>@@GITGUI_VERSION@@</string>
+       <key>NSHighResolutionCapable</key>
+       <true/>
 </dict>
 </plist>


I've read the documentation for submitting patches to git where it
says that I have to e-mail the patch to the mail list, with relevant
developers as CC. Pat are you the relevant developer for this?

Here is a screenshot comparison of before and after the change:

https://github.com/git/git/pull/48

Please let me know how to proceed to get this patch in, if you like
it. I've never contributed here before, so please me know about any
procedures I have missed.

Regards, Mads D=F8rup
