From: =?UTF-8?Q?Bj=C3=B8rnar_Snoksrud?= <snoksrud@gmail.com>
Subject: Minor bug with help.autocorrect.
Date: Wed, 19 Aug 2015 12:35:28 +0200
Message-ID: <CA+cck7Ex4UO9BAzZ1kq5jw1vYqFb+mbzNQh-RvYAvK5v2T4G0g@mail.gmail.com>
Reply-To: bjornar@snoksrud.no
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 12:35:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS0iU-0003PL-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 12:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbbHSKfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 06:35:30 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35421 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbHSKf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 06:35:29 -0400
Received: by ykbi184 with SMTP id i184so486968ykb.2
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 03:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=jQfSuaoUu0oe8wn1guk970xlN0SoENyH64YTcBE4isc=;
        b=v76XnhBJwM3FPk2QMJF/5FXSUPJ9jKwTwspIEWfd7oQ8HP+pHs0h3A3Yj2eoeu9+zu
         oy8yXsbRYiFqgNPDbm4jweE5OSgG3NvnK3a/XO1hrkSqpy2rzJ7sNlG6ArBtelSXtNS5
         pxQuorRmjNDGgYr7+2s9OQUIlVgp66h3kC+wGq1XmqrHm1Ro1GUxzeXkIHGydsOdGNUH
         rFBLF/G0RoJ81V5yDcUCRVHeuP5b9vrpchBGJqAyUxtYv+T7OZ9szptq22/fycIPhbY5
         GiUfMqXmNlosAtP1M047CQRHPeLdSNjwjuxt5PE4S0bO4B8fiT+rGMpPompnA9QfG9bz
         0cUw==
X-Received: by 10.129.138.129 with SMTP id a123mr12514157ywg.139.1439980528952;
 Wed, 19 Aug 2015 03:35:28 -0700 (PDT)
Received: by 10.13.223.76 with HTTP; Wed, 19 Aug 2015 03:35:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276167>

If you mis-type a git command starting with a non-letter, git
internals will spit out some errors at you.

$ git 5fetch
error: invalid key: pager.5fetch
error: invalid key: alias.5fetch
git: '5fetch' is not a git command. See 'git --help'.

Did you mean this?
        fetch

$ git \#fetch
error: invalid key: pager.#fetch
error: invalid key: alias.#fetch
git: '#fetch' is not a git command. See 'git --help'.

Did you mean this?
        fetch

-- 
bjornar@snoksrud.no
