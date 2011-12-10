From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Re: process committed files in post-receive hook
Date: Sun, 11 Dec 2011 01:31:31 +0400
Message-ID: <20111211013131.1a37bf08@zappedws>
References: <loom.20111210T111457-837@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hao <billhao@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 22:31:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZUWN-0004xi-9l
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 22:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573Ab1LJVbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 16:31:37 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45389 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab1LJVbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 16:31:36 -0500
Received: by bkcjm19 with SMTP id jm19so248966bkc.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 13:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=KyvaGMtEXMieIikUcWpc/krlIRXfn0arQvj3K1f2ni8=;
        b=yG2AHsoWwLye6H/mxQ4P7hzdew2BJ/ep2YSj4stBPZx1NT7U4f9gvZNU1JBKVcgYde
         XrIWUlWS1kTQYH581tTmp75mtlgXFC66Noht3veOKk/QVRlQEE3qhI9hJ+xuYLFktxRo
         E7HUB8M7XXvNMcB+tsVq4BXLL2VEHSjjSZVO8=
Received: by 10.205.128.132 with SMTP id he4mr6833106bkc.123.1323552695232;
        Sat, 10 Dec 2011 13:31:35 -0800 (PST)
Received: from zappedws (ppp91-77-17-191.pppoe.mtu-net.ru. [91.77.17.191])
        by mx.google.com with ESMTPS id e18sm19349082bkr.15.2011.12.10.13.31.33
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 13:31:34 -0800 (PST)
In-Reply-To: <loom.20111210T111457-837@post.gmane.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186794>

> I have two questions. First, is there a way that I can access file
> content in a bare repo without checking out a working copy? 

$ git show <commit>:<filename>

e.g. for bare repo of Git the following command
$ git show v1.7.8:Documentation/RelNotes/1.7.8.txt
outputs
--->8---
Git v1.7.8 Release Notes
========================

Updates since v1.7.7
--------------------

 * Some git-svn, git-gui, git-p4 (in contrib) and msysgit updates.

 * Updates to bash completion scripts.
--->8---
