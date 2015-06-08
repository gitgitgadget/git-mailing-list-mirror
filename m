From: =?UTF-8?B?S29ucsOhZCBMxZFyaW5jemk=?= <klorinczi@gmail.com>
Subject: Suggestion: group files in GIT
Date: Mon, 8 Jun 2015 10:50:43 +0200
Message-ID: <CABEDGg8-B1QzkDas1dCcC7QivfOJuaGydki3OpON2T2WFVttFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 10:51:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1smJ-0004hR-Da
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 10:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbbFHIv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 04:51:27 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33554 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbbFHIvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 04:51:25 -0400
Received: by wgez8 with SMTP id z8so97286794wge.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 01:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=qGFKH/aN4/KiRcnuMsbAldmFFmkuUHTFF+LOACyd4d4=;
        b=dd7JQXD2NB76FYvSKPI6S8yKyP19u+ClsDTBfShcNeAQRZ0tfCEVVErny5HCwQdmc/
         VhgNYabqVeW/Bqi8ePbTLv2mKHyh6MMwXTe0z57wytnkfRNf05rEgH/j2yoyw6Hd/jDj
         IBOWIBIr/3pFD7LzNh62nnSkqpU7Uz40zulGcRtIlcwHUO1toFHM6500Z7F/PjHuHcnf
         KlN45N7eDCBE0xM6wwmkTs0AN/TPMNwDBlNrj0cAdVpun+YK1c6ADjqppYhvwoVzn+M3
         JaMf/DWMzcq7LRYQBwHHqL7fzInlYOrqyOk4fPiSEFRYaNErZPQWeqSvYdnqfY916J/O
         cg4w==
X-Received: by 10.194.79.225 with SMTP id m1mr30722791wjx.8.1433753484621;
 Mon, 08 Jun 2015 01:51:24 -0700 (PDT)
Received: by 10.28.21.4 with HTTP; Mon, 8 Jun 2015 01:50:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270994>

I would like to group some files, so I can list group files together,
list group changes together, filter by group for staging, also order
by group.
It seems, there is no such feature in GIT I would need, so I send it
as suggestion.

We can call this feature as "Group files" or "Label files" (labeling
is used in Gmail, so this may be also a naming alternative).


Example file list I would like to group together into [group1]:
theme/header.php
theme/footer.php
theme/body.php
lib/theme.php

They are in different directories, but mostly belongs together, so if
I group them, then I can work easier with them.


- I could select a file group for staging, so only the changes in the
group would be added to stage. Changed files in the group:
[group1]/theme/header.php
[group1]/lib/theme.php


- I could list files filtered by a group. Files filtered by [group1]:
[group1]/theme/header.php
[group1]/theme/footer.php
[group1]/theme/body.php
[group1]/lib/theme.php


- I could order file list to list group files first, then directory files.
[group1]/theme/header.php
[group1]/theme/footer.php
[group1]/theme/body.php
[group1]/lib/theme.php
other/files.php


I listed just a few basic cases, when grouping/labeling could be
useful, but there may be more.


Please consider implementing this feature into GIT.


Thanks,
Konrad Lorinczi
