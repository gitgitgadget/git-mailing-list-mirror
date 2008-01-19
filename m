From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Sat, 19 Jan 2008 16:41:38 +0100
Message-ID: <143E9431-934C-4711-A580-8AC60A9D472E@lrde.epita.fr>
References: <4790BCED.4050207@gnu.org> <7vbq7ibxhh.fsf@gitster.siamese.dyndns.org> <4791C3A8.7000308@gnu.org> <alpine.LSU.1.00.0801191119050.5731@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 16:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGFqD-00055y-AZ
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 16:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757785AbYASPl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 10:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757655AbYASPl7
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 10:41:59 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:42284 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757529AbYASPl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 10:41:58 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1JGFpM-0008A0-W5; Sat, 19 Jan 2008 16:41:49 +0100
In-Reply-To: <alpine.LSU.1.00.0801191119050.5731@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71120>

On Jan 19, 2008, at 12:20 PM, Johannes Schindelin wrote:

> On Sat, 19 Jan 2008, Paolo Bonzini wrote:
>
>>> On the other hand, if you want to always cause an action before
>>> running a git opeation locally, you do not have to have a hook. You
>>> can just prepare such a message based on GNU ChangeLog and then run
>>> git-commit with -F, both inside your wrapper.
>>
>> I see two other possibilities:
>>
>> 1) [..]
>>
>> 2) [..]
>>
>> 3) [..]
>
> Of course, there is a fourth of "two other" possibilities:
>
> Make a script calling git-commit with "-F - -e" and pipe your  
> generated
> template into it.
>
> Use this script whenever you want to create a new commit.


That's what I've done for over a year (http://repo.or.cz/w/svn- 
wrapper.git -- it started out as a wrapper around SVN but also works  
fine with Git) and many people also made their own script to achieve  
something similar (e.g, vc-dwim http://lists.gnu.org/archive/html/bug- 
gnulib/2007-10/msg00135.html).

Having such a wrapper in Git would just make our life easier.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory
