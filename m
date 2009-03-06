From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Using Git with windows
Date: Fri, 6 Mar 2009 18:30:30 +0300
Message-ID: <37fcd2780903060730j396588c8v38c302bde3be4bca@mail.gmail.com>
References: <e878dbad0903052321l6c0d310bk2ba568138b409d36@mail.gmail.com>
	 <e878dbad0903052323m56f3d63fi69862e9dae278c00@mail.gmail.com>
	 <c115fd3c0903060638lfc52073nd40e0d7379d7f593@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tariq Hassanen <tariq.hassanen@gmail.com>, git@vger.kernel.org
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 16:32:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfc1s-0006aV-IJ
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 16:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbZCFPae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 10:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbZCFPae
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 10:30:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:13470 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbZCFPad convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 10:30:33 -0500
Received: by fg-out-1718.google.com with SMTP id 16so553029fgg.17
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 07:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K6W3+nCC/Cz8ztmOcTGHS+niX78LM3vNLBjaBA+CZnE=;
        b=Q2tHXynxPhX9d12lh1zPr7tI7PkV6mvq/K+E2bcwGrbtsjTLbo/BHbiy2nH6wCdVt3
         PfjtoufljFu2DGzUkVflsIeIPanau3lRBugNjSmo/0dU8Mvd+7KzRjcZKb+mPfXv5wGK
         E1ihoXxx189U2qpNiwtrGNMpjW7ImNtAUwMaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZctFGcT6vopQ22+dIoBy7k/M6b+Q2yvIKKFXoShBkzOBaz0LItr/iE4aTBZMAtc2i3
         P4AzuVTBXAknZOxZA54zoOUTQ/4rpRxFFpz6z3Z1l6buk03TsUveXN1b/0Dzrjuddu2K
         TQCz2wNTg/NUC6ObV8amOoSq8NbLo62Q7uy84=
Received: by 10.86.82.16 with SMTP id f16mr1975841fgb.32.1236353430764; Fri, 
	06 Mar 2009 07:30:30 -0800 (PST)
In-Reply-To: <c115fd3c0903060638lfc52073nd40e0d7379d7f593@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112449>

On Fri, Mar 6, 2009 at 5:38 PM, Tim Visher <tim.visher@gmail.com> wrote=
:
>
> IMHO, Git under cygwin's pretty nice. =A0I tried using MSysGit as wel=
l
> and didn't feel like it was quite as good as just building Git under
> cygwin. =A0I also run Git on an Mac at home and while it's clearly
> faster, Git under Cygwin still beats the pants off of SVN under
> Cygwin.

If I am not mistaken Git 1.6.1 should work about twice faster under
Cygwin than previous versions with such common operations as
"git diff", "git status", because it avoids emulation of stat() in most
common cases...

>
>> But is there a way around this if i run a linux VM with Git running
>> and mount a windows ntfs partition ?
>
> Would this really be faster? =A0I don't have a whole lot of experienc=
e
> with virtualization, but isn't Cygwin 'basically' doing this already?

No, Cygwin works very differently... In some cases, Cygwin will work
faster, but there are operations that are very costly under Cygwin
such as fork(). So, what is faster depends on what you do, and
there are many other factors here such available memory or
present some antivirus programs, which can kill performance...
But, in general, if you work on Windows, it makes much more
sense to Cygwin or MSysGit than running Git under VmWare...


Dmitry
