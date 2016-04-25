From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/3] travis-ci: express Linux/OS X dependency versions
 more clearly
Date: Mon, 25 Apr 2016 00:40:12 -0400
Message-ID: <CAPig+cSoWqZhQY8asE0akgSKqaRbU0pd87_mjA5kBdEueUZBrQ@mail.gmail.com>
References: <1461524292-20490-1-git-send-email-larsxschneider@gmail.com>
	<1461524292-20490-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"sschuberth@gmail.com" <sschuberth@gmail.com>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"ben.woosley@gmail.com" <ben.woosley@gmail.com>
To: "larsxschneider@gmail.com" <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 06:40:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auYJv-00054Q-Uh
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 06:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbcDYEkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 00:40:15 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36669 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbcDYEkN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 00:40:13 -0400
Received: by mail-ig0-f194.google.com with SMTP id c3so2486396igl.3
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 21:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=H4mioa+LaBJFwBLpzuZm3yuePlpyMEmZHcSF1hIglkI=;
        b=mUUfp9gT/jlt795hHmst9T0+WhU2uBXKx7uiVxma+q3CFKB/843XafgOZp1zDW+n1a
         oPxGfyjia16mUINrazloEoJTIwTwXml8rgf/Rr0Cdy4ixW81F7ILU6WH9O2fVeFrrDwL
         q1n9xW8wO/KRrDD0mFktoN45MsIi6vJPZFymJvrjRJmytljoJZPnQrsuplj+htRwex47
         0kMTZUGjPW8P1z07hhbDEypdoCcaX9Qh8ZyupfcFYcmfxAHi7Xdp4tPUMbwI3tmNkBFu
         5xKcwVuXtxT34Zr2wZpmH6OjptxBM+0jheSXcXYw79i82OwNmWMZSj8Dy+zFMcH9whd1
         8YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=H4mioa+LaBJFwBLpzuZm3yuePlpyMEmZHcSF1hIglkI=;
        b=Q9reUr12eYfFBgPMxi3fxCVhpXuvs62UIvHNHMk2wdY3crlQPJNMR5cBE++9OlFt/8
         ftgknuQOJh95YV+dXdJQHpn6G3OZJ884S4JJV5d9m/iv20x4cDujQX7yX14YYxA0GOMu
         MdvBH8q2O+s4Qy1BdjKrwyF3ao3UZ5w3q1yZXbeFnQqzv13s3q7kYp4CAQB5GpM/nM0L
         2udBGZuVEmRRXRyadYaV/5LvfjroGAqWuOMqcn1O73ievtII5pG1up1ASfrjf7RiW4l5
         8HXdna8eniqKm6IqQ8xanY4BWdxbW3frKF0H6+pyzfoAUEDV2wLQYlK3s6SHbAS33Nrf
         +HUg==
X-Gm-Message-State: AOPr4FXTvxz7lOvDUYa8aRiMHBX4hgrMq5u6wNpVkmk/bS7nkmUieL21tI4+ZXEPuSzg7bjkWa6evs8I9qs1/g==
X-Received: by 10.50.36.9 with SMTP id m9mr10558914igj.91.1461559212821; Sun,
 24 Apr 2016 21:40:12 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 24 Apr 2016 21:40:12 -0700 (PDT)
In-Reply-To: <1461524292-20490-3-git-send-email-larsxschneider@gmail.com>
X-Google-Sender-Auth: zPJEJKXUnn3THs1Bxq29oclDP_A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292449>

On Sunday, April 24, 2016, <larsxschneider@gmail.com> wrote:
> The Git Travis CI OSX build always installs the latest versions of Git LFS and
> Perforce via brew and the Linux build installs fixed versions. Consequently new
> LFS/Perforce versions can brake the OS X build even if there is no change in

s/brake/break/

> Git.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
