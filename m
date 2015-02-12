From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/8] reflog_expire(): ignore --updateref for symbolic
 references
Date: Thu, 12 Feb 2015 17:08:53 +0100
Message-ID: <54DCD015.2080002@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>	<1423473164-6011-7-git-send-email-mhagger@alum.mit.edu> <CAGZ79kZvM4FeHQ074kh7qhsz8cHgGaHxOruP7CM2DgPJErkA-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 17:09:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLwKE-0001eY-2u
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 17:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbbBLQJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 11:09:04 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:55469 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932231AbbBLQJC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 11:09:02 -0500
X-AuditID: 1207440d-f79976d000005643-33-54dcd0172388
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.42.22083.710DCD45; Thu, 12 Feb 2015 11:08:56 -0500 (EST)
Received: from [192.168.69.130] (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CG8rL1016218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 11:08:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAGZ79kZvM4FeHQ074kh7qhsz8cHgGaHxOruP7CM2DgPJErkA-w@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqCtx4U6IwSxDi64r3UwWDb1XmC3e
	3lzCaNE95S2jRW/fJ1aLzZvbWRzYPHbOusvusWBTqcfFS8oenzfJBbBEcdskJZaUBWem5+nb
	JXBnHJo6l61gsUTFjN2fmRoYtwt3MXJySAiYSPzf0MsGYYtJXLi3Hsjm4hASuMwo0dXzmRHC
	Oc8k8fvNFKYuRg4OXgFtiVlzxUFMFgFViZYLUSC9bAK6Eot6mplAbFGBIIlDpx+zgNi8AoIS
	J2c+AbNFBNQkZq6aDTafWWAek8SV9p9gi4UFwiTWv3nEArHrAKPE7aNf2EEWcAoESiw+lQFS
	wyygLvFn3iVmCFteonnrbOYJjAKzkOyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/Py
	Uot0jfRyM0v0UlNKNzFCwpt3B+P/dTKHGAU4GJV4eAOM74QIsSaWFVfmHmKU5GBSEuXtOgwU
	4kvKT6nMSCzOiC8qzUktPsQowcGsJMIbtQwox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKa
	nZpakFoEk5Xh4FCS4GU7D9QoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rU+GJg
	rIKkeID2uoC08xYXJOYCRSFaTzEqSonznj4HlBAASWSU5sGNhSWtV4ziQF8K88qCtPMAEx5c
	9yugwUxAgyfOuA0yuCQRISXVwBin9eYvH+ePtnqLW/fv3n/jz/LHIH/11ZVdD1fozdz7Y07P
	Q4ZrDyQP33j47c2brMsSVcLNM5ft7p3gKq1SoD0p4Kxe2d4vKpMX80YtnRSU7Oid 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263742>

On 02/11/2015 01:44 AM, Stefan Beller wrote:
> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> 
>> If we are expiring reflog entries for a symbolic reference, then how
>> should --updateref be handled if the newest reflog entry is expired?
>>
>> Option 1: Update the referred-to reference. (This is what the current
>> code does.) This doesn't make sense, because the referred-to reference
>> has its own reflog, which hasn't been rewritten.
>>
>> Option 2: Update the symbolic reference itself (as in, REF_NODEREF).
>> This would convert the symbolic reference into a non-symbolic
>> reference (e.g., detaching HEAD), which is surely not what a user
>> would expect.
>>
>> Option 3: Error out. This is plausible, but it would make the
>> following usage impossible:
>>
>>     git reflog expire ... --updateref --all
>>
>> Option 4: Ignore --updateref for symbolic references.
>>
> 
> Ok let me ask a question first about the symbolic refs.
> 
> We used to use symbolic links for that, but because of
> portability issues we decided to not make it a link, but rather
> a standard file containing the pointing link (The content of
> .git/HEAD is "ref: refs/heads/master\n" except when detached)
> 
> So this is the only distinction? Or is there also a concept of
> symbolic links/pointers for the reflog handling?

A symbolic reference can have a reflog just like a normal reference can.

When a reference is updated through a symbolic reference, then
write_ref_sha1() writes a reflog entry for both the reference and the
symbolic reference. Also (as an extra kludge), if *any* reference is
updated directly and it happens to be the current HEAD reference, then
an entry is added to HEAD's reflog.

"HEAD" is the only symbolic reference that is ever transferred across
repositories.

Symbolic references are always stored loose (i.e., not in packed-refs).

Does that answer your questions?

>> We choose to implement option 4.
> 
> You're only saying why the other options are insane, not why this
> is sane.
> 
> Also I'd rather tend for option 3 than 4, as it is a safety measure
> (assuming we give a hint to the user what the problem is, and
> how it is circumventable)

This is a pretty exotic usage. I can't think of any real-life use case
for using "--updateref" together with a symbolic reference. In our
entire code base, "--updateref" is only used a single time, in
"git-stash.sh", and that is always for "refs/stash", which is never a
symbolic reference. "git-stash" itself is implemented in a very stylized
way ("stylized" being a polite way of saying "bizarre"), and I doubt
that there are many more users of this option in the wild, let alone
"--updateref" together with a symbolic reference.

So, honestly, I don't think it is worth the effort of deciding between 3
vs. 4. Since 4 is easier to implement (and already implemented), I'd
rather leave it as is. If you want to submit a patch implementing 3, I
won't argue against it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
