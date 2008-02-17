From: =?UTF-8?B?SnVya28gR29zcG9kbmV0acSH?= <jurko.gospodnetic@docte.hr>
Subject: Re: git-gui not working in a non-default Cygwin installation.
Date: Sun, 17 Feb 2008 12:25:50 +0100
Message-ID: <fp95jr$r08$1@ger.gmane.org>
References: <fp5fdj$5fi$1@ger.gmane.org> <20080217080255.GQ24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 12:26:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQhfQ-0003TQ-42
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 12:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778AbYBQL0H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Feb 2008 06:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753367AbYBQL0G
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 06:26:06 -0500
Received: from main.gmane.org ([80.91.229.2]:34879 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710AbYBQL0F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 06:26:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JQhef-0007NG-DB
	for git@vger.kernel.org; Sun, 17 Feb 2008 11:25:57 +0000
Received: from 87.252.133.12 ([87.252.133.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 11:25:57 +0000
Received: from jurko.gospodnetic by 87.252.133.12 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 11:25:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.252.133.12
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20080217080255.GQ24004@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74120>

   Hi Shawn.

> First, let me point out that Cygwin's Tcl/Tk is stuck on 8.4.1 and
> will probably never get updated again.  I have had some bugs with
> git-gui on 8.4.1 on Windows where git-fetch/git-push processes
> get hung and don't function correctly.  Upgrading Tcl/Tk to the
> native Windows binaries of version 8.4.15 resolves the problem,
> but that binary cannot handle Cygwin paths and Cygwin mount points.

   Sorry, I seem to be a bit confused about this... Why does cygwin not=
=20
support Tcl/Tk above version 8.4.1?

   What about the information found on=20
http://opencircuitdesign.com/cygwin under 'Tcl-Cygwin binary=20
distribution download and install:'? It lists some additional downloads=
=20
that may be used to install the latest Tcl/Tk on cygwin... Why is this=20
not included in the regular Cygwin distribution (setup.exe)?


> git-gui assumes its going to be running on a newer (and more stable)
> Tcl/Tk so its build process embeds the Windows path into the script.
> *sigh*

   But new version of Tcl/Tk or not, this will not work unless you=20
actually *build* git-gui on your final target system. Why does this=20
information need to be hardcoded in the script at all? Can it not be=20
detected at run-time?


> I'll try to work up a Makefile patch in the next few days and get
> it into a gitgui-0.9.3 maint release, which will probably roll up
> into git 1.5.4.3.

   Thanks!

   Best regards,
     Jurko Gospodneti=C4=87
