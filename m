From: Nico Williams <nico@cryptonector.com>
Subject: Should branches be objects?
Date: Thu, 19 Jun 2014 16:37:36 -0500
Message-ID: <CAK3OfOiB0YWf25Hvvvqi+YBwu2V-gE-sjm7XrfE0p2zds4CE2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 23:38:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxk1v-00068J-O4
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 23:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966242AbaFSVhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 17:37:54 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:38350 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965785AbaFSVhv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 17:37:51 -0400
Received: from homiemail-a103.g.dreamhost.com (sub4.mail.dreamhost.com [69.163.253.135])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 2E23D8FC2B
	for <git@vger.kernel.org>; Thu, 19 Jun 2014 14:37:51 -0700 (PDT)
Received: from homiemail-a103.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a103.g.dreamhost.com (Postfix) with ESMTP id C73112007F21C
	for <git@vger.kernel.org>; Thu, 19 Jun 2014 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:date:message-id:subject:from:to:content-type; s=
	cryptonector.com; bh=AsZIifRfhqbXo4532Xapmm4gZvw=; b=nxSkWX2z76P
	cwPLNrPZrvCNbYadrV4os+W3IwDb5ywzZL8CVfBTIXgB7h8TQaD2pPXw6tW62Q+x
	7TbwieCyg5lfK4xojv84wg6BPp53UezTctQSDGcWJDco5ZtSbsnmJ4TtWjpUWJ7T
	VAI9phoFE3J8xYaeZyVAQhaOgP/ZfsSQ=
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com [209.85.212.178])
	(using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a103.g.dreamhost.com (Postfix) with ESMTPSA id 7D3BE2007F220
	for <git@vger.kernel.org>; Thu, 19 Jun 2014 14:37:37 -0700 (PDT)
Received: by mail-wi0-f178.google.com with SMTP id n15so3533563wiw.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 14:37:36 -0700 (PDT)
X-Received: by 10.194.243.70 with SMTP id ww6mr7839475wjc.76.1403213856268;
 Thu, 19 Jun 2014 14:37:36 -0700 (PDT)
Received: by 10.216.29.200 with HTTP; Thu, 19 Jun 2014 14:37:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252194>

[I'm a list newbie here, but a git power user.]

If branches were objects...

 - one could see the history of branches, including

 - how commits were grouped when pushed/pulled (push 5 commits, and
the branch object will record that its head moved by those five
commits at once)

 - rebase history (git log <branch-object> -> better than git reflog!)

 - object transactional APIs would be used to update branches

Branch objects might be purely local, recording what was done in a
local repo to a branch, but they might be pullable, to make branch
history viewable in clones.

Just a thought,

Nico
--
