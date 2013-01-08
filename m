From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: git push --recurse-submodules=on-demand with submodule push tag
Date: Wed, 9 Jan 2013 00:35:58 +0800
Message-ID: <CAHtLG6TDqqG09WBkuWzGeWUGog6GOrWQZZtbF5xx_m4ishvzyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 17:36:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TscA3-0007zS-BH
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 17:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab3AHQgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 11:36:01 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:42615 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab3AHQgA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 11:36:00 -0500
Received: by mail-vc0-f175.google.com with SMTP id fy7so576703vcb.20
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 08:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LYfi6rjGH88KW3fRMC8Wd/7yrlfpe5vs/bEH2rIfK5c=;
        b=w5xfCaGLY0A1aX91edvGU3zR0ZJCGjMz4e0Dt238YcR4zIeKfAwY0Z0hZi9KsCtbES
         Z4JxvapoNvk9w0nuUfO4ha1qs1vf8vpjv4q5AnjiNqKeBosS+NV5HP3vTmeFeeVvicle
         rUV5E1B+kJHJK94h/bkZI3PCtCT3ncwdTSeb2EnfkTGycWrXhtwjAt42Cz+us8LQgEAf
         bj3vYZv6MeDSYeveiN85BauCi5K2McHE7T07E4Y/w3Io2K1nQVzmEMCPtYBynfxDkE8q
         Iy/xZrUzyINfBF4iOwNOsRYcB8lsPIhZqVLX0QEZGinZgoS2yHp4etTHcEaRi2B74oGa
         4m4w==
Received: by 10.52.26.229 with SMTP id o5mr75895429vdg.66.1357662958786; Tue,
 08 Jan 2013 08:35:58 -0800 (PST)
Received: by 10.221.6.201 with HTTP; Tue, 8 Jan 2013 08:35:58 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212974>

Hi,

In superproject, can I call git push --recurse-submodules=on-demand
that pushes submodule with the submodule's tags?
Very often I change version and tag the submodule
and change version and tag the superproject at the same time.
