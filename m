From: Thomas Singer <thomas.singer@syntevo.com>
Subject: Re: OS X and umlauts in file names
Date: Fri, 27 Nov 2009 11:01:44 +0100
Message-ID: <4B0FA388.4030507@syntevo.com>
References: <4B0ABA42.1060103@syntevo.com>	 <alpine.LNX.2.00.0911231403100.14365@iabervon.org>	 <4B0CEFCA.5020605@syntevo.com> <76718490911260927h9ff796bgbebcccab7e52ffbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 11:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDxdE-0004so-Gy
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 11:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbZK0KAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 05:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754198AbZK0KAl
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 05:00:41 -0500
Received: from syntevo.com ([85.214.39.145]:54055 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751433AbZK0KAk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 05:00:40 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id 56F6037C7B3
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <76718490911260927h9ff796bgbebcccab7e52ffbe@mail.gmail.com>
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133886>

Jay Soffian wrote:
>>  toms-mac-mini:git-umlauts tom$ git status
>>  # On branch master
>>  #
>>  # Initial commit
>>  #
>>  # Changes to be committed:
>>  #   (use "git rm --cached <file>..." to unstage)
>>  #
>>  #     new file:   "U\314\210berla\314\210nge.txt"
>>  #
> 
> Wait, what's the problem here? It's staged according to the above,
> just commit it.

You are completely right and I feel quite foolish.

What about this one:

toms-mac-mini:git-umlauts tom$ git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file:   "U\314\210berla\314\210nge.txt"
#
toms-mac-mini:git-umlauts tom$ git rm --cached "U\314\210berla\314\210nge.txt"
fatal: pathspec 'U\314\210berla\314\210nge.txt' did not match any files

-- 
Thanks in advance,
Tom
