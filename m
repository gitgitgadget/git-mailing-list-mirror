From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git-tag documentation enhancement
Date: Sun, 29 Jul 2012 20:33:24 +0800
Message-ID: <CAHtLG6SQ3DeexriXRtV4ys7x12iKQtq7OCrZdC+A8SSH6Tokow@mail.gmail.com>
References: <CAHtLG6TDDmvtt1cc3_mGG9hZtSVp-ecNXzCQrPj6-e4DU6HMGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 14:33:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvSgd-0000rR-BM
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 14:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab2G2Md0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 08:33:26 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58026 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752316Ab2G2MdZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2012 08:33:25 -0400
Received: by lahd3 with SMTP id d3so2974112lah.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ZHQdHyd/euk+RnfxWaJ6fpjOm1NSkecw9ShPHjtrgFY=;
        b=k1dyLramMV3UZGwAgGg9MgUlahASKNLBezl/8DplRgmDi7GWRbO51oITbdRwNUb3SU
         gfmOkfVZDeC69q0zVoxz3p4eJI4ZmDJbbgvfolReQTXVyPZuGyrbTRs0Y7h49P1ZCqjM
         484CAk4pWNTNpX9x50iDxwGgarC9Kriz8EXS5Dw0xD9Iyy3r6OmmMifF+xPJ8YGRWyFL
         57sljvFIk0MJcLNGflHTCivpbXtv2XOOpIxo6tblWi8hApLcOP+jBGtKmiqPsXy7xpGs
         K3dH+TFVv5MTEcW93jULn2ahcGIfsDSC1bBGODvvU0MFgRwq5Gu6F77yytx6AH5lROX6
         rhbw==
Received: by 10.152.132.233 with SMTP id ox9mr8274560lab.25.1343565204506;
 Sun, 29 Jul 2012 05:33:24 -0700 (PDT)
Received: by 10.112.42.72 with HTTP; Sun, 29 Jul 2012 05:33:24 -0700 (PDT)
In-Reply-To: <CAHtLG6TDDmvtt1cc3_mGG9hZtSVp-ecNXzCQrPj6-e4DU6HMGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202476>

Dear Sir,

I would like to enhance git-tag documentation

--Unless -f is given, the tag to be created must not yet exist in the
.git/refs/tags/ directory.
++Unless -f is given, the tag to be created must not yet exist in the
.git/refs/tags/ directory or inside .git/packed-refs file.

Regards,
ch3cooli
