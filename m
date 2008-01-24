From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: CVS import: Changing/cleaning authors and committers
Date: Thu, 24 Jan 2008 17:12:58 +0000
Message-ID: <259E26A1-C9A9-4A92-BB54-77B43AC9E590@manchester.ac.uk>
References: <1424F1B0-7342-4436-9B4A-72D985DDA161@manchester.ac.uk> <20080124163719.GA17283@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 18:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI5dh-0005VB-6T
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 18:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619AbYAXRM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 12:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753469AbYAXRMZ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 12:12:25 -0500
Received: from tranquility.mcc.ac.uk ([130.88.200.145]:60015 "EHLO
	tranquility.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbYAXRMX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 12:12:23 -0500
Received: from gomwe.mcc.ac.uk ([10.2.18.2])
	by tranquility.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JI5cf-000GyY-5Z; Thu, 24 Jan 2008 17:12:17 +0000
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:55041)
	by gomwe.mcc.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.67 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1JI5ce-000CZ5-UZ; Thu, 24 Jan 2008 17:12:16 +0000
In-Reply-To: <20080124163719.GA17283@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.753)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:55041
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71633>


On 24 Jan 2008, at 16:37, Jeff King wrote:

> On Thu, Jan 24, 2008 at 03:12:08PM +0000, Robert Haines wrote:
>
>> I was wondering if it would be able to go through and change all  
>> that to:
>>
>> author Name <email@address>
>> etc
>>
>> Is this something that can be retrospectively done? Is it  
>> something that
>> can be done during cvsimport? Is it even doable?
>
> David already answered the second question, and it is probably simpler
> to just redo the import with -A unless there is some complication with
> that (like you no longer have access to the CVS files).
>
> However, to answer your first question: it can be fixed after the fact
> by rewriting history within the git repository; see git-filter-branch.

So ideally I would have spotted the -A flag originally! I have had  
something of an information overload with git, gitweb and so on  
recently.

I decided to re-import with the -A flag as there is (much) less  
chance of me mucking it up!

Thanks,
Rob
