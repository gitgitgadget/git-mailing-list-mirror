From: Orgad Shaneh <orgads@gmail.com>
Subject: git gui replaces amend message when prepare-commit-msg hook is used
Date: Thu, 4 Jul 2013 12:47:28 +0300
Message-ID: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 04 11:47:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uug8T-0000lh-MQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 11:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab3GDJra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 05:47:30 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:46751 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387Ab3GDJr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 05:47:29 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so1629562oah.24
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=MlhwG9eSL1Zf15H+jNycod8rI3c+VOfjaB+ssyNAIN4=;
        b=vTSphDCVUOSfWTF8nERBoPIDmJQjvkn17ILwfxtwcKge6epwwypND9iMfASJuLzO1R
         8AhcwV3tmnPpbHbeQi1K7KA0rTW9S1dPwzJubOMIsrRmh5KV0W4yBYj75HGtXrk8jWRA
         t0bPMdl4z1hT7YJXD7yGn1YrH+lVCW4iS57hK8v57/UMZ7UisFxQSZVxpsMHhGtcwUZs
         72RKotMBq+ZsgAeKNrZeVspiBCeZajsAKm1G0aCKoSL9mmU6jCvU83mZllv7JIvTJZVl
         ioWb06qMo2LmK7NLJ4b5PFj1c5GUgwTfbpVOxVVjw39T+MOZoUHYpM3zLOdCK9fUa8f3
         f2RQ==
X-Received: by 10.60.98.73 with SMTP id eg9mr5083771oeb.70.1372931248764; Thu,
 04 Jul 2013 02:47:28 -0700 (PDT)
Received: by 10.182.128.72 with HTTP; Thu, 4 Jul 2013 02:47:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229564>

Hi,

If a prepare-commit-msg hook is used, git gui executes it for "New Commit".

If the "New Commit" is selected, and then immediately "Amend" (before
the hook returns), when the hook returns the message is replaced with
the one produced by the hook.

- Orgad
