From: Johan Herland <johan@herland.net>
Subject: [BUG?] Path limiting in "git log" when run from another subdir
Date: Mon, 24 Sep 2012 13:59:57 +0200
Message-ID: <CALKQrged+ptCQYm-=JKRborrAeKmaNFG=rDS8BQK5CNhwqjnkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 24 14:00:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG7Ki-0006Ul-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 14:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab2IXMAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 08:00:04 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:59257 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237Ab2IXMAD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 08:00:03 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1TG7KS-000MLp-Pp
	for git@vger.kernel.org; Mon, 24 Sep 2012 14:00:00 +0200
Received: by obbuo13 with SMTP id uo13so4507682obb.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 04:59:57 -0700 (PDT)
Received: by 10.182.147.8 with SMTP id tg8mr435883obb.21.1348487997233; Mon,
 24 Sep 2012 04:59:57 -0700 (PDT)
Received: by 10.76.128.204 with HTTP; Mon, 24 Sep 2012 04:59:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206261>

The following works in the git.git repo:

$ cd t
$ git log -- /Documentation
[...]

but the following does not:

$ cd t
$ git log -- /Documentation/RelNotes
fatal: Could not switch to '/Documentation': No such file or directory


Is this the intended behavior?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
