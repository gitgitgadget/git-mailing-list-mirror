From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Requirements for integrating a new git subcommand
Date: Fri, 23 Nov 2012 10:27:23 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1211231022440.1431@ds9.cixit.se>
References: <20121122053012.GA17265@thyrsus.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 10:27:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbpY0-0007II-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 10:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758666Ab2KWJ1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 04:27:31 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:54034 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758644Ab2KWJ13 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 04:27:29 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id qAN9RNM9006374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 23 Nov 2012 10:27:23 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id qAN9RN5Z006371;
	Fri, 23 Nov 2012 10:27:23 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20121122053012.GA17265@thyrsus.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 23 Nov 2012 10:27:23 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210248>

Eric S. Raymond:

> git-weave(1)

> Yes, there are scripts in contrib that do similar things.

I was just about to say that the import direction of this seems to 
fill the same need as contrib/fast-import/import-directories.perl that 
I submitted a few years back.

Your version seems only to be able to import a linear history, 
however, my tool does support creating merge commits (basically, the 
history I had to import was very messy and contained a lot of snapshot 
directories having been worked on in parallel).

> (b) I am shipping it with a functional test,

Hmm, indeed. I have been thinking of trying to wrap up the test suite 
I have locally into something that could work within the Git testing 
framework, but haven't found the time to or energy for so far.


Anyway, my sentiment is that if you can add support for merges in you 
weave tool, then I am very much for removing my old script from the 
repository.

-- 
\\// Peter - http://www.softwolves.pp.se/
