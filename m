From: Joseph Huttner <huttnified@gmail.com>
Subject: How to make devs write better commit messages
Date: Tue, 6 Dec 2011 17:55:07 -0500
Message-ID: <CAOJsP-X0ZWT5HLHcBc2FmhoMpWFOvEFADiM9jGZ9R1ctqHDJ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 23:55:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY3vC-0000s4-9Z
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 23:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744Ab1LFWza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 17:55:30 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50368 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300Ab1LFWz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 17:55:29 -0500
Received: by eaak14 with SMTP id k14so5655662eaa.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 14:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=YESTylXrkxspH3ojusphuSre/I5CV2HEEo4SS8zR+w8=;
        b=D6isk9C28PUgXOrBPCmhtC2lbQO2/fx7EoUFlJfmjfdFmGnR8B4YH3arS9RVkeTnS0
         kw0TcRDfN7JqY25b0uLBTA+4FANIQz4aIxiCVPq7FDFkTerjppcMPwgZC/FsW1bJN6rP
         vr2wsZYny2hUyh2g01vViXntnkA0UhcTSbpig=
Received: by 10.213.110.14 with SMTP id l14mr2994456ebp.54.1323212128200; Tue,
 06 Dec 2011 14:55:28 -0800 (PST)
Received: by 10.204.155.20 with HTTP; Tue, 6 Dec 2011 14:55:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186402>

So I know that there is a somewhat standard format of commit messages
in Git, which Linus outlines here:

https://github.com/torvalds/subsurface/blob/master/README#L164

Trouble is, when most people go to commit, the file that the editor
opens has no reminder of how to write a proper commit message.  Often
I find myself having to go back through the commit log, or consulting
the above link.

I propose two things:

1.  An optional flag in the Git config that, if set, shows the format
of a typical commit message in your commit message template.

2.  The ability to modify this commit message template.  Many teams
use automated tools to read commit messages and then do automated
tasks based on that data, like comment an RT ticket.  Thus, developers
need to be reminded of these team-specific settings as well.

What are your thoughts?

The bottom line is that good commit messages are really important, so
we should make it as easy as possible for developers to go ahead and
write a perfect commit message every time they commit code.


E.g.


# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
# modified:   application/views/layouts/layout.phtml
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
# public/js/databases/
#
# How to properly format your commit message:
#
# 	Header line: explaining the commit in one line
#
#	Body of commit message is a few lines of text, explaining things
#	in more detail, possibly giving some background about the issue
#	being fixed, etc etc.
#
#	The body of the commit message can be several paragraphs, and
#	please do proper word-wrap and keep columns shorter than about
#	74 characters or so. That way "git log" will show things
#	nicely even when it's indented.
#
#	RT: 123, 456 [a comma-separated list of RT tickets this commit refers to]
#
