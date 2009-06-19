From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Windows 7 and git-gui/gitk language
Date: 19 Jun 2009 20:55:28 +0100
Message-ID: <87fxdw0zin.fsf@users.sourceforge.net>
References: <alpine.DEB.2.00.0906181200460.23400@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jun 19 21:56:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHkC7-0000n3-4v
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 21:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbZFSTzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 15:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbZFSTzd
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 15:55:33 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:55352 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750777AbZFSTzc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 15:55:32 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MHkBS-0004tA-44; Fri, 19 Jun 2009 20:55:34 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out6.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MHkBQ-00063C-5w; Fri, 19 Jun 2009 20:55:32 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 7A09151842; Fri, 19 Jun 2009 20:55:31 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <alpine.DEB.2.00.0906181200460.23400@ds9.cixit.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121906>

Peter Krefting <peter@softwolves.pp.se> writes:

>Hi!
>
>When running on Windows XP (no matter which language of the OS I had
>installed), git-gui and gitk (msys) would show up in the language I
>had set up as my primary language in the Control Panel (Swedish).
>
>I am now running Git on the Windows 7 RC, and I cannot get it to work,
>I get English in all cases. I have set all locale settings in the
>Control Panel to Swedish, and even installed the Swedish Display
>Language Pack and set the OS language to Swedish.
>
>Does anyone know if there is something else I need to do to get
>git-gui/gitk to display in Swedish?

You could try setting the LANG environment variable. I've got an
English installation of Windows 7 but setting LANG=sv before starting
git gui or gitk causes the program to show what looks like Swedish
labels and menus.

If you fire up wish on its own (it is installed with msys Git) and
enter 'package require msgcat; msgcat::mclocale' in the console window
it should be showing something other than 'en' if your Windows
installation is non-English. There might be a bug for the Tcl people
here (comp.lang.tcl or the sourceforge bug tracker).

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
