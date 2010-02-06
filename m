From: Aaron Crane <git@aaroncrane.co.uk>
Subject: Gmail and unwanted line-wrapping
Date: Sat, 6 Feb 2010 20:29:32 +0000
Message-ID: <bc341e101002061229t7a1525c2w2d5a8e221124b3c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 21:33:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdrL5-0004s4-7O
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 21:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab0BFU3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 15:29:50 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:18148 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab0BFU3t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 15:29:49 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1079612eyd.19
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 12:29:47 -0800 (PST)
Received: by 10.216.87.143 with SMTP id y15mr1249606wee.39.1265488187667; Sat, 
	06 Feb 2010 12:29:47 -0800 (PST)
X-Originating-IP: [87.194.157.167]
X-Google-Sender-Auth: bcbc26212153622a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139190>

Documentation/SubmittingPatches says this about dealing with Gmail's
propensity for breaking your email:

> GMail does not appear to have any way to turn off line wrapping in the web
> interface, so this will mangle any emails that you send.  You can however
> use any IMAP email client to connect to the google imap server, and forward
> the emails through that.  Just make sure to disable line wrapping in that
> email client.  Alternatively, use "git send-email" instead.
>
> Submitting properly formatted patches via Gmail is simple now that
> IMAP support is available. First, edit your ~/.gitconfig to specify your
> account settings:
<snip>
> Next, ensure that your Gmail settings are correct. In "Settings" the
> "Use Unicode (UTF-8) encoding for outgoing messages" should be checked.
>
> Once your commits are ready to send to the mailing list, run the following
> command to send the patch emails to your Gmail Drafts folder.
>
>         $ git format-patch -M --stdout origin/master | git imap-send
>
> Go to your Gmail account, open the Drafts folder, find the patch email, fill
> in the To: and CC: fields and send away!

However, the advice beginning "Submitting properly formatted patches
via Gmail is simple now" doesn't match my experience.  Following those
guidelines seemed to work, but my patch was line-wrapped anyway.

It seems I'm not the only person who's observed this:
http://article.gmane.org/gmane.comp.version-control.git/133020

Can anyone think of anything I might have done wrong here?  If not,
I'm inclined to suggest dropping all of that advice.  That's not
ideal, because it leaves Gmail users with no obvious way to submit
well-formatted patches to the list; but it's better than suggesting
something which apparently doesn't work.

-- 
Aaron Crane ** http://aaroncrane.co.uk/
