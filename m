From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Mon, 15 Oct 2007 23:05:41 -0700
Organization: Bluelane
Message-ID: <471454B5.7040802@bluelane.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>	 <20070709173720.GS29994@genesis.frugalware.org>	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>	 <4713FA4A.5090501@bluelane.com>	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>	 <471433F3.40606@bluelane.com> <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	free cycle <freecycler23@yahoo.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhfYz-0000cw-C3
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759184AbXJPGFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758202AbXJPGFr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:05:47 -0400
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:56846 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755255AbXJPGFq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 02:05:46 -0400
Received: from piet2.bluelane.com ([64.95.123.130]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 16 Oct 2007 02:05:45 -0400
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>
X-Enigmail-Version: 0.95.3
X-OriginalArrivalTime: 16 Oct 2007 06:05:45.0524 (UTC) FILETIME=[97353740:01C80FBA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61084>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marco Costalba wrote:

Hi Marco:

> On 10/16/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
>> I just download 'meld', looks interesting, I didn't know about it or
>> 'kompare'. Linking either one into gitk would be a pleasant graphical
>> 'bling'.
>>
> 
> In case you are interested a git GUI viewer called qgit can spawn
> 'Kompare' , 'Meld' or any other diff tool that support 'two files'
> command line interface:
> 
> $my_preferred_diff_tool  file1.txt file2.txt
> 
> And they will show what you are looking for. The input files are
> prepared by qgit that also handles the housekeeping at the end.

Great, I installed Qgit version 1.5.3 a while ago, I didn't
notice these advantages over gitq.

Yea, I just noticed, if I pull down External Diff in the files
window it tosses the diffs to Kompare. Super!


> Another feature you asked, i.e. CTRL + right click to select a
> revision (different from the parent) to diff against the current one
> is also already implemented.

It's not quite a intuitive/familiar as with bitkeeper. I suspect I just
need some practice. I selected a huge list if files that we use to
filter the release with and double clicked on the file I thought showing
to focus on that file. The I pulled down External Diff and it took for
ever; like it's confused.

Often we/I want to see the rev history for a particular file.
How would you do that with Qgit?

> 
> And of course the two above features can be integrated: you select two
> random revisions and then call the external diff viewer to check at
> the differences in the way you prefer.

Can I see just the revs for a particular file?

> 
> It is possible to download qgit from
> 
> http://sourceforge.net/project/showfiles.php?group_id=139897

I'll get the latest and greatest. Thinks. Often the problem is
having the current version of Qt3. My workstation is Mandrake
1005 Limited Edition (X11 Xinerama works on this release).
Looks like I have Qt3 on my workstation. Would it be worthwhile
to install Qt4 from src and try to use qgit-2.0?


> 
> Two versions:
> 
> qgit-1.5.7 is Qt3 based
> 
> qgit-2.0 is Qt4 based (works also under Windows)

What new features are in 2.0 over 1.5.7?

Thanks Marco,

- -piet

> 
> 
> 
> regards
> Marco

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHFFS0JICwm/rv3hoRAlFIAJsEbp22Fs1fGVlt+RIXOOjJ3ZiqIQCeIQ1/
nG/JJUfuNNyoIL2MUJppId4=
=JQWE
-----END PGP SIGNATURE-----
