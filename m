From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Re: Storing Maintainers info around the kernel tree
Date: Fri, 17 Aug 2007 08:25:20 +0200
Message-ID: <46C53F50.9040107@s5r6.in-berlin.de>
References: <Pine.LNX.4.44L0.0708162156550.9927-100000@netrider.rowland.org>
	<46C5057C.5010602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Salikh Zakirov <salikh@gmail.com>,
        LKML Kernel <linux-kernel@vger.kernel.org>,
        Kyle Moffett <mrmacman_g4@mac.com>, Junio C Hamano <gitster@pobox.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pm@lists.linux-foundation.org, git@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
X-From: linux-pm-bounces@lists.linux-foundation.org Fri Aug 17 08:27:09 2007
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Envelope-to: gll-linux-pm@gmane.org
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILvIY-0004mn-Hc
	for gll-linux-pm@gmane.org; Fri, 17 Aug 2007 08:27:06 +0200
Received: from murdock.linux-foundation.org (localhost [127.0.0.1])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7H6QTsS001623;
	Thu, 16 Aug 2007 23:26:29 -0700
Received: from einhorn.in-berlin.de (root@einhorn.in-berlin.de [192.109.42.8])
	by smtp2.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	l7H6PUr1001588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-pm@lists.linux-foundation.org>;
	Thu, 16 Aug 2007 23:25:33 -0700
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.42] (k5.avc-online.de [83.221.230.29])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id
	l7H6PKxc009614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 17 Aug 2007 08:25:22 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US;
	rv:1.8.1.6) Gecko/20070807 SeaMonkey/1.1.4
In-Reply-To: <46C5057C.5010602@gmail.com>
X-Enigmail-Version: 0.95.2
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.22
Received-SPF: pass (localhost is always allowed.)
X-Spam-Status: No, hits=-3.222 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-BeenThere: linux-pm@lists.linux-foundation.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Linux power management <linux-pm.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>, 
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>, 
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56046>

Rene Herman wrote:
> On 08/17/2007 03:58 AM, Alan Stern wrote:
> 
>> On Fri, 17 Aug 2007, Rene Herman wrote:
>>
>>> On 08/16/2007 11:39 PM, Stefan Richter wrote:
>>>> Rene Herman wrote:
> 
>>>>> I personally don't think there's a whole lot wrong with more and
>>>>> more expecting people who submit patches (for whom this automation
>>>>> is intended) to be using git.
>>>>
>>>> You mean "people who frequently submit patches for various different
>>>> subsystems".
>>>
>>> Erm, I guess. Is that agreeing or disagreeing with me?
>>
>> Don't forget also that the MAINTAINERS information is (or should be!)
>> used by people who want to submit bug reports, not just by people who
>> submit patches.  Bug reporters shouldn't need to use Git.

Yes, problem reporters and people who infrequently (or for their first
time) submit patches, and even people who frequently submit patches but
most of the time only to the same one or two subsystems need an obvious,
tool-independent way to get contact information.

> Like I said:
> 
>>> If it's about non-developer users, I suspect it would to a fairly large
>>> degree be an "in theory" thing to expect that said user does want the
>>> information in a downloaded releases, but not in git, and not online
>>> where git-web could also easily display all the information right
>>> alongside the files.
> 
> And again, generating the MAINTAINERS file/info into releases is fine as
> well.

Good.  This generated data will be used by almost everyone except for a
certain special group of submitters.
-- 
Stefan Richter
-=====-=-=== =--- =---=
http://arcgraph.de/sr/
