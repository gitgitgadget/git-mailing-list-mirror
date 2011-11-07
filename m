From: Jack Nagel <jacknagel@gmail.com>
Subject: pretty placeholders for reflog entries
Date: Sun, 6 Nov 2011 23:49:48 -0600
Message-ID: <CAMYxyaWPWVGUHz0qQOnARb9wexHCx73a04Bu_UhrJR=xrinX7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 06:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNI65-0007hk-8W
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 06:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab1KGFuL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 00:50:11 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52465 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab1KGFuK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 00:50:10 -0500
Received: by faao14 with SMTP id o14so4763491faa.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 21:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=Agadf8g0LUKjw1IEV9VZZnGwOvY/I1Mxdz36AhkNEv8=;
        b=sfEu0Z3LKKa4pO2DkaVs4s1opLRWTVqRcsmpMczrC8K34B1kC+YjnFeO5uRZZekY3z
         cqic056yWx+EZvyJ10MCQt2yc5wcG4qswK9TjKAnBjYxSBCaqb9R7C/mvmeukN0oiJAi
         M8MI1qv938mLmi/u+xo8QkQk38ZfiPzKGejp4=
Received: by 10.223.17.23 with SMTP id q23mr44577826faa.11.1320645009161; Sun,
 06 Nov 2011 21:50:09 -0800 (PST)
Received: by 10.223.72.1 with HTTP; Sun, 6 Nov 2011 21:49:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184951>

I have the reflog enabled on a bare repo so that I can have a record of
"who pushed what, when". I'd like to define a custom pretty format for
use with "git log -g" for reading it, but unfortunately the placeholders
for reflog information are somewhat limited. In particular, I'd like to
be able to access the identity (i.e., name and email) and date from each
reflog entry.

Is it possible to extract this information in current git? Perhaps I
overlooked something.

I suppose it would be simple enough to just write a script to parse the
reflog file(s), but it would be nice to be able to do this with git
itself.

Thanks.

Jack
