From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] [GIT GUI PATCH] git-gui: fix open explorer window on 
	Windows 7
Date: Thu, 25 Feb 2010 22:49:47 +0000
Message-ID: <a5b261831002251449r7ac437f3h478727764ac755eb@mail.gmail.com>
References: <20100223225243.GC11271@book.hvoigt.net>
	 <a5b261831002240415l5447ac94wd80c162fc9492fd5@mail.gmail.com>
	 <20100225202949.GA12637@book.hvoigt.net>
	 <201002252323.13240.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkmWp-0002sJ-F5
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 23:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934319Ab0BYWtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 17:49:49 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48335 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934287Ab0BYWts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Feb 2010 17:49:48 -0500
Received: by wwf26 with SMTP id 26so2249424wwf.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 14:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v76BSzBAf7RXRoAsKKwNJR1icIRjSocw9DMgcpt2Xmo=;
        b=FCkl0s6O1D3CUu1pWzSyB6xMhoKKK76/JEGKXWEDjtmM/SBBiU0aas0Nh7efBDt/Nu
         v+nNRmWVw0dw3IkwSksC8NffHgyO6yOLMH/gUePy7Vs3FcrjOYUe/2gBD5fuNwel4x73
         cTFZKMsloMUwc1D00ad8RUviMFz8bNOzonZKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h6sQMAkC/nM0EijLhLbJXPBdTgamac2VM+uGXp/5aR9ByNHnXwMg2VspIQlSGn6N/I
         X+BToPfUGfg7QGrWYVAY/ggKxAdzW4V3FRya401cCdrTK4KfcLcOVoDdblzMV9WJK6uY
         QqsfdIpEbIe7MG6a4AgWMTPwoG22pg8kS+RYg=
Received: by 10.216.159.130 with SMTP id s2mr564555wek.13.1267138187099; Thu, 
	25 Feb 2010 14:49:47 -0800 (PST)
In-Reply-To: <201002252323.13240.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141075>

On 25 February 2010 22:23, Markus Heidelberg <markus.heidelberg@web.de>=
 wrote:
> Heiko Voigt, 2010-02-25 21:30:
>> On Wed, Feb 24, 2010 at 12:15:03PM +0000, Pat Thoyts wrote:
>> > On 23 February 2010 22:52, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> > > It seems that Windows 7's explorer is not capable to cope with p=
aths
>> > > that contain forward slashes as path seperator. We thus substitu=
te slash
>> > > with the platforms native backslash.
>> > >
>> >
>> > What bug are you actually addressing here? How can I reproduce it?=
 My
>> > experience on Windows 7 is that there is no problem but I assume I=
'm
>> > doing a different operation. If I use the git-gui =C2=A0"Explore w=
orking
>> > copy" it opens the Windows explorer for me just fine.
>>
>> Very strange, again another inconsistency between Windowses? I can
>> reproduce this even on Windows XP. I am using the current devel bran=
ches
>> of msysgit (msysgit and git). It happens when using the
>> "Repository->Explore working copy" menu item. The Windows 7 I tested
>> this on is 32-bit Professional. Which Windows 7 are you using?
>
> You should tell, how exactly you start git-gui, because this makes th=
e
> difference in this bug.

I have Windows 7 64 bit Ultimate - but I doubt the version of Win7 is
going to matter here.

In my case, using the current release of msysGit (1.6.5.1.1367.gcd48)
can launch the Windows explorer and so can the current devel branch of
msysgit. I launch these from the windows cmd shell using the scripts
in msysgit\cmd\ for the devel version

But lets be real certain we are runing the script in the
msysgit\git\git-gui directory:

C:\src\msysgit\git\git-gui>set
PATH=3Dc:\src\msysgit\bin;c:\src\msysgit\mingw\bin;%PATH%
C:\src\msysgit\git\git-gui>tclkit86 git-gui.sh

This is now guaranteed running the script mentioned and it uses the
'lib' subfolder from this directory too. Help About says git-gui
version @@GITGUI_VERSION@@ and git version 1.7.0.rc2.1441.g8e037 as I
built and installed this a few days ago.

However, I notice that it is not actually browsing the working folder
when it launches the browser - it has actually opened "My Documents".
I presume this is the bug you intend to fix -- and applying your patch
confirms that it solves this issue.

Can you please give enough information in the commit message to let us
know what issue is being solved by the changes provided.

To avoid any confusion I confirm the following patch ensures that
exploring the working folder on Windows correctly opens the working
folder of the current repository.

Tested-by: Pat Thoyts <patthoyts@users.sourceforge.net>

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index cd8da37..82c352b 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2099,15 +2099,17 @@ proc do_git_gui {} {
 proc do_explore {} {
        global _gitworktree
        set explorer {}
+       set path $_gitworktree
        if {[is_Cygwin] || [is_Windows]} {
                set explorer "explorer.exe"
+               set path [list [file nativename $path]]
        } elseif {[is_MacOSX]} {
                set explorer "open"
        } else {
                # freedesktop.org-conforming system is our best shot
                set explorer "xdg-open"
        }
-       eval exec $explorer $_gitworktree &
+       eval exec $explorer $path &
 }

 set is_quitting 0
