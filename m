From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: git rebase -i <first_commit_in_repository>
Date: Mon, 26 Oct 2009 21:28:25 +0100
Message-ID: <4AE60669.9080402@dirk.my1.cc>
References: <2b05065b0910261014t4eb93952oc804bcd01b339a84@mail.gmail.com>	 <40aa078e0910261025l1ad7bf8ex27fd62072a317f9d@mail.gmail.com> <2b05065b0910261108g4a8448c8x295606a8d33612f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, git@vger.kernel.org
To: eschvoca <eschvoca@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:31:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2WDt-00086T-NF
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 21:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbZJZUbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 16:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755474AbZJZUbO
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 16:31:14 -0400
Received: from smtprelay09.ispgateway.de ([80.67.29.23]:60035 "EHLO
	smtprelay09.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbZJZUbO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 16:31:14 -0400
Received: from [84.176.92.58] (helo=[192.168.2.100])
	by smtprelay09.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1N2WCu-0003Vg-V8; Mon, 26 Oct 2009 21:30:25 +0100
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <2b05065b0910261108g4a8448c8x295606a8d33612f5@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131265>

Am 26.10.2009 19:08 schrieb eschvoca:
> On Mon, Oct 26, 2009 at 1:25 PM, Erik Faye-Lund
> <kusmabite@googlemail.com> wrote:
>> On Mon, Oct 26, 2009 at 6:14 PM, eschvoca <eschvoca@gmail.com> wrote:
>>> Hi,
>>>
>>> Is there a way to rewrite history, including the first commit.  It
>>> seems that the first commit can not be modified with a rebase.
>> This question is answered in the FAQ:
>> http://git.or.cz/gitwiki/GitFaq#HowdoIedittherootcommit.3F
>>
> 
> Thanks Eric.  Hopefully someone will enhance rebase to handle the root commit.

Hi,

probably my approach could help you in the future: When I create a new 
repo (git init) I firstly create an initial commit with nothing else 
than an initial commit, i.e.:

$ git init
$ echo "initial" > initial.commit
$ git add initial.commit
$ git commit -m "Initial commit"

and then secondly

$ git add .
$ git commit -m "*REAL* initial commit"

Afterwards I have a repo with an initial commit that only contains one 
file (initial.commit) and the "real" initial commits thereafter. Maybe 
that's a solution for you.

Cheers,
     Dirk
