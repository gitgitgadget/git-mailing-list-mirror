From: Jiang Xin <worldhello.net@gmail.com>
Subject: [ANNOUNCE] L10n update for Git 1.7.10-rc0
Date: Thu, 8 Mar 2012 11:51:24 +0800
Message-ID: <CANYiYbHrhcmURri+Lg7_K3XXhYZsjF7SkCzUsgvHgjBvgNKDAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 04:51:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5UO2-0001pQ-SO
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 04:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab2CHDv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 22:51:26 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35803 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811Ab2CHDvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 22:51:25 -0500
Received: by gghe5 with SMTP id e5so26578ggh.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 19:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=waFla7VB9OqOYgVKGbTQGGxWnJOsOvUIhAEzlKtUOO0=;
        b=l8WTTXFdGKJ4cZkLPXpp9lL1Rt4bHO4BT7v7l9xUepBsU/jyygahp1abEavok/4a0e
         eK1+q+SUxH4MXQxf9aCRaw/Z6vacNF/RI65qkVRtnbhCqllx+6nnX6P8Hhnvzd7dB4T8
         IoKFjP8Odlupg6J9dCXjNw38bNiXMwsTnDjmRT3OE2SkhQ612ivZS0f4ZWddjr6L73f+
         o9G/bb6rUcbCvbobdeW/torP4xHvjkce5N0NuXFFsvAaSP931jcA/mP2BbQK+W/O2AT/
         chqlN2KWMNrrRfWuGN4xdyY87fKDDXMzJ6vk5iNqvtjRluVvhHiY+Wcc0WclXraQOVM4
         lptQ==
Received: by 10.236.184.129 with SMTP id s1mr8992361yhm.21.1331178684945; Wed,
 07 Mar 2012 19:51:24 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Wed, 7 Mar 2012 19:51:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192518>

L10n team leaders,

It time to update your locale files to the new git.pot for Git 1.7.10-rc0.
A new "po/git.pot" file is generated in the l10 coordinator repository:

        https://github.com/git-l10n/git-po/

Updates for this new revision since last update:

 * Add 1 new l10n string in the new generated "git.pot" file at line: 191

In order to update your locale files, l10n team leaders should pull from the l10
coordinator repository:

        https://github.com/git-l10n/git-po/

And then update your locale files, make a commit and push to the forked
repository for your l10n team. Update locale file use this command:

        msgmerge --add-location --backup=off -U XX.po git.pot

        (A upcoming helper program will wrap the gettext commands, and
        make this step easy.)

        HELPER_SCRIPT XX.po

After pushed the commits with new translations to your forked repository
of your l10n team, please send a pull request to the 10n coordinator
repository on GitHub. But before that it is helpful to check your locale file
and new commits as follows:

 * Do a syntax check on XX.po

        msgfmt -o /dev/null --check --statistics XX.po

        or HELPER_SCRIPT check[XX.po]

 * Check your commit log, to prevent non-ascii characters in the commit
   log without a valid embed encoding setting. The upcoming HELPER
   script can help:

        HELPER_SCRIPT commits[origin/master,HEAD]

-- 
Jiang Xin
