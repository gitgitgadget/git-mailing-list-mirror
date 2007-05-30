From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Wed, 30 May 2007 14:08:36 +0100
Message-ID: <200705301408.37929.andyparkins@gmail.com>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com> <200705261034.53723.andyparkins@gmail.com> <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Pavel Roskin" <proski@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 15:09:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtNvo-0004Kx-11
	for gcvg-git@gmane.org; Wed, 30 May 2007 15:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbXE3NJB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 09:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbXE3NJB
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 09:09:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:2524 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbXE3NI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 09:08:59 -0400
Received: by wr-out-0506.google.com with SMTP id 76so862257wra
        for <git@vger.kernel.org>; Wed, 30 May 2007 06:08:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CdVQ9E52obnValJ3cmyGhsHlNpfZX0Plt54qbuUzwzan6P6XWDr7kxFV0M4BmMmH836VKNhqkoZ2EJjzuGwRf1GQtYz/YgEVV5K0/8lDOzGMCLP75OsQqVD+g3dLHWQcPYRYLc4u7sNcA70Mu469yMOSaXBcDfRjPKOqasMFl5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WZHQ9d+cv6vIJqKI9FVeOIKtUMvi0kgdzPIZvyG18eGvSJtm7nJIUMtEyO/qMrmKNtBvcoVj1ZTOk9vFXa21xKdf4638WMEBtR7QgZPOT/+r9tmnjoqlX9AmzmE0Sa9aDz+VQs5ZKZo+sMLoKIGOcZTBVkxNvuQETMfiKs/W+1U=
Received: by 10.90.72.10 with SMTP id u10mr6025344aga.1180530539178;
        Wed, 30 May 2007 06:08:59 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id q57sm10547581wrq.2007.05.30.06.08.50;
        Wed, 30 May 2007 06:08:56 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48759>

On Saturday 2007 May 26, Marco Costalba wrote:

I've been using the latest qgit for a couple of days.  Thought I'd comment on 
the changes.

> > All visually distinct to improve searching by eye (perhaps including
> > clear separators between files patched).  Then the file list could
> > include a "<header>" psuedo-file that would jump back to the top of the
> > viewer.
>
> This seems really gitk like. Not that I don' t like it, but _if_ it's
> possible I would prefer something a little bit more original.

I thought of a reason why I like qgit's separation of log and patch.  Some 
revisions have very large patches.  In those cases, it's nice to have the 
choice not to pay for the expensive patch display when all you want is to 
view the log message.

My vote is definitely for keeping separate log and patch viewer.

> Now user can toggle between revision commit message and patch content
> with the menu entry 'View->toggle message/diff', or with shortcut 'm'
> or also with mouse clicking on top right links 'Diff->' and 'Log->'.

I like the principle; but I'm not sure about the floating "Diff->" 
and "Log->"; it seems to me that the GUI metaphor for exactly this sort of 
thing is well established - the tabbed display.  Why invent yet another way 
of switching a window between different views?

> There is also a check box in 'Edit->settings' called 'Show always
> revision message as first' that, if set, let automatically to switch
> to revision message when browsing on a new revision.

I have no objection to this.  I can imagine cases when both automatic-switch 
and leave-it-as-it-is would be what I want - so it has to be an option.

> With this, browsing on a repo reading both log message and patch it's
> a matter of 2 clicks or 2 shortcuts per revision, one for changing
> revision (and read the log message) and another to view the patch
> content.

You don't mention it here, but the change I'm not keen on is the scroll-down 
to switch feature.  Often, I over-scroll to be sure that I have hit the 
bottom of a scroll box.  When I do that with the scroll-to-switch feature, 
suddenly the view changes.  I'm finding it quite disconcerting.

> Comments? like/dislike?

Apart from the minor niggles I've mentioned above; I do like it.
 - It feels more stable - in my day-to-day usage, far less of the screen
   changes, so you don't feel that you're jumping between different modes
 - Being able to see the patch and the revision list at the same time is
   very nice.

While we're on wishes, here's a couple:
 - It's hard to spot the boundaries between files in the the patch viewer.
   It would be great if the
    diff --git a/vserver/Makefile b/vserver/Makefile
    index 2581254..17d8934 100644
   lines had a different coloured background.
 - The margin at the front of the log message lines puts the header block and
   log text at different horizontal positions on the screen.  I think it would
   be nicer if they were at the same position.

Maybe I'll scratch those itches myself; but thought I'd mention them in case 
you get to them before me :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
