From: Adam Mercer <ramercer@gmail.com>
Subject: Getting the commit that corresponds to a specific annotated tag
Date: Fri, 1 Jun 2012 16:47:43 -0500
Message-ID: <CA+mfgz2=ZFBetSGv1Bkq6orBbpVTS1k0gLVm0nGoR1sUDkDwqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 23:48:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaZht-0000zG-21
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 23:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933395Ab2FAVsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 17:48:24 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39983 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932925Ab2FAVsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 17:48:24 -0400
Received: by ghrr11 with SMTP id r11so2486400ghr.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Q6R34v9Tmp19tYSmP4TmPsm39af9bzZh+c6ZSjjAhjk=;
        b=sK7m+BIG5drhV6nDL4oltNz6Ot+qdUr+Tn0hxmGBGQhK4qWeV+UhwWjx2rEFeUz7/6
         /tv1pFrIROWOjUBjIUZoT9KNfdZOn7hGYA6R9w41TaEwMZZXrnVoUWU7YlBRGi0R9bHN
         bKwSNvsPVgPi1w1dyj3e+wCJhemnkOOsK75en9Acb0T0QfRogMh9M0iQc2Y842wm7xFz
         eXts+qkxI4xxIaEPTxa+xLp3LkivaU3GgiwCMZ0aAdow2yVHM5AFk1WnK6MLH9RamHf1
         U5xbQOvDr9nWM3hb0+mp+4BwFu/nGqFPBK5WS3IdwMccAwxJGze7d5nO+pgGXOKvxwRf
         CGPA==
Received: by 10.101.165.15 with SMTP id s15mr1283248ano.36.1338587303622; Fri,
 01 Jun 2012 14:48:23 -0700 (PDT)
Received: by 10.147.97.23 with HTTP; Fri, 1 Jun 2012 14:47:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199025>

Hi

For some porcelain I'm writing I need to determine the commit that
corresponds to a given annotated tag, so far I have the following:

$ git cat-file tag <tag_name> | grep object | awk '{print $2}'

Is there already some pluming that performs this task?

Cheers

Adam
