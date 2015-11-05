From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: About global --progress option
Date: Wed, 4 Nov 2015 21:13:20 -0600
Message-ID: <CAOc6etYiGV0v4gkkpudi3ACa6kA3H8CnqYYeSksfO4mGGfEyXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 04:13:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuAzO-0000gV-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 04:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031829AbbKEDNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 22:13:22 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36274 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031616AbbKEDNV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 22:13:21 -0500
Received: by pacdm15 with SMTP id dm15so48280668pac.3
        for <git@vger.kernel.org>; Wed, 04 Nov 2015 19:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=oCuKQNXB+sz8eKRXAvH1Fkn4GwLYo5w2uVd9reI01/s=;
        b=utxXW+eZ080tbwKIjoA+ezUq9J/RybG7mK3vmkreb5NCogEAUWUmCpa+MHORYT0CDU
         Urwwo+3d4T/2j0vDkhsU4Bw866jTq051TkaHT2+xwrWQOU9t6V2I4Sg/QMtGntnv3sIi
         D6jvYz0eeEN7Y+ZJYjgN3wd1ITL9Mt3l7LHrRwbdTg7rSh1uKIAm6KG/Qw8sjjbT5ied
         5eF4ukOjqD+wCeRWO/5Byd+AEpOZ4Sid9MRESdDYeZi6pf5gAPL9YGp8A2RnnNQAaINY
         NyLbnxUKEujYcqf79oMEPNUs0404tc8Ut0TnVbz1C+XZFxfgNfqxRjU7s2deSn1VYFFZ
         xaLw==
X-Received: by 10.68.57.208 with SMTP id k16mr6629094pbq.12.1446693200965;
 Wed, 04 Nov 2015 19:13:20 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Wed, 4 Nov 2015 19:13:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280896>

Hi, everybody!

Coming back from my patch about the --[no-]progress option for
checkout (it's already in next, J!!!!), I'd like to build into the
idea of the single --[no-]progress option for git as a whole.

So, in order to know what/how things should be developed, let's start
with a tiny survey

Which would be the correct development path?

- Two-step process: First step, implement global --[no-]progress at
the git level and also support the option from the builtins that
laready have it. Let it live like that for some releases (so that
people have the time to dump using the builtin option and start using
the global option) and then on the second step dump the builtin
options and keep the global one.

or

- A single step that would remove --[no-]progress from all builtins
that support it and would place it as a global git option?


Thanks in advance.
