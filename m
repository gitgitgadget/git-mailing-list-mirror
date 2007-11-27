From: Andreas Ericsson <ae@op5.se>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Tue, 27 Nov 2007 15:11:39 +0100
Message-ID: <474C259B.1000705@op5.se>
References: <200711252248.27904.jnareb@gmail.com> <858x4l2apc.fsf@lola.goethe.zz> <alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:12:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1AV-0004Xs-8E
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbXK0OLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 09:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbXK0OLr
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:11:47 -0500
Received: from mail.op5.se ([193.201.96.20]:49351 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596AbXK0OLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 09:11:46 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6E3191F0803A;
	Tue, 27 Nov 2007 15:11:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MF4+hKRJKiyh; Tue, 27 Nov 2007 15:11:42 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 181B81F08037;
	Tue, 27 Nov 2007 15:11:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66212>

Nicolas Pitre wrote:
> On Mon, 26 Nov 2007, David Kastrup wrote:
> 
>> Get rid of plumbing at the command line level.
> 
> We can't get rid of plumbing.  It is part of Git probably forever and is 
> really really convenient for scripting in any language you want.  
> 
> The only valid argument IMHO is the way too large number of Git commands 
> directly available from the cmdline.
> 
> The solution: make purely plumbing commands _not_ directly available 
> from the command line. Instead, they can be available through 'git 
> lowlevel <blah>' instead of 'git <blah>' and only 'git lowlevel' would 
> stand in your shell default path.
> 
> Such a scheme can be implemented in parallel with the current one for a 
> release while the direct plumbing commands are deprecated in order to 
> give script authors a transition period to fix their code.
> 

The "git-cmd" form of writing commands was deemed obsolete round about
the time git.sh was rewritten in C. There's just no reason for it
anymore.

It's unfortunate that git-sh-setup makes it equally valid for scripts to
use either form, as we can never get rid of the dashed form when so many
scripts in the core distribution uses it.

Ah well.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
