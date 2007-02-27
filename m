From: Junio C Hamano <junkio@cox.net>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 11:27:25 -0800
Message-ID: <7v8xejflk2.fsf@assigned-by-dhcp.cox.net>
References: <877iu3q13r.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Josefsson <simon@josefsson.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 20:27:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM7z2-00028z-QF
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 20:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbXB0T11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 14:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbXB0T11
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 14:27:27 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:46416 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbXB0T10 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 14:27:26 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227192726.NORZ6078.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 14:27:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UjTR1W00l1kojtg0000000; Tue, 27 Feb 2007 14:27:26 -0500
In-Reply-To: <Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 27 Feb 2007 13:37:23 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40770>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 27 Feb 2007, Simon Josefsson wrote:
>
>> * Is there a tool that produce ChangeLog files in the GNU format,
>>   based on the git logs?  Similar to the 'cvs2cl' tool.  The output
>>   should look like:
>> ...
> Let me hack something.

I do not know why you want to pile something like this into
builtin-log.  It would add maintenance burden and I do not see a
gain from it.

One beauty of git is being scriptable.  When somebody new asks
for something like this, I think it is much more productive to
demonstrate the power of scriptability than piling random crap
in the core.
