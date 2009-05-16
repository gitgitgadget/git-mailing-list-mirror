From: git@drmicha.warpmail.net
Subject: Re: [PATCH 0/5] RESEND: git notes
Date: Sat, 16 May 2009 17:06:55 +0200
Message-ID: <4A0ED68F.6060200@drmicha.warpmail.net>
References: <cover.1242437696.git.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	chriscool@tuxfamily.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat May 16 17:24:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5LjL-0007Yl-V7
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 17:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbZEPPXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 11:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752627AbZEPPXI
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 11:23:08 -0400
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:56294 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbZEPPXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 11:23:07 -0400
X-Greylist: delayed 882 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 May 2009 11:23:07 EDT
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 39CDF21EEA9;
	Sat, 16 May 2009 17:07:02 +0200 (CEST)
Received: from tu-clausthal.de (poseidon [139.174.2.21])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 1B2F321EEA8;
	Sat, 16 May 2009 17:07:01 +0200 (CEST)
Received: from [84.133.139.66] (account mjg HELO localhost.localdomain)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.2.14)
  with ESMTPSA id 43219606; Sat, 16 May 2009 17:07:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <cover.1242437696.git.johan@herland.net>
X-Enigmail-Version: 0.96a
X-Virus-Scanned: by PureMessage V5.5 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119363>

Johan Herland venit, vidit, dixit 16.05.2009 03:45:
> Hi,
> 
> Dscho has asked me to take over the responsibility for the js/notes
> patch series.
> 
> The following is a re-roll and resend of the patch series currently
> in pu, plus my own 2 patches for adding support for "-m" and "-F" to
> "git notes edit".
> 
> On advice from Dscho, I have squashed the current bugfix and cleanup
> patches in js/notes into the first 4 "main" patches. As a result the
> original 15 + 2 patch series is now down to 5 (4 + 1) patches.
> 
> In sum, these 5 patches produce the exact same result as the original
> js/notes series (plus my 2 patches).
> 
> I have taken the liberty of squashing the various Signed-off-by tags
> (along with their corresponding patches) into these 5 new patches.
> I hope this is OK with everybody. If not, I apologize; please tell me,
> and I will re-send.

Well, effectively you removed me (and others) from the author list :|

I think the issue with the tree difference after this series (compared
to the original one) shows that this squashing action makes reviewers'
lives more complicated rather than easier. If it were the other way
round squashing would be fine, of course.

Michael

> 
> 
> Have fun! :)
> 
> ...Johan
> 
> 
> Johan Herland (1):
>   Teach "-m <msg>" and "-F <file>" to "git notes edit"
> 
> Johannes Schindelin (4):
>   Introduce commit notes
>   Add a script to edit/inspect notes
>   Speed up git notes lookup
>   Add an expensive test for git-notes
> 
>  .gitignore                       |    1 +
>  Documentation/config.txt         |   13 +++
>  Documentation/git-notes.txt      |   60 ++++++++++++++
>  Makefile                         |    3 +
>  cache.h                          |    4 +
>  command-list.txt                 |    1 +
>  commit.c                         |    1 +
>  config.c                         |    5 +
>  environment.c                    |    1 +
>  git-notes.sh                     |  121 ++++++++++++++++++++++++++++
>  notes.c                          |  160 ++++++++++++++++++++++++++++++++++++++
>  notes.h                          |    7 ++
>  pretty.c                         |    5 +
>  t/t3301-notes.sh                 |  149 +++++++++++++++++++++++++++++++++++
>  t/t3302-notes-index-expensive.sh |   98 +++++++++++++++++++++++
>  15 files changed, 629 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/git-notes.txt
>  create mode 100755 git-notes.sh
>  create mode 100644 notes.c
>  create mode 100644 notes.h
>  create mode 100755 t/t3301-notes.sh
>  create mode 100755 t/t3302-notes-index-expensive.sh
> 
