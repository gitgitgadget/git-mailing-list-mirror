From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Using thunderbird to post/apply patches?
Date: Thu, 07 Feb 2008 17:44:44 -0600
Message-ID: <47AB97EC.8030002@nrlssc.navy.mil>
References: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 00:45:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNGR1-0007NB-3d
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 00:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758261AbYBGXpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 18:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758295AbYBGXpF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 18:45:05 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57290 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758204AbYBGXpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 18:45:03 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m17Nij35032382;
	Thu, 7 Feb 2008 17:44:45 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Feb 2008 17:44:44 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <46a038f90802071521n674b61c2t5e4d4c740375b951@mail.gmail.com>
X-OriginalArrivalTime: 07 Feb 2008 23:44:44.0930 (UTC) FILETIME=[6ABCA620:01C869E3]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--10.586800-0-1-1
X-TM-AS-Category-Info: : 1:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzA5NTg0LTcwMjA1MC03MDA2MTgtNzA0NzQ5LTE4NzA2Ny0x?=
	=?us-ascii?B?ODgwMTktNzA2NDU0LTcwMjc5MS03MDAxMTUtNzA0NDIxLTcwMjM1?=
	=?us-ascii?B?OC03MDU3MzMtNzAzNzg4LTEyMTU5NC03MDQ0MjUtNzAyMTQzLTcw?=
	=?us-ascii?B?MzkwNy03MDcyMjUtNzAwNDc2LTcwMTQ1NS03MDE0ODItNzAzODM1?=
	=?us-ascii?B?LTcwMDM1NS03MDIwNzktNzAxMzg0LTcwNTQ0MS03MDIwNDQtNzAy?=
	=?us-ascii?B?ODU3LTcwMTU0NC0xMDY0NzAtNzA4MjU3LTcwMDE1My0xNDgwMzkt?=
	=?us-ascii?B?MTQ4MDUxLTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73021>

Martin Langhoff wrote:
> Is there anyone using thunderbird/mozilla to post patches with
> additional email commentary like Junio and Linus do? Are there good
> tricks for this? Or otherwise a similar MUA that does things right?
> 
> The 2 workflows I am after are...
> 
>  - Load up a patch created with git-format-patch into my email editor
> to add some commentary before sending. Should not munge the patch
> itself!

I use git-send-email to first send the patch to myself.
When it shows up in thunderbird, I Right-click and select "Edit As New..."
Add my text, update the recipients, and voila.

If you're replying to a previous message, you can get the Message-ID to
supply to git-send-email by selecting View->Headers->All. Copy&Paste
everything between the angle brackets.

I have these options set in Edit->Preferences:
  Display->Formatting->Display emoticons as graphics: unchecked, it turns
    HEAD^2 into HEAD squared
  Composition->General->Wrap plain text messages at 0 characters
                                                    ^

I also have mailnews.send_plaintext_flowed => false as suggested in
SubmittingPatches. There is a different suggestion in that document
you may want to read.

>  - Feed an email I am reading to git-apply-mbox so that if it's
> reasonably formatted as a patch it will do the right thing and apply
> it.

I just Right-click and Save As...

cat <saved_as> | git am

-brandon
