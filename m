From: Paul Gardiner <paul@laser-point.co.uk>
Subject: Re: What am I doing wrong?
Date: Fri, 16 May 2008 14:28:11 +0100
Message-ID: <482D8BEB.6070706@laser-point.co.uk>
References: <482D6F41.2060809@laser-point.co.uk> <g0js1p$l22$1@ger.gmane.org> <482D7EE1.9020503@laser-point.co.uk> <g0jvig$1dn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri May 16 15:29:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwzzp-0007ls-9o
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 15:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbYEPN2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 09:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755730AbYEPN2U
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 09:28:20 -0400
Received: from mk-outboundfilter-5.mail.uk.tiscali.com ([212.74.114.1]:64157
	"EHLO mk-outboundfilter-5.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755546AbYEPN2T (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 09:28:19 -0400
X-Trace: 28413543/mk-outboundfilter-5.mail.uk.tiscali.com/PIPEX/$ACCEPTED/pipex-customers/81.86.57.226
X-SBRS: None
X-RemoteIP: 81.86.57.226
X-IP-MAIL-FROM: paul@laser-point.co.uk
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlABAPsoLUhRVjni/2dsb2JhbAAIrg0
X-IronPort-AV: E=Sophos;i="4.27,497,1204502400"; 
   d="scan'208";a="28413543"
X-IP-Direction: IN
Received: from 81-86-57-226.dsl.pipex.com (HELO [10.0.0.24]) ([81.86.57.226])
  by smtp.pipex.tiscali.co.uk with ESMTP; 16 May 2008 14:28:15 +0100
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <g0jvig$1dn$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82284>

Michael J Gruber wrote:
> Paul Gardiner venit, vidit, dixit 16.05.2008 14:32:
>> Michael J Gruber wrote:
>>> Paul Gardiner venit, vidit, dixit 16.05.2008 13:25:
>>>> I create the initial repository with
>>>>
>>>>      git-clone /<full-path>/<name>.git/ <folder>
>>>>
>>>> That works fine, but then I can't fetch. git-fetch gives the error
>>>> "fatal: 'origin': unable to chdir or not a git archive"
>>>> "fatal: The remote end hung up unexpectedly"
>>>>
>>>> P.
>>> Are you trying to clone a bare repository?
>>> Or is your repo maybe at /<full-path>/<name> with a .git subdir?
>>
>> Yes, a bare repository.
> 
> Then, maybe the full list of command lines (including cd and git-fetch) 
> would be helpful in order to track this down.

Ok, sorry, thought it was probable something really obvious. Here's the
sequence (using git version 1.5.4).

$ git-clone /big/git/paul.git/ epage
Initialized empty Git repository in /home/paul/epage/.git/
719749 bolcks
$ cd epage
$ git-fetch
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly



P.
