From: =?ISO-8859-1?Q?Alf_Kristian_St=F8yle?= <alf.kristian@gmail.com>
Subject: git stash list shows timestamp in stead of "stash number", when 
	setting date = local for log in config
Date: Tue, 15 Sep 2009 16:56:41 +0200
Message-ID: <49578b170909150756k3c19912dv28615053a6bd0f7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 16:57:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnZSx-0005YE-9f
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 16:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbZIOO5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 10:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbZIOO5A
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 10:57:00 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46269 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518AbZIOO5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 10:57:00 -0400
Received: by bwz19 with SMTP id 19so2851677bwz.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 07:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=ihFUOWmN0zLCXp5hQ2gzLolUxgh+qrVnN+Cm9hWbxng=;
        b=Qi2H4z/XUsTFQYeN649dJiRjXygOePzd00LX2Rl9nWmILh583pJTWJLxV6BT0Sw0ak
         HuRRpVLe0QtvOia3qx9M8dve7sU+CJIup1W4vWqwKoYXEBN1gKJdv+gKOuJBMCKSFXie
         nDua9Pp1gBJJKGh+ZtKBPl66H3xkFA6onRKUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=EYmELdFZtTAUoNHblnMOdduAzRRIzV2tlo0QqqGCWbzT3dMdABUbfIcljK0274SZQH
         wPm0F1xO33+4nGr920W/FatRW6JSeT+IesERm3RbPppkjnIl2ROzrBjiTT1/3q+7J6kE
         iJnUy5/qE2sj1xxrDYlwUS4aWfZc+AK2eOvJU=
Received: by 10.223.74.91 with SMTP id t27mr2633697faj.62.1253026622250; Tue, 
	15 Sep 2009 07:57:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128569>

Hi. Searched the lists, but haven't found anyone reporting this problem.

When doing a "git stash list" I get this strange stash record:
stash@{Tue Sep 15 16:28:12 2009}: WIP on master: 2262276 ...

I have a global config setting on log:

[log]
date = local

If setting the date config to default or removing the setting, the
stash record looks correct:
stash@{0}: WIP on master: 2262276 ...

I might be missing something here, but I do find this a bit strange.
Is this a bug or a feature, and is there a setting I can use (for
stash) to always show the latter line? I kind of like having local
timestamps in log.

I am using git version 1.6.4.2 on the Mac.

Thanks
- Alf
