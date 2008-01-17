From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: Re: [ANNOUNCE] Push Me Pull You 0.2 - Tech Preview Release
Date: Thu, 17 Jan 2008 01:56:54 +0000
Message-ID: <200801170156.55007.mark.williamson@cl.cam.ac.uk>
References: <200801152131.33628.mark.williamson@cl.cam.ac.uk> <200801162315.35288.mark.williamson@cl.cam.ac.uk> <46a038f90801161537r4013f30ale0ae3ecb43609cf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 02:59:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFK20-0002Jk-Ha
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 02:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbYAQB6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 20:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752859AbYAQB6c
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 20:58:32 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:37365 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbYAQB6b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 20:58:31 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from maw48.kings.cam.ac.uk ([128.232.236.103]:35501)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpsa (PLAIN:maw48) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1JFK1R-0000kN-4C (Exim 4.67)
	(return-path <maw48@hermes.cam.ac.uk>); Thu, 17 Jan 2008 01:58:25 +0000
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <46a038f90801161537r4013f30ale0ae3ecb43609cf2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70810>

> > Heheh, yeah, I was almost deafened by it :-)  But it's a new obscure
> > tool, written using an foreign SCM so I'm not surprised if uptake is
> > slow!
>
> I don't mind at all that it is hosted with Hg ;-) 

Incidentally, I didn't mean to imply that that was the only reason nobody 
responded.  But it's always a pain to think you have to get another SCM 
installed to get the latest source.  I put tarballs up for releases and 
occasional snapshots but I should probably enabled tarball download from the 
web interface...

> > I just looked at the  
> screenshots and description, and my feedback, as potential user, is
> that it isn't clear what I would use it for.

Well, that's fair enough :-)

>  - What's the usage scenario for a cli-oriented power user? I do use
> hg on other projects, but I'm happy to use its commandline tools.

As you rightly point out, there's not anything you can do with pmpu that you 
couldn't have managed on the CLI, the basic functionality is the same.  So 
nothing that compelling (yet).

I find the GUI is sometimes quicker to use, e.g. creating and e-mailing 
bundles.  I find that keeping a pmpu window open somewhere gives me handy 
feedback on what incoming / outgoing changes need dealing with.  The new 
annotate view provides live filtering, flexible viewing of metadata for each 
line in the file, etc.  That's going to be handy too, although it needs more 
work.

But again, you *can* do all that stuff on the commandline and for some people 
that's probably best.

You will notice, however, that I have included a CLI in the GUI.  Right now 
it's not that useful because it doesn't let you have any output ;-)  What I'd 
like to do is to integrate this more with the rest of the GUI in the style of 
the Hotwire shell (http://code.google.com/p/hotwire-shell/), e.g. intelligent 
completion, higher level interface to what you're trying to do, etc.  The 
power of the CLI interface plus the power of a flexible GUI to organise your 
thoughts.

>  - For a GUI user, how does it compare with using git gui when using
> git, and the equivalente gui when using hg?

The main advantage relative to those tools is probably that it supports a 
range of SCM backends and gives them a rather uniform user interface.  I'd 
say it's also a fairly simple interface to get started with, although I'm 
hardly a usability guru.  It's currently more limited than, say, git-gui 
because I've not yet added all the features I want.

My intention is to provide an alternative style of GUI to the existing tools, 
which may suit some people better.  Right now the main UI difference is the 
focus primarily on incoming / ougoing changeset flow.  I've got other ideas 
I'll be trying out in due course ;-)

Given the similarities of all the modern DVCS systems I think a sensible 
approach is to have a range of polished GUI tools, which can use a range of 
DVCS backends.  The trend towards this is already starting and I guess I'd 
like pmpu to one day be one of these ;-)

Cheers,
Mark

-- 
Push Me Pull You - Distributed SCM tool (http://www.cl.cam.ac.uk/~maw48/pmpu/)
