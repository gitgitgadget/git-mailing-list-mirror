From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 09:40:17 -0800
Message-ID: <7vd4s1sm7y.fsf@gitster.siamese.dyndns.org>
References: <478D79BD.7060006@talkingspider.com>
	<vpq4pdeum3v.fsf@bauges.imag.fr>
	<alpine.LSU.1.00.0801161035380.17650@racer.site>
	<18317.60797.644829.539598@lisa.zopyra.com>
	<vpq4pderm7k.fsf@bauges.imag.fr>
	<alpine.LSU.1.00.0801161244390.17650@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Bill Lear <rael@zopyra.com>,
	Mike <fromlists@talkingspider.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:41:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFCG1-00073X-2B
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 18:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbYAPRk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 12:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbYAPRk2
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 12:40:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbYAPRk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 12:40:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 75EB64666;
	Wed, 16 Jan 2008 12:40:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C2CC34663;
	Wed, 16 Jan 2008 12:40:19 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0801161244390.17650@racer.site> (Johannes
	Schindelin's message of "Wed, 16 Jan 2008 12:45:52 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70707>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Yes, so you can use
>> 
>> $ git --work-tree . --git-dir /some/other/place <some-command>
>> 
>> But it's far from the user-friendlyness of a real lightweight checkout: 
>> you need to provide the --work-tree and --git-dir options each time you 
>> run git. And making an alias or using the environment variables are not 
>> really an option if you have more than one repository or working tree to 
>> deal with.
>
> Well, the OP said he did not want _any_ file in the worktree.  So there's 
> no way around specifying by hand everytime where the git directory should 
> be.

Export GIT_DIR and GIT_WORKTREE and you are free to go, right?
