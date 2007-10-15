From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 08:39:33 +0200
Message-ID: <47130B25.4010304@viscovery.net>
References: <1192293466.17584.95.camel@homebase.localnet>	<uy7e6keyv.fsf@gnu.org>	<1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>, Make Windows <make-w32@gnu.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Oct 15 08:39:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhJcB-0001O3-Pf
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 08:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbXJOGjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 02:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbXJOGjh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 02:39:37 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25261 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbXJOGjg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 02:39:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IhJbm-0004gd-Vj; Mon, 15 Oct 2007 08:39:23 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4563C69F; Mon, 15 Oct 2007 08:39:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60952>

Benoit SIGOURE schrieb:
> Context: GNU make seems to be willing to switch from CVS to ... 
> something else.
> 
> On Oct 14, 2007, at 6:57 PM, Paul Smith wrote:
> 
>> [...] the big thing no one else seems to have addressed much in
>> other discussions I've seen is portability.  It LOOKS like there are
>> native ports of GIT to MINGW, but I have no idea how complete and usable
>> they are.  If someone who has a Windows system could look into that it
>> would be a big help.
> 
> I think the best thing to do is to ask directly on the Git ML.
> 
> Someone already pointed out that he'd like to use Git on Windows but 
> doesn't want to install either Cygwin or MSYS.  Is this possible, or 
> will it be possible in the near future?  Is it possible to use one of 
> the various GUIs (git-gui, gitk, qgit) on Windows without requiring a 
> POSIXish shell etc.?

FWIW, I'm using the MinGW port from cmd.exe, i.e. not from a posix shell, on 
a *production* repository. gitk and git-gui work. Not all operations that I 
regularly use are available[*] via the GUIs, like git-rebase or 
non-fast-forwarding push, so the use of the command line is needed from time 
to time.

Unfortunately, "Fetch" does not yet work[*] from within git-gui, so you have 
to fall back to git-fetch on the command line.

Of course, the Posix toolset, including a shell, must still be installed 
(and in my setup they are in the PATH), but you don't have to use it.

[*] Note the distinction between "not available" and "does not work".

-- Hannes
