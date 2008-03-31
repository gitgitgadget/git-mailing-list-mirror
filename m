From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: PVCS (or RCS) importer for Git?
Date: Mon, 31 Mar 2008 07:26:10 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0803310723440.26808@ds9.cixit.se>
References: <Pine.LNX.4.64.0803281713230.24460@ds9.cixit.se>
 <alpine.LSU.1.00.0803281730060.18259@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 08:26:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgDTs-0006ec-BU
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 08:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbYCaG0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 02:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbYCaG0O
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 02:26:14 -0400
Received: from ds9.cixit.se ([193.15.169.228]:52110 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbYCaG0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 02:26:13 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2V6QAwE027414
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Mar 2008 08:26:11 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m2V6QApf027409;
	Mon, 31 Mar 2008 08:26:10 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.LSU.1.00.0803281730060.18259@racer.site>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 31 Mar 2008 08:26:11 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78562>

Johannes Schindelin:

> I once tried, but apparently, there are different repository formats
> for PVCS. For example, pvcs2cvs did not work for me.

Yeah, the format is binary. That is why I am trying to use the
command-line tools.

> IIRC I used a simple shell script to convert pvcs (using the
> mega-slow command line tools) to ,v files.  Then I converted that to Git.

That is, more or less, what the pvcs2cvs script does. I've had some
success with it.

> Judging from the problems of importing CVS to Git (which mostly stem
> from the file-versioning paradigm), I suggest not trying to be too
> clever, but convert it to cvs and use a good cvs importer, such as
> cvs2svn (which despite its name also imports into Git) or parsecvs.

Given that the PVCS history file ("trail") that I was trying to follow
didn't quite work out, because there had been some direct manipulations
of the PVCS repository that were not recorded there, I think that is
the way I will have to go. That means I do lose the tagging
information (timestamp and tagger), but I can live with that...

Thanks for the input.
-- 
\\// Peter - http://www.softwolves.pp.se/
