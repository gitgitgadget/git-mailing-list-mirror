From: =?ISO-8859-1?Q?Mads_D=F8rup?= <mads@dorup.dk>
Subject: Re: [PATCH] Improve font rendering on retina macbooks
Date: Mon, 22 Jul 2013 00:48:03 +0200
Message-ID: <CAMtfEwQFY09q9ir7=NScD=OpkT9gGRZog_4fF+U7WySZvxj8YA@mail.gmail.com>
References: <CAMtfEwTGTCKhuFK116-z2ePE70T1iXdPx7BB1xLxRdfsAfws=Q@mail.gmail.com>
	<CAMtfEwQJub1C7uak5jiCtLJ4obLPvSZYyPfiVW6BLbw0RK4=xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	=?ISO-8859-1?Q?Mads_D=F8rup?= <mads@dorup.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 22 00:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V12QJ-00074h-Pq
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 00:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315Ab3GUWsF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jul 2013 18:48:05 -0400
Received: from mail-qe0-f53.google.com ([209.85.128.53]:60358 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab3GUWsE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jul 2013 18:48:04 -0400
Received: by mail-qe0-f53.google.com with SMTP id f6so475830qej.26
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 15:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=2ofRtgPpgWiL/6amD+wF3vMkX1Xf/9Dx3Hxrs5f9Dmk=;
        b=OgVev+HtkVq+zt773KVop3/5sUTu1FQ4ViwI5FaDjymq5yt/SCreZ/ADO900k0gWl5
         qgsyL8mYjsEjErxVdR1ysCdtR7J7vAVJvDohirhZetbNwqAV+JYDpV5fStd931PtJ83j
         3jo0FfsEUDJ2PygU/HnIkiyC4GqIlhMaeRbTYaa4Fa2ke7eoUASgGzSCWcXWhrw8qMPl
         2EDWG/jmvnJmFBU+5DUJQsi1GlnjyK6fempjnsU7m+FGGHcUvM3KkKj7r9aocmjtK33C
         vlPfRVZpsVTbpsNPhlxEs6IC0Im7X2GOedH8M6XOYjhqU67kYtB+GuZpVvpMomxN4g1i
         DApg==
X-Received: by 10.49.35.233 with SMTP id l9mr29808613qej.23.1374446883179;
 Sun, 21 Jul 2013 15:48:03 -0700 (PDT)
Received: by 10.49.88.106 with HTTP; Sun, 21 Jul 2013 15:48:03 -0700 (PDT)
X-Originating-IP: [87.63.44.161]
In-Reply-To: <CAMtfEwQJub1C7uak5jiCtLJ4obLPvSZYyPfiVW6BLbw0RK4=xA@mail.gmail.com>
X-Gm-Message-State: ALoCoQlbkKfLrlLk2EhYbyLLXLni7TkTWL7NZgtd0UjUxVTyRw2ZeC089XfERKL9tphAMq0+ezPr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230950>

I've been asked to close the github pull request. So instead, to see
before-and-after screenshots of this change have a look here:

https://github.com/cpius/git/commit/dce145c11a89be7c795815c9bd8fe2c07a5=
afa7d#commitcomment-3682422

Regards, Mads D=F8rup


On Sun, Jul 21, 2013 at 2:25 PM, Mads D=F8rup <mads@dorup.dk> wrote:
> Hi there
>
> I've created a very small change to git gui that considerably improve=
s
> the experience on my machine at least:
>
> diff --git a/git-gui/macosx/Info.plist b/git-gui/macosx/Info.plist
> index b3bf15f..1ade121 100644
> --- a/git-gui/macosx/Info.plist
> +++ b/git-gui/macosx/Info.plist
> @@ -24,5 +24,7 @@
>         <string>GITg</string>
>         <key>CFBundleVersion</key>
>         <string>@@GITGUI_VERSION@@</string>
> +       <key>NSHighResolutionCapable</key>
> +       <true/>
>  </dict>
>  </plist>
>
>
> I've read the documentation for submitting patches to git where it
> says that I have to e-mail the patch to the mail list, with relevant
> developers as CC. Pat are you the relevant developer for this?
>
> Here is a screenshot comparison of before and after the change:
>
> https://github.com/git/git/pull/48
>
> Please let me know how to proceed to get this patch in, if you like
> it. I've never contributed here before, so please me know about any
> procedures I have missed.
>
> Regards, Mads D=F8rup
