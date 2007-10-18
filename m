From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: Qgit performance and maintain CVS environment with GIT repository
Date: Thu, 18 Oct 2007 16:41:52 -0700
Organization: Bluelane
Message-ID: <4717EF40.6000509@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>	 <47159779.6010502@bluelane.com>	 <e5bfff550710170030y7778e96ax146acea7a0e57a67@mail.gmail.com>	 <200710171800.37345.robin.rosenberg.lists@dewire.com> <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	piet.delaney@gmail.piet.net,
	Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org,
	piet.delaney@gmail.com, Piet Delaney <pdelaney@bluelane.com>
To: Marco Costalba <mcostalba@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 01:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iif0H-0000sy-P4
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 01:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933702AbXJRXl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 19:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933650AbXJRXl7
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 19:41:59 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:1163 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933519AbXJRXl5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 19:41:57 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 18 Oct 2007 19:41:56 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <e5bfff550710171626h733228aw7a251746d2b43c63@mail.gmail.com>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 18 Oct 2007 23:41:56.0430 (UTC) FILETIME=[780996E0:01C811E0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61576>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marco Costalba wrote:
> On 10/17/07, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
>> You could avoid the temporary files if you just pipe the diff to kompare. That
>> would require an option to tell qgit that the external viewer can read a git diff.
>>
>> At the time qgit 1.5 was written, kompare could not handle git diffs.
>>
> 
> So does the other tools I have checked at that time.
> 
> But I don't know if this fixes the problem of slowness reported. A
> little test Pete may do is just as I have written in the former email:
> try to save the big files that cause troubles where he prefers and run
> Kompare on them directly from the command line.
> 
> Is kompare faster? If no probably the 'pipe' technique will not solve
> the problem and shrinks the applicability of the external diff
> launcher to tools that handle diffs directly.

Marco:
   I'll try kcompare on the huge files both on and off the NFS
   file system to see if it has a noticeable impact.

Johannes:
  I read somewhere in the past week that it was possible to maintain
  our existing CVS environment with git. I though it was a separate
  package to export git back to cvs but I just noticed a git-cvsserver
  and as a std part of git and was wondering about using that.

  We have a number of build machines with flamebox perl scripts pulling
  out CVS branches for builds. I was wondering what is the best way to
  use git and it's nicer pull/push model and merge facility and possibly
  maintain CVS exports for scripts doing builds if possible the cvsweb
  and bonsai (CVS Query Form) that a number of engineers are currently
  using. I started looking over out flamebox scripts with the intent
  up converting them over to git but I mentioned the git to cvs
  coexistence and we are wondering if that's a better route than
  upgrading the flamebox scripts. Having our existing cvsweb, bonsai,
  and gitweb along with the git utilities seems at least desirable.
  Any thoughts or suggestions?

- -piet

> 
> Marco

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHF+8/JICwm/rv3hoRApKnAJ4suTVrULHeVnU2HrS3TDo+eTzxVQCbBH7x
NzKdc6wRc1VdAOWgXOXBJ4U=
=RuQc
-----END PGP SIGNATURE-----
