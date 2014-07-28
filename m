From: Duy Nguyen <pclouds@gmail.com>
Subject: "error: Tweaking file descriptors doesn't work with this MSVCRT.dll"
 on wine
Date: Mon, 28 Jul 2014 17:39:32 +0700
Message-ID: <CACsJy8DFvTHieQc-nZL2h7JbQYc4Qkbx+Ouc297VpNeU=kNaoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 12:40:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiLg-0001m7-2T
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbaG1KkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:40:04 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33720 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbaG1KkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:40:03 -0400
Received: by mail-ie0-f180.google.com with SMTP id at20so6462628iec.39
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 03:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=jeCS4ZXhXRGROEtbUCa6kSbmayykGp1pzLYHlh6VeQU=;
        b=pnrQ2/ldu/r/jRFwgk+UXQLe4D0pYMTbFvFLqof2+J+sWMMNryiX+YIgVmrksvBwiX
         p4J9vnnjc5RGnKfhIu6i+v6MHumgJBsJDaaGwG16MlaaU7DzRMhU4rv13qwOddtlCaWI
         T9lzMugfNpW35tnaD+qmh2MOUcUbWa5EdwbqpmFEgDNnQBrHgB5YmGFWzdP5LtYLHvjY
         KoO3Efhpw9AkNYDNo3pPrWGKueSb+ETYBdcb7fl/ty1YtorW7271PcR+9yOyGFr8mZCX
         aAVRZxusfVDMx1QkyBL7hSAHHulLKK7DPUjvdlJ6DS6fxB78sksRXnbDLrNNgHd0de8y
         gy1g==
X-Received: by 10.50.114.226 with SMTP id jj2mr31386448igb.27.1406544002482;
 Mon, 28 Jul 2014 03:40:02 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Mon, 28 Jul 2014 03:39:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254298>

I know wine is kind of second citizen but is there a cheap trick to
make it work on wine? Reverting fcd428f (Win32: fix broken pipe
detection - 2012-03-01) could result in conflicts in compat that I'm
not comfortable resolving. I don't have Windows at home. Wine is the
only option for me (or if somebody has a modern.ie image for KVM, or a
simple recipe to make one, that'd be great). "Fix wine" is not really
an option.
-- 
Duy
