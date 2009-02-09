From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
 as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 09:38:15 -0600
Message-ID: <49904DE7.2080205@codeweavers.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Ben Bucksch <ben.bucksch.news@beonex.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 16:39:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWYEb-00009O-95
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 16:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbZBIPiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 10:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbZBIPiS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 10:38:18 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:49169 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725AbZBIPiS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 10:38:18 -0500
Received: from localhost
	([127.0.0.1] helo=[216.251.189.140] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LWYDA-0001KT-NY; Mon, 09 Feb 2009 09:38:16 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <49903B27.8070608@beonex.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109082>

> 
> I don't know how you're injecting the email to Thunderbird. mailto:?

We have a utility, git-imap-send, that sends the email into the drafts
folder.

> 
> What you propose is a header, not a body.
> (I'm a bit irritated that TB would react to a charset header *in the 
> body*, but maybe that's a hack specially for charsets, in some code part 
> I don't know, given that they are unfortunately sometimes only marked in 
> content.)

Ah, rats.  I figured that picking charset out of the body might be
considered a bug; I was hoping it was a feature :-/.

> 
> I think it would most likely work easily if you inject HTML (read before 
> you scream):

/me carefully takes the nice coat with extra long sleeves out <grin>.

I've tried this, and *shudder*, it appears to work.

I'll cobble up an experimental patch to git-format-patch to see if
this is tractable.

Cheers,

Jeremy
