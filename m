From: in-gitvger@baka.org
Subject: Re: Prompt for merge message?
Date: Thu, 06 Oct 2011 14:51:41 -0400
Message-ID: <201110061851.p96Ipfui016139@no.baka.org>
References: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com>
        <20111006182534.GA13628@vfa-6h>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 20:51:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBt2s-0005JK-2v
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965290Ab1JFSvp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:51:45 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:38574 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965275Ab1JFSvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:51:44 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id p96IpfS3006666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Oct 2011 14:51:42 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id p96Ipfui016139;
	Thu, 6 Oct 2011 14:51:41 -0400
In-reply-to: <20111006182534.GA13628@vfa-6h>
Comments: In reply to a message from "Jacob Helwig <jacob@technosorcery.net>" dated "Thu, 06 Oct 2011 11:25:34 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183019>


In message <20111006182534.GA13628@vfa-6h>, Jacob Helwig writes:

    On Thu, 06 Oct 2011 10:49:02 -0700, Todd A. Jacobs wrote:

    > I often find myself using "--no-ff -m foo" for merging short-lived
    > branches, because the merge commit usually needs to say something
    > about having finished a feature rather than referring to a branch that
    > will be deleted shortly anyway. However, it's a little annoying to
    > have to always write the commit message on the command-line,
    > especially in cases where a more expository multi-line message would
    > be useful.

    "git merge --no-ff --no-commit branch_foo && git commit" ?

While not ideal, you can use a multi-line message on the command line.
I do it all of the time.  Popping up an editor like in the separated
workflow is more user friendly.

----------------------------------------------------------------------
git merge --no-ff -m "My feature is very complex

It requires multiple lines to explain.

Or perhaps I am too verbose." branch_foo
----------------------------------------------------------------------

					-Seth Robertson
