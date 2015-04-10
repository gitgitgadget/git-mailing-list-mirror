From: =?UTF-8?B?S29ucsOhZCBMxZFyaW5jemk=?= <klorinczi@gmail.com>
Subject: Suggestion: git submodule remove
Date: Fri, 10 Apr 2015 13:33:12 +0200
Message-ID: <CABEDGg8Gos8UTi2U_xgMpx2dJtbtSNCCd2gRr_KR1qESB6gYYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 13:34:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgXCF-0008T9-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 10 Apr 2015 13:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbbDJLdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2015 07:33:54 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35282 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbDJLdx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2015 07:33:53 -0400
Received: by widdi4 with SMTP id di4so124731160wid.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2015 04:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=eiM/qP2om8uOatmGqRpRnvv8NqZyD4Ews7pe/4HXtgQ=;
        b=mcgHPLR33BkBUQ8Os7fxV8ltmTvho1Djwj8PjCcOZumMVxSXbLtJMnUDnMtzIyBWBC
         8Clp7QaUhiPMXvANOhU+0JGk0lF4kDBVeoJXlPdsgNKi84JHj31WCKEkvcUZupJqBr0W
         ERyZjFORgU476bEmRcTPouiLv8qn57C3o0VvY/uVJvIVEINzoMo6bh+r/pkPWbkVjElA
         iNU/MoYViZYvbUwgEIlixl+L5DUXZihfDaZcq+d7VMMYSpMZozH+hu0rcfSr4Gytx6+a
         yr7y6D7C6dPeimsukVZ/ME46/Vr2z1vRjGLxPAbty7AmPwhN0JhAyMm4du6zRsK+vk9/
         5Fqg==
X-Received: by 10.181.25.225 with SMTP id it1mr14415768wid.8.1428665632361;
 Fri, 10 Apr 2015 04:33:52 -0700 (PDT)
Received: by 10.28.0.3 with HTTP; Fri, 10 Apr 2015 04:33:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267009>

Hi GIT devs,

I really miss the
  git submodule remove
command.

This should be handle all the tasks what are needed to remove a submodule.
    - Delete the relevant line from the .gitmodules file.
    - Delete the relevant section from .git/config.
    - Run git rm --cached path_to_submodule (no trailing slash).
    - Delete the now untracked submodule files.

These tasks should be handled automatically.
Currently you can only remove a submodule manually, no way to do it
automatically with one command.
"Removing submodules" and "unsubmodule a submodule" are still a pain
to do in GIT, even in v2.3.5.


Please consider implementing the "git submodule remove" command.


Thanks,
Konrad Lorinczi
