From: "David Aguilar" <davvid@gmail.com>
Subject: Re: External diff viewer and stage/merge tool and git-gui?
Date: Tue, 3 Jun 2008 03:56:03 -0700
Message-ID: <402731c90806030356r1ea4317vef40b6449f4fca16@mail.gmail.com>
References: <Pine.LNX.4.64.0806030819310.31572@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Jun 03 12:57:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3UCN-00085d-Lk
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 12:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753329AbYFCK4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 06:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbYFCK4I
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 06:56:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:16062 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYFCK4F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 06:56:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so60818ugf.16
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6k1qw2xVxcH3R2LkzPkGQyL/bboderj6yMhVYpGF31k=;
        b=xeZtowjQHJ4jp+pa6wXzBGp308Jnh49N5PPTyc8YgrhwRyotv6M8ceFmU4DJmtlUE1
         qmqUgLB5bSJh6ziC03sFe1Z9Qoe1aZtdatapeJjB7H7KnPZKDN0n2YoAiRQOc1uM5MbR
         vf3r9wo9LX9xrHDeYzMQKKhgmkqWlwyBpnHGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mylDKJ5uH0zguZWgtbVJQJRuj1j3edEIyiS2g3MCcXLCiHPTLzO5eHGhCVvjVuzDMi
         5SzyZfpRszey3xU8VgwNGmjsx8JCx5SRh8xZ6+18c3YwNWyCbJNO+Npxq8uxBOenvfM9
         RiHC9e56uZkJoEwG5uJV9c5xpHqb/WK5BNTEw=
Received: by 10.66.249.20 with SMTP id w20mr421257ugh.67.1212490563739;
        Tue, 03 Jun 2008 03:56:03 -0700 (PDT)
Received: by 10.67.89.14 with HTTP; Tue, 3 Jun 2008 03:56:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0806030819310.31572@ds9.cixit.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83637>

On Tue, Jun 3, 2008 at 12:24 AM, Peter Karlsson <peter@softwolves.pp.se> wrote:
> Hi!
>
> As I continue to introduce Git at my workplace, I got the question on
> how to integrate external diff tools with Git. I figured out a way to
> get it to work with the command-line "git-diff", by setting
> GIT_EXTERNAL_DIFF and hacking together a small batch file (yeah, this
> is on Windows) that opens the diff in the viewer. For myself, I would
> like to use tkdiff, whereas the rest of the team is used to another
> side-by-side diff viewer.

Have you taken a look at ugit?

http://repo.or.cz/w/ugit.git
(requires the latest GitPython http://gitorious.org/projects/git-python/)

It can launch external diff tools.  It also has a very fine diff gui.
You can either select the entire diff hunk or, if you need to be more
precise, drill down to specific lines from a diff.

If the built-in diff selection doesn't suffice just right-click in the
modified files section where there's an option to send the diff to a
diff editor.  You can define that to be tkdiff, xxdiff, etc.

-- 
 David
