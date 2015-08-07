From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: feature request: better support for typos
Date: Fri, 7 Aug 2015 20:12:10 +0200
Message-ID: <CAN0XMOLDamBeWswDi0cn_naZ2TX+gd89+g48zNwPPKxTh+ZTww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 20:12:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNm7t-0006m5-Lc
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 20:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946037AbbHGSMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 14:12:13 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36828 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945911AbbHGSMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 14:12:12 -0400
Received: by wicgj17 with SMTP id gj17so70885851wic.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=DGyl8DOztSm9uhZfupHT29bkNArzCthtutgYOVyVZK4=;
        b=kNy5UxK6tAHO1L0QMCLRbvvTDtyibD8l6xNbw2F5JBa2R4IMc0hMzlyKWC2eVNvy60
         dFF1P0oXDJtwuSj8DN/ldFl/vatF7B/CdxNGbqW7O6CEsznajmUaKP7V79VkQ3JkpDty
         4a9W9ugE7vy1tW1lczdIRTaVYOg/i6DhTXjivXmzpJdCtL0uuzK9VR2l8mvy6SXc95da
         bgs0HmjVuBYely5lN6A4p821Gx5cWLJxBReurL+lqH5jwdEzALtmKGIqHuBg6qv+u6yf
         tJAZOoeYA2QVuc6mbN/G+7SvidgA4RL0ofK8KZl8D63LFm4yKny7afanRgV8X8jkSEsx
         veNg==
X-Received: by 10.194.92.143 with SMTP id cm15mr18506549wjb.17.1438971130879;
 Fri, 07 Aug 2015 11:12:10 -0700 (PDT)
Received: by 10.28.5.85 with HTTP; Fri, 7 Aug 2015 11:12:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275479>

Hi,

when a user made a typo, Git is not good in guessing what
the user could have meant, except for git commands. I think
this is an area with room for improvements.
Let's look into branches. When I "clone --branch" and make
a typo, Git could show me what branch I could have meant. It's
the same when I try to merge or track a branch. It might even
be possible to show suggestions for options for all Git commands.
What I'm trying to say is, there are arguments with a limited
amount of possible values that Git know, so Git can show
suggestions when the user made a typo for such an argument.

Ralf
