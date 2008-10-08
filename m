From: Andreas Ericsson <ae@op5.se>
Subject: Re: files missing after converting a cvs repository to git
Date: Wed, 08 Oct 2008 08:16:56 +0200
Message-ID: <48EC5058.5020509@op5.se>
References: <799406d60810061502y417ec53o1a1f5cef800dfe45@mail.gmail.com>	 <48EAFCEF.8030907@op5.se> <799406d60810070855y53cf5191m111ce8f5380f96c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 08:18:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSND-0007Eg-2z
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbYJHGRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbYJHGRD
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:17:03 -0400
Received: from mail.op5.se ([193.201.96.20]:55084 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbYJHGRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:17:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B360D24B0013;
	Wed,  8 Oct 2008 08:09:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.752
X-Spam-Level: 
X-Spam-Status: No, score=-2.752 tagged_above=-10 required=6.6
	tests=[AWL=-0.253, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5v2ru0Cutflb; Wed,  8 Oct 2008 08:09:05 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.6])
	by mail.op5.se (Postfix) with ESMTP id 5EAC21B800F0;
	Wed,  8 Oct 2008 08:09:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <799406d60810070855y53cf5191m111ce8f5380f96c6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97762>

Adam Mercer wrote:
> On Tue, Oct 7, 2008 at 01:08, Andreas Ericsson <ae@op5.se> wrote:
> 
>> Has the CVS repo been tampered with in the past? If so, it's entirely
>> possible that checking out and working with CVS works just fine, but
>> getting history into coherent changesets is impossible.
> 
> Unfortunately yes. Thats what I thought, and was afraid, was going on.
> I've managed to get things working by restoring some of the missing
> files ,v files from a backup and regenerating the tracking
> repositories. Then I had to remove the files in question from cvs and
> readd them, git cvsimport then saw these files.
> 

Ouch. In that case, all bets are off when it comes to correctly cloning
the history, I'm afraid. On the up-side, if you get a oneshot conversion
done properly you can easily convert it to something else later in case
git doesn't meet your needs, and it might even be easier to add commit
support to "git cvsserver" than it is to fix your broken repository
(it might be in there already; I don't use it so I don't know), in
which case you can use CVS with a git object store.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
