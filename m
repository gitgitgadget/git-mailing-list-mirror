From: Rick Olson <rick@github.com>
Subject: [ANNOUNCE] Git LFS v0.5.0 - Large File Storage
Date: Thu, 9 Apr 2015 00:44:27 +0200
Message-ID: <CAAz9cr4vxjWdXeDw0VsgyzB1krGTR9V9M3xYhKsmdD2DHKkhMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 00:44:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yfyi2-00078T-K7
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 00:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbbDHWoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 18:44:30 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34265 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbbDHWo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 18:44:29 -0400
Received: by wgbdm7 with SMTP id dm7so103059497wgb.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=xCcJxhEm6u/Evbxu1akGQb3vVhCCG7EYb7DWdsSiKSc=;
        b=SKnc9RB9TfLQ36EYOkyB9QrEGw7S61r9mXRtaU0PW85UJICP2OwgjRFfysYOZ0fgcp
         l4yJkz/IPGiWd8PhnLMi6QkUeMX8h72UeAA1af8Qz3q1jY2Nl3S3B9tpYyI5ncJt86w+
         DbsqiQa4m3oTNoBeO15Eq1ghNqA4ObpS46A2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=xCcJxhEm6u/Evbxu1akGQb3vVhCCG7EYb7DWdsSiKSc=;
        b=nIY5JWLqQzkoOvI9+phFe9v2eY3A2+HaqKa1D3vnkbatRHAIT/CMgzgEnInWN/Gp+Z
         DlVo2ROObfxmWM7MP2b9F3NcDF6LqojFSFn83JwYj2RQyYrIZAETW56pAGuorvvoPw+0
         CzqKAc5lxj+QmZ6Ak2kjhsGK7Da55kDbk4ET3xlWXUnFkWVzoBIcq/9wPwBYQFVdaseM
         0b7EE2rd+FkCZjY80i6/dfJPvIzHm4RbIOc7J6i0c+VyMI9FqjNlG4DSO2aZ4G+4yRuT
         z+9ateI5OsiHazkXXdnxvUIeyKnoxn8J2W1R39Csp5fB1ENq75Dsyhd18p6dOSy0NI6A
         pDFw==
X-Gm-Message-State: ALoCoQlC6LKKvuvGeSmqly9Q4NV42nZNf/pEfTx8Kr/8C3I820peJgK8xJj2t89za9tYef8QHNn+
X-Received: by 10.180.95.102 with SMTP id dj6mr836000wib.45.1428533067996;
 Wed, 08 Apr 2015 15:44:27 -0700 (PDT)
Received: by 10.194.70.38 with HTTP; Wed, 8 Apr 2015 15:44:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266976>

Hi,

Today we're releasing Git Large File Storage (LFS), an open source extension
that replaces large files with text pointers, while pushing the contents to
a Git LFS server.

    https://git-lfs.github.com

It's similar to Git Media, with a few notable exceptions:

* It talks to a Git LFS API.  No need to configure different backends
on the client.
* HTTPS and SSH authentication is supported.
* It's distributed as a static binary for Linux, Mac, and Windows, no
compilation or runtime needed.  The full source is provided with an
MIT license, so you can also build it yourself with Go.

 - Homepage: https://git-lfs.github.com
 - Download: https://github.com/github/git-lfs/releases/tag/v0.5.0
 - Git URL: https://github.com/github/git-lfs
 - API Spec: https://github.com/github/git-lfs/blob/master/docs/api.md
 - Reference Server: https://github.com/github/lfs-test-server
 - Git Media: https://github.com/alebedev/git-media

-- 
Rick Olson
