From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git pull --rebase differs in behavior from git fetch +
 git rebase
Date: Fri, 27 Aug 2010 21:13:03 -0600
Message-ID: <4C787EBF.7010802@workspacewhiz.com>
References: <4C772A01.5030207@workspacewhiz.com>	<alpine.DEB.2.00.1008270124450.20874@narbuckle.genericorp.net>	<4C77DE60.6020809@workspacewhiz.com>	<AANLkTimEO==c7Pzi99VfvDp7S9HN=V2j6t0kk--w1kb9@mail.gmail.com>	<4C783C66.3000008@workspacewhiz.com>	<AANLkTimBv3EVWaEnateD95sUi_LkmNw8RKJZYrW4dUFy@mail.gmail.com>	<4C786F36.3060107@workspacewhiz.com> <AANLkTimz4P3EGnZntQubL06ZqXREiDTDVk+fb9VVLDKN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dave Olszewski <cxreg@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 05:13:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpBrC-0007CE-TC
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 05:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab0H1DNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 23:13:06 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:49611 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab0H1DNE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 23:13:04 -0400
Received: (qmail 17121 invoked by uid 399); 27 Aug 2010 21:13:03 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 27 Aug 2010 21:13:03 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
In-Reply-To: <AANLkTimz4P3EGnZntQubL06ZqXREiDTDVk+fb9VVLDKN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154631>

  ----- Original Message -----
From: Elijah Newren
Date: 8/27/2010 8:40 PM
> On Fri, Aug 27, 2010 at 8:06 PM, Joshua Jensen
> <jjensen@workspacewhiz.com>  wrote:
>> Okay, there is _not_ a problem with the patch in 1.7.2.2 for the "broken"
>> repository I have in front of me right now, but I wish I hadn't trashed the
>> other broken repository someone else had.  :(
As it turns out, the other broken repository exists still, but it will 
be Monday before I can test against the 1.7.2.2 change.
>> Sorry for causing an issue, but I definitely appreciate the fix already
>> being available.
> Not a problem; it's totally understandable.  Believe me, I had a whole
> bunch of similar problems when trying to deal with this bug when
> people were hitting it at work (e.g. trying to duplicate by cloning,
> which never worked since the bug depended on reflog state).
Fortunately, I've worked with Git long enough now that I knew to direct 
copy the .git folder to the new location, 'git reset --hard' to get the 
files back, and hopefully then be in the same state.
> In any event, I'm glad it's working for you now.  :-)
Me, too.

Now, if only 'git rebase --preserve-merges' would work all the time and 
could be the default.  (I have instances where a topic branch is merged 
back to master with --no-ff to generate the merge commit, an attempt is 
made to push but new commits have been added from others, so a pull 
--rebase is performed and ends up replaying the merge linearly... no 
merge commit... oh, well.)

Take care.

Josh
