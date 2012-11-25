From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Query for certain branches, but not the rest
Date: Sun, 25 Nov 2012 10:24:59 +0100
Message-ID: <CAMP44s02=E3imOv00dwyXR13nQdo1XeZTjJb_y0EVQoyYMEcQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 10:25:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcYSm-0000Xz-2J
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 10:25:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab2KYJZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 04:25:04 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55434 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab2KYJZA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 04:25:00 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so9993457obb.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=+ngTJHFnMU8oWQF94Dv3Vby7AJJK+cUHbMHymxgxgCk=;
        b=oXjJZTz26Z+14Yly2I7xhv1wcH7yuQZwVAg5T6FN5RgTUM1w5vWnUgT9Bu/Y3xGtku
         ekWpKaz4TbFkAZwd3YXI6wXu3L1OOqoQ+ZLqeqtUjqt24YHUHafZfk8Xj+H/yeQSQwmS
         Q6fk2se7U2v3R2trcafW2KNMskTScEhxk0hjFZz2u5eicxKvkCfKJ/bAXp/ZvrWb3psS
         pb8CFIA/5M8pdHt//kP1ztZ7TbMGO6FBGnbY12IC1/S9FXXCmTKOYDiQVIcEkOa2PAES
         9rgSsPz/w1yqgtlw+7OHimyyXS1uVr1ezLfoXNN6PCH+hW1TAcLLAlkFrpp7HOkB4/5H
         DN3Q==
Received: by 10.60.28.166 with SMTP id c6mr6570242oeh.140.1353835499374; Sun,
 25 Nov 2012 01:24:59 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Sun, 25 Nov 2012 01:24:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210342>

Hi,

Suppose I have these branches:

  fc/feature-a
  fc/feature-b
  master
  next

I want to show this: fc/feature-a fc/feature-b ^master ^next. I can do
'git log --branches=fc' to show the branches that begin with fc/, but
there's no way to specify the rest. If they were under a prefix, I
could do '--not --branches=prefix', but they are not.

Anybody knows a way to query branches that don't have any prefix?

It appears this works:

% git for-each-ref refs/heads/*

But I would like something parsable by rev-parse.

Any ideas?

Cheers.

-- 
Felipe Contreras
