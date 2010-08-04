From: Eugene Sajine <euguess@gmail.com>
Subject: git merge - "both added" conflict resolution
Date: Wed, 4 Aug 2010 16:18:30 -0400
Message-ID: <AANLkTi=Hp6DsE75XbgehS2bucp-M9NXmGgYbvw0kp6j8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 22:18:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgkQH-0001AD-Mf
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 22:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934193Ab0HDUSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 16:18:37 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:54656 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934686Ab0HDUSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 16:18:35 -0400
Received: by qyk7 with SMTP id 7so1563453qyk.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=UC5ebXR7qCvJumWiBk50jyw5LwPHTHUgkzyWmIgZVqQ=;
        b=boH1BaswifiKzww6G1eY7ZYYx+e8eRlhV3g2OxcmdSIQURAR/HOVHRBUOb1YF21yB4
         WcplB6H6+dlkNOcAdhl+HW0tphKG3yBdQzokh9gZymlyfmsWC4+5HAhjmX4MAHpOklUA
         2KB3FLPFisScC0rYAdJC9wMJ8z/42nZQc6oOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=AV1RN0R1XCEVJg8yvI18kiec/wSW+/jXj+ahmfRJxOx5rGL+JAUvaTOiyc/fBJmuXK
         BLy4mEb8Etdk95pEz+8HIMZX+w9iIkfV42sDVB8PEVq/pgAqv6zQPnD0Okr09HdAmHfF
         Da0My7F5Fy5yhKU8AMlL9cLac2z5bwqa1O2aE=
Received: by 10.224.80.203 with SMTP id u11mr4162589qak.127.1280953114022; 
	Wed, 04 Aug 2010 13:18:34 -0700 (PDT)
Received: by 10.229.48.205 with HTTP; Wed, 4 Aug 2010 13:18:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152600>

hi,

I'm trying to merge two projects into one. Both are having different
and simple set of files inside, but both have build.xml file.
Let's say i have source repo with master branch and dest repo.

When i'm trying to merge source into dest it all goes well with an
exception of the build.xml file - it has conflict. The conflict is one
liner and is easy to resolve, eventually i want it to be as it was
before the merge.
First of all, after the merge git status gives me message "both added;
build.xml" not both modified, which is understandable, but i have no
clue yet how to work with it;)

Secondly, when i resolve the conflict the build.xml returns to its
last committed state of dest repo, so git cannot determine any
changes.
Therefore, i cannot execute git add for this file and i cannot commit
my merge results, because git sees it as a partial commit.

Any ideas?

Thanks,
Eugene
