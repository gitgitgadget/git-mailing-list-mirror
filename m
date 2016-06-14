From: ZhenTian <loooseleaves@gmail.com>
Subject: I lost my commit signature
Date: Tue, 14 Jun 2016 15:50:43 +0800
Message-ID: <CAGrdoOrrpc7OiU74fa-qpjLNxOtm4upAOAfWPG6VbWUjyE0C2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 09:51:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCj7c-0001nR-DE
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 09:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbcFNHuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 03:50:44 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34541 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbcFNHuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 03:50:44 -0400
Received: by mail-yw0-f175.google.com with SMTP id c72so147483826ywb.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=EMkWG3D4vA0O9hxGsfZciKdHhc0GQ4QVGLD2tph13go=;
        b=bKmHz1wtlZaPTIqo1O0msWD+jrDTFJlpUmd2y2EiZpkmf7lSwkj34H2mkB5mzB0Rwo
         T72Jey0mGEA/EXHFnvlPxdB2ZINq/T/GmttvlaTpbt6u59rP7cbwNmNHCjhRrGnJGLPX
         92ut6RvctNIuFVLb6d27IGVb60H3NGGJB0d1CvHPukFZvTtoBfS8mBDW6iH38H0Bx8bz
         XgqIXTH/FKnhTturEr4UDK6UvIEGrGS5UPY51eFa/sf9so9Wzn3rQ8556iABSt+mDW3v
         lA9ORHEH9Y7xKanf3yVE+6ZJv5BqDEFFrggy/9MMAlLkjjSsFN66sosfRG7OkjVP0NQy
         CsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EMkWG3D4vA0O9hxGsfZciKdHhc0GQ4QVGLD2tph13go=;
        b=SrDFc/3NL970UpiAOfLiVFpi+aySIfU5pBFa2RhWn5q/hiszsaDd074BERmBKX1GNZ
         VystH2uU8T9XjS+EgN1IhxMQU4eaNuxKYbt870P85Kfsd3koXRJrA+RIB2gioISc9n/B
         hs8IqKsdjTqA7Pa5+BBMlg1Iaed6n1nit68Lp8FPYiZjZzru4tWAsSGU/n+vcHrqA4/T
         /PhTJxEQ6uIwJD9eRDlH+jS59h8TMl9D8RN4gbWPVIh5zSrSyPNIxNLacB7h0NunmlV5
         TNHjkPae+wEAkzYXIFXTqPa4X0LS2TzeFkRicFnKNEqbL3X63xJa1nD43mX42UFQuA0O
         YKFg==
X-Gm-Message-State: ALyK8tLbrGK4uIAOHibUjdCHw1p7pMcARgllSq/h8e27l4uBXIlpXsVfpWA3ykJ8Yj4tzjjKMbW9/4HJu2Qiiw==
X-Received: by 10.37.22.194 with SMTP id 185mr9962365ybw.62.1465890643523;
 Tue, 14 Jun 2016 00:50:43 -0700 (PDT)
Received: by 10.129.85.203 with HTTP; Tue, 14 Jun 2016 00:50:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297269>

Hi git developers,

I commit with -S argument, and I got some output like this:

You need a passphrase to unlock the secret key for
user: "Tian Zhen <tianzhen@honovation.com>"
4096-bit RSA key, ID 2EF2AD6E, created 2016-05-21

[master d107770] feat: mobile support free freight hint, closed #1417
 8 files changed, 58 insertions(+), 29 deletions(-)
 rewrite static/css/mobile.min.css (64%)


but when I check git log with --show-signature, I can't find my sign.

my git is 2.4.8, and OS is Ubuntu 14.04.4

Sincerely,
dawncold
