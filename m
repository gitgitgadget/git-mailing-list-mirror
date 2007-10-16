From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 08:10:53 +0200
Message-ID: <471455ED.8070408@viscovery.net>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47130B25.4010304@viscovery.net> <20071015231242.GR27899@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:11:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihfe0-0001LO-69
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbXJPGK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbXJPGK6
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:10:58 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:3320 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbXJPGK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 02:10:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ihfda-00069D-T3; Tue, 16 Oct 2007 08:10:43 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D84216B7; Tue, 16 Oct 2007 08:10:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071015231242.GR27899@spearce.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61087>

Shawn O. Pearce schrieb:
> Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Unfortunately, "Fetch" does not yet work[*] from within git-gui, so you 
>> have to fall back to git-fetch on the command line.
>>
>> [*] Note the distinction between "not available" and "does not work".
> 
> What's broken?  Is this that Git protocol dump showing up in
> git-gui's console window thing?
> 
> Are you using the C based fetch that is in git.git's next branch,
> or the shell script based one that is in master?  Which Tcl/Tk
> version are you using to run git-gui?

It's the scripted fetch that does not work. The symptom is that the output 
of at least one of the commands (upload-pack, I think, because what I see is 
wire protocol) goes to a newly spawned console instead of wherever it was 
redirected to.

I didn't bother reporting since builtin-fetch is on the way (which will 
hopefully make this a moot point) and our team here is comfortable with 
calling git fetch on the command line.

-- Hannes
