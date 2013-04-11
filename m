From: John Tapsell <johnflux@gmail.com>
Subject: git log -p unexpected behaviour - security risk?
Date: Thu, 11 Apr 2013 11:36:26 +0100
Message-ID: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 12:36:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQEs8-0007KG-Bx
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 12:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab3DKKgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 06:36:48 -0400
Received: from mail-ia0-f174.google.com ([209.85.210.174]:52144 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3DKKgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 06:36:47 -0400
Received: by mail-ia0-f174.google.com with SMTP id r13so1251200iar.19
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 03:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=b8hdH7fMaQj3UKtH6giqCqRmLl4gG5gqA+X1n9zK4fQ=;
        b=BVr44cU++nKIgOa6aT27GE0d6Haoi82v5xoS7u+PomTkCcI08ZDuUlgX7USAL/vyD9
         cpXm5V/Fb1+IPAl3jvU6qtXKpN5BrWj8seEU7rwldQClhzBMSB6zuO81adwlApBTHgSY
         0UF6XOIquicCwyPhMUD6rQypihxDALRO/+26k/o9pBvwjj85UIwIUs8av1Mnc/ULvfKr
         jTjbAzmWjJ9euJ96nSohF4IP+6CobH1PXuOhGzHN9uFpv5qehpxzHSjeEk5LZVrmsmRg
         6eNLxxyNcumMkIXKLgQMM+ufztBxBvgK9A+kNtiT19GpPPYtUGTVcZHN/qLheEOWJkpF
         olZA==
X-Received: by 10.50.171.73 with SMTP id as9mr4177419igc.23.1365676606944;
 Thu, 11 Apr 2013 03:36:46 -0700 (PDT)
Received: by 10.64.18.168 with HTTP; Thu, 11 Apr 2013 03:36:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220842>

Hi,

  I noticed that code that you put in merge will not be visible by
default.  This seems like a pretty horrible security problem, no?

I made the following test tree, with just 3 commits:

https://github.com/johnflux/ExampleEvilness.git

Doing "git log -p"  shows all very innocent commits.  Completely
hidden is the change to add "EVIL CODE MUWHAHAHA".

This seems really dangerous!

The evil code only shows up with the non-default  --cc or -m  option.

Is there a way to make --cc default?

John
