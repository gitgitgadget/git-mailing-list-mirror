From: Eugene Sajine <euguess@gmail.com>
Subject: You have local changes; cannot switch branches error question
Date: Thu, 24 Dec 2009 17:25:37 -0500
Message-ID: <76c5b8580912241425k741b24e9ie8ed92ca7cb8a659@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 23:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNw7s-0006eb-46
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 23:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899AbZLXWZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 17:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585AbZLXWZj
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 17:25:39 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:64634 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbZLXWZi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 17:25:38 -0500
Received: by iwn1 with SMTP id 1so5979861iwn.33
        for <git@vger.kernel.org>; Thu, 24 Dec 2009 14:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZK43rkRJa8phIVv5MYrQfNExLala9ejdhjRdh/V3FBI=;
        b=M/EXfL3srLBvThWjpR3Zib4sUoWDYQo4CcGHzXjkJMHHfNqyWcNYjqxTuVp2OykPvO
         d2GO3IcRTGmloMrmdB8C6kdn/4wWNXlhXbrwwuXCmCm2D2rxXR4Ff7/nN1WPZs0CiFJt
         eO6Hvv4A7l2HH+mhrsn+DpaiVExB0JYXZHIPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=T1T2gHWaT4F3zSHJh88YJWQZB4LmGZox893puqyYQhHUWXn8fRPRY771cHjXxhbeqt
         Jq/5e76ayl2FHyOdO+teS7r4OEANN8jsnPeSUPExlgQxRI9po/Rf7ZORTPZZA8C8DwqZ
         qregUC/NZTheYNans3pAV+h1NvgkxD8MbgZNw=
Received: by 10.231.48.210 with SMTP id s18mr2593153ibf.3.1261693537631; Thu, 
	24 Dec 2009 14:25:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135661>

First of all Merry Christmas and Happy New Year to everybody! I wish
Git to move to global dominance during next year even faster then it
does now;)

My question is related to the fact that most of the time when i have
some local file changes Git is switching branches OK. But from time to
time in some repos I'm hitting this error and I cannot figure out why
it suddenly starts to complain about it?

For example in one of my repos I somehow got to a state when I have
three files modified, and when I'm trying to switch branches it
complains about one of them being changed locally, so it refuses to
switch branch

OTOH i have tried many different scenarios in another repo to leave
some uncommitted staged or not staged  changes and switch branches and
same version of git does that just fine. (v 1.6.5.6).

So, what is correct behavior - do not switch or switch branches when
there are uncommitted changes?

Thanks,
Eugene
