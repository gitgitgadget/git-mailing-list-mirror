From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: How to diff 2 file revisions with gitk
Date: Fri, 8 Feb 2013 11:51:14 +0530
Message-ID: <CAMK1S_jEbSd9=OFy++vv_S8ZP8bdFz=md7iuz3VHUQqwKDMBKA@mail.gmail.com>
References: <1360164008.49200.YahooMailNeo@web171204.mail.ir2.yahoo.com>
	<1360166273.33888.YahooMailNeo@web171204.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "R. Diez" <rdiezmail-buspirate@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:21:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3hL9-0007rn-DM
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 07:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053Ab3BHGVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 01:21:16 -0500
Received: from mail-we0-f169.google.com ([74.125.82.169]:55957 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907Ab3BHGVP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 01:21:15 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so2781300wey.14
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 22:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZnXv87GFnnRbZHWoYRBc+oQndC1zv1foEW44QcEMrvY=;
        b=E53DUDgYjLJqKMuHndY+HZznlp4w6pKw6nTv1yqmjgDIrjv4uUOoSxz6KvyuDjb1DL
         0ZsbuDwDgNfYDwB+NJO/7rumw8l6sKgHOGyeehYe7gcjt1leUsr3P7FR7XGrwILolcD4
         Tj8YZPv3wxesRYXVyH4loaCNbsjY2UWUrECOWxSasy/F8cpnWGp444U6fVk8iqhY4mh7
         /cVk/n+SijX2ycjQnzhAIUbrc7IYcSbCUhAovyjv5MRHC2qrA+LQDnGMypFnO1sgf/Ay
         Q005m6FDD1raQwtDV3RH9XtbFLWC2GmjT7HBWqQANpBzd5wboqusHL08f7sDLETv3WpN
         ygEA==
X-Received: by 10.180.72.148 with SMTP id d20mr240331wiv.31.1360304474239;
 Thu, 07 Feb 2013 22:21:14 -0800 (PST)
Received: by 10.194.94.71 with HTTP; Thu, 7 Feb 2013 22:21:14 -0800 (PST)
In-Reply-To: <1360166273.33888.YahooMailNeo@web171204.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215760>

On Wed, Feb 6, 2013 at 9:27 PM, R. Diez <rdiezmail-buspirate@yahoo.de> wrote:
> Hi there:
>
> I asked a few days ago whether I could easily diff 2 file revisions with the mouse in gitk, but I got no reply yet, see here:
>
>
>    How to diff two file revisions with the mouse (with gitk)
>    https://groups.google.com/forum/#!topic/git-users/9znsQsTB0dE
>
> I am hoping that it was the wrong mailing list, and this one the right one. 8-)
>
> Here is the full question text again:
>
> --------8<--------8<--------8<--------8<--------
>
> I would like to start gitk, select with the mouse 2
> revisions of some file and then compare them, hopefully with an external
>  diff tool, very much like I am used to with WinCVS.
>
> The closest I
>  got is to start gitk with a filename as an argument, in order to
> restrict the log to that one file. Then I right-click on a commit (a
> file revision) and choose "Mark this commit". However, if I right-click
> on another commit and choose "Compare with marked commit", I get a full
> commit diff with all files, and not just the file I specified on the
> command-line arguments.
>
> Selecting a filename in the "Tree" view and choosing "Highlight this only", as I found on the Internet, does not seem to help.
>
> I have git 1.7.9 (on Cygwin). Can someone help?
>
> By the way, it would be nice if gitk could launch the external diff tool from the "Compare with marked commit" option too.

I don't know if I misunderstood the whole question because the answer
is very simple.

  - start gitk
  - left click the newer commit
  - scroll to the older commit
  - right click the older commit and choose "Diff this -> selected"
  - in the bottom right pane, pick any file, right click, and choose
"External diff".
