From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Anyone running GIT on native Windows
Date: Fri, 11 May 2007 22:07:02 +0200
Organization: eudaptics software gmbh
Message-ID: <200705112207.02206.J.Sixt@eudaptics.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500> <46449B0D.5FCD66F1@eudaptics.com> <f329bf540705111035v4a6f0b23w49f04c768a410069@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org, hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Fri May 11 22:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmbpQ-0004vO-PR
	for gcvg-git@gmane.org; Fri, 11 May 2007 22:35:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbXEKUe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757472AbXEKUe6
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 16:34:58 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:42884 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755653AbXEKUe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 16:34:57 -0400
X-Greylist: delayed 1672 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 May 2007 16:34:57 EDT
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 5056410AADA;
	Fri, 11 May 2007 22:07:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id BD09F2DA03;
	Fri, 11 May 2007 22:07:02 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <f329bf540705111035v4a6f0b23w49f04c768a410069@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46980>

On Friday 11 May 2007 19:35, Han-Wen Nienhuys wrote:
> 2007/5/11, Johannes Sixt <J.Sixt@eudaptics.com>:
> > Han-Wen Nienhuys wrote:
> > > http://lilypond.org/git/binaries/mingw/git-1.5.1-1.mingw.exe
> >
> > This resulted in a mostly working git toolset after I've done this in
> > addition to installing it:
> >
> > - Installed MSYS (of course ;)
> > - Install libiconv-2.dll, which can be found in
> > diffutils-2.8.7-1-dep.zip from
>
> Can you be more specific? Which files required this?

git.exe, for example, hence, at least all builtins.

> It is entirely coincidental that another DLL from another package
> works, and it's a bug in our packaging.

Why should this not work? The diffutils package I mentioned is from MinGW.

Anyway, I think we should not link against libiconv*.dll at all because it 
slows down the startup too much.

> The path to Git should also have been set automatically. I will look into
> this.

Well, I did not reboot, or log out and in again. I just opened a CMD after the 
installation was complete. Usually, CMD picks up new PATHs if they have been 
modified via the Settings->System->Advanced (or whatsitcalled) tool. So, I 
thought it would be the same with installations.

-- Hannes
