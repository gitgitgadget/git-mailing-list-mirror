From: Rich Midwinter <rich.midwinter@gmail.com>
Subject: Use of a mailmap file with git-log
Date: Mon, 10 Dec 2012 18:22:49 +0000
Message-ID: <CALKB1SXdNVsQop5VYmShOMx93+j5SPdkGF9yNU5k7nXg87TwMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 19:23:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ti80Z-0002NJ-Jm
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 19:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab2LJSWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 13:22:52 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:64021 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2LJSWv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 13:22:51 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so2169443lag.19
        for <git@vger.kernel.org>; Mon, 10 Dec 2012 10:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=oKHMLCHMubBfTUA+xDc3eR9BcSvdF/yosytgKkBhADU=;
        b=pmNo+ewq/aGbLMRNUzDh+BqDbroCSim9Y2427hE1mwhyRQuAffx3rT2V2ZJR60jkIn
         ot6AzescatNX/B9OjGNlf5UWy3GpE/GrgyIVrX1QT78p5V0b8yS/k3kIhG1o7YF3W1w/
         7cAM5orM13nGVvWmLwsdaBe0dPqmZFR3GPRU6gQk7XgiOv/4qSoAY83h2PW08jU9/Ff8
         GLOfoCDzKMpsCwKq4TP7ZyNXGodRft5BX435gR5CwmYxc01ZZnwkxa/04bl2NxKw5BcF
         dflNGnnt/bE/ghGNppiNUzNkROEdGOEcttdqw89/+2JBVMpeV1oqlQexXFuOXO8LO4z0
         BhLg==
Received: by 10.112.28.98 with SMTP id a2mr6382797lbh.110.1355163770042; Mon,
 10 Dec 2012 10:22:50 -0800 (PST)
Received: by 10.112.99.130 with HTTP; Mon, 10 Dec 2012 10:22:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211267>

Hi

I'm working on a project for a large organisation that wants to make
widespread use of git and the mailmap feature.

This seems to be supported by default in git-shortlog but not git-log
(and other variants) without specifying custom formats, which isn't
really something I want to try and 'fix' across the organisation. Is
there a reason for this feature omission or has it just evolved that
way and could it be fixed?

Thanks
Rich
