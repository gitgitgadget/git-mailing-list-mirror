From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: first para of man gitignore should refer to 'git rm --cached'
Date: Mon, 8 Nov 2010 00:07:48 +0530
Message-ID: <AANLkTim=QCcJDb0600Je-jePvXSXfFMe7FAQ0WMhZKn7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 07 19:37:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFA7m-0005S9-KP
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 19:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197Ab0KGSht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 13:37:49 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45853 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab0KGShs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 13:37:48 -0500
Received: by ywc21 with SMTP id 21so2964961ywc.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 10:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=JoEB3uukWuoeQiVOoXnfsiPfsoMBCx7XqRUQF3ClL7c=;
        b=OuZvmHYf/rjLFcepnASneKkfvhErK7XPFamiV9QdAK9D4PoFJr1DCSAdnwbCs/Vc3H
         ZgPet51aHNAoeyobzj3CK+TBhM2aqpLbHODEXDoYni7xL4bnQzj0cKAxCD+sgpL4JHhx
         ubgb5O5eS8Wsr2y0OtOEf+LPejdqElAuO9EBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=jYF56x6zCb6jriXMMLYLAhRQoSjuUh0EpMk4Q098N0qCCiZpWgfJ4dYkenOssSu1dS
         dX50Rs8C96iPFmyfWn/2exIJqCqwNjUzf11qusr8g+B7EdVVwFMUf93sSQqp7D73QeHo
         qxDYPnOkNcSfK15opQWvsltusHS7cnr0Zqi/0=
Received: by 10.90.23.27 with SMTP id 27mr4196328agw.39.1289155068100; Sun, 07
 Nov 2010 10:37:48 -0800 (PST)
Received: by 10.90.52.8 with HTTP; Sun, 7 Nov 2010 10:37:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160895>

It's an FAQ that "why doesn't my gitignore work" when the files in
question had already been added earlier, usually in error.  The most
common remedy, I believe, is "git rm --cached" followed by a commit.

"update-index" does not seem to be the right answer.

Thoughts?

-- 
Sitaram
