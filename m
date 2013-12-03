From: Javier Domingo <javierdo1@gmail.com>
Subject: Branching workflow
Date: Tue, 3 Dec 2013 19:06:20 +0100
Message-ID: <CALZVapnjN_69y0+PLFA2t8b72WDK+D4BhjDRnRPxU_9iX+_NuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:07:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnuN8-00052y-9t
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754705Ab3LCSGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 13:06:54 -0500
Received: from mail-ve0-f179.google.com ([209.85.128.179]:39441 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab3LCSGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 13:06:41 -0500
Received: by mail-ve0-f179.google.com with SMTP id jw12so10616460veb.38
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 10:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=07XyWadp9INwaxXwQsmz9nR+JFqTE0iVstMQXAMlI0Q=;
        b=T2Xn7BkV/JfVFXL9yeZ6qnuj3w483qQ2dCSWGsCLOv4sLjki4wMJUEPA7VWnCn7JPl
         SLo+0l2LrgErgJMYb9iWoZj8IjCM1/OOjpC21Nubyzgf/xpUrT2yKDWJciWeky/DLixB
         KbI8rlAJQ9DGMng7/GozsIY4dSrJr1WHiHb+WV4gT8PRgIZpeGHZHQDX3TZfzQFVG86L
         VGRofEzC9i7zVwl7/cUn3vR8tjCAqc0bBlqRIc58sY0vUY0i66jIS/OGljZI8AYjpX0s
         Nawyy4hCS2Cm5SGT+6HevyElUjc94mylnV1cpj9J6M4BaCgI/24wJoY2VvLqLQNNLpmE
         7zvQ==
X-Received: by 10.220.113.143 with SMTP id a15mr62400vcq.38.1386094001074;
 Tue, 03 Dec 2013 10:06:41 -0800 (PST)
Received: by 10.58.233.203 with HTTP; Tue, 3 Dec 2013 10:06:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238705>

Hi,

I have been using a very basic workflow for branching, features each
in a branch.

My branches would be:
- develop <= Main upstream branch
- feature/* fix/*  <= Feature and fix branches
- master <= Integration of the whole feature and fix branches

So I have now came up with a very difficult task. I just discovered
that one of those branches, lest call it feature/bad, is evil and is
making the integration branch (master) fail horribly.

In my workflow, I tend to merge develop (official updates) into my
feature branches, and them into master.

So now I have the big problem on how to undo all changes from
feature/fix. I have been told that one alternative workflow would be
to revert the last merge and remerge it into master, so that I have
always just one commit to revert if necessary (instead of the
monstrous quantity I have now to).

The workflow proposal should be in order of importance:
- Let me stay up-to-date with develop branch
- Easy to revert in master
- Have a clean history
- Easy to follow

I think I should be capable of doing some sort of merge/rebase
branching workflow to avoid having to do that. I have thought about
rebasing always the feature branches, and rebasing master into all of
them, but it seems pretty strange to me.

If anyone can give any advice, I would fully appreciate!

Javier Domingo Cansino
