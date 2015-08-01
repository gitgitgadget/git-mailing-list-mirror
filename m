From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH/RFC 0/2] bisect per-worktree
Date: Sat, 01 Aug 2015 08:51:08 +0200
Message-ID: <55BC6C5C.1070707@alum.mit.edu>
References: <1438387012-29229-1-git-send-email-dturner@twopensource.com> <55BC4438.8060709@alum.mit.edu> <CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 08:51:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLQdZ-0007H8-JX
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 08:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbbHAGvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 02:51:13 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55594 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750856AbbHAGvM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Aug 2015 02:51:12 -0400
X-AuditID: 12074414-f794f6d000007852-93-55bc6c5fbd58
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id D7.60.30802.F5C6CB55; Sat,  1 Aug 2015 02:51:11 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB00E7.dip0.t-ipconnect.de [93.219.0.231])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t716p8sU008309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 1 Aug 2015 02:51:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAPc5daVnfit8pkjc2HCSn0erW-q++We8gx8tPsb_ptd5H+CpJg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqBufsyfUYNF/fYtNzycyW8zfdILR
	outKN5NFQ+8VZovuKW8ZHVg9ds66y+5x8ZKyx/IHr9g9Fjy/z+7xeZNcAGsUt01SYklZcGZ6
	nr5dAnfGgQ+FBXslKvZeO8LSwPhfuIuRk0NCwETi59NHzBC2mMSFe+vZQGwhgcuMEkceBncx
	cgHZZ5kklq66wg6S4BXQlni38R9YEYuAqkTrp41gcTYBXYlFPc1MXYwcHKICQRKvX+ZClAtK
	nJz5hAXEFhFQk5jYdgjMZhY4wijRe4AVpFxYwEBiwVUmiLVrGSXa7vGB2JwCgRIvTm1kgyhX
	l/gz7xIzhC0v0bx1NvMERoFZSDbMQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6
	Fnq5mSV6qSmlmxghwS2yg/HISblDjAIcjEo8vD9Y9oQKsSaWFVfmHmKU5GBSEuUViQIK8SXl
	p1RmJBZnxBeV5qQWH2KU4GBWEuFNMQfK8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0t
	SC2CycpwcChJ8AYnADUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2I0vhgYpSAp
	HqC93CDtvMUFiblAUYjWU4yKUuK8X7KAEgIgiYzSPLixsJT1ilEc6Eth3gKQdh5guoPrfgU0
	mAlocF/7DpDBJYkIKakGRnF5QZc1dkV//GNbuYJnysqI7c9yf13ulW2zM/nmqs27VNdc/JEf
	fnySkYhb7ZNl1dwOgqq7P7IHS0/dIruu/6L193Yeh+4jN+fYyQUt+Ox4jiMpl3XB 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275112>

On 08/01/2015 07:12 AM, Junio C Hamano wrote:
> On Fri, Jul 31, 2015 at 8:59 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>
>> It seems to me that adding a new top-level "worktree-refs" directory is
>> pretty traumatic. Lots of people and tools will have made the assumption
>> that all "normal" references live under "refs/".
>> ...
>> It's all a bit frightening, frankly.
> 
> I actually feel the prospect of pluggable ref backend more frightening,
> frankly ;-). These bisect refs are just like FETCH_HEAD and MERGE_HEAD,
> not about the primary purpose of the "repository" to grow the history of refs
> (branches), but about ephemeral pointers into the history used to help keep
> track of what is being done in the worktree upstairs. There is no need for
> these to be visible across worktrees. If we use the real refs that are grobal
> in the repository (as opposed to per-worktree ones), we would hit the backend
> databas with transactions to update these ephemeral things, which somehow
> makes me feel stupid.

Hmm, ok, so you are thinking of a remote database with high latency. I
was thinking more of something like LMDB, with latency comparable to
filesystem storage.

These worktree-specific references might be ephemeral, but they also
imply reachability, which means that they need to be visible at least
during object pruning. Moreover, if the references don't live in the
same database with the rest of the references, then we have to deal with
races due to updating references in different places without atomicity.

The refs+object store is the most important thing for maintaining the
integrity of a repo and avoiding races. To me it seems easier to do so
if there is a single refs+objects store than if we have some references
over here on the file system, some over there in a LMDB, etc. So my gut
feeling is for the primary reference storage to be in a single reference
namespace that (at least in principle) can be stored in a single ACID
database.

For each worktree, we could then create a different view of the
references by splicing parts of the full reference namespace together.
This could even be based on config settings so that we don't have to
hardcode information like "refs/bisect/* is worktree-specific" deep in
the references module. Suppose we could write

[worktree.refs]
	map = refs/worktrees/*:
	map = refs/bisect/*:refs/worktrees/[worktree]/refs/bisect/*

which would mean (a) hide the references under refs/worktrees", and (b)
make it look as if the references under
refs/worktrees/[worktree]/refs/bisect actually appear under refs/bisect
(where "[worktree]" is replaced with the current worktree's name). By
making these settings configurable, we allow other projects to define
their own worktree-specific reference namespaces too.

The corresponding main repo might hide "refs/worktrees/*" but leave its
refs/bisect namespace exposed in the usual place.

"git prune" would see the whole namespace as it really is so that it can
compute reachability correctly.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
