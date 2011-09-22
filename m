From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify that '--tags' fetches tags only
Date: Wed, 21 Sep 2011 21:28:15 -0700
Message-ID: <7vfwjpyzds.fsf@alter.siamese.dyndns.org>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
 <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
 <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
 <7vwrd1z9it.fsf@alter.siamese.dyndns.org>
 <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
 <CAMOZ1Bt6gGVd6QuRZduZ4mJ=eoZ9d7xK-WfwZ3G-+oswT0RN_Q@mail.gmail.com>
 <CAH5451nb=DTed2kAVNQmFBbGFJ9zvQAtBE+VCzKqZfGMgYpx5w@mail.gmail.com>
 <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Anatol Pomozov <anatol.pomozov@gmail.com>, git@vger.kernel.org,
	computerdruid@gmail.com
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 06:28:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6atf-0003f4-6u
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 06:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab1IVE2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 00:28:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751921Ab1IVE2S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 00:28:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21B96111C;
	Thu, 22 Sep 2011 00:28:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M72RbaCc/DDf1UwuMVfT7T3FbEY=; b=oRmqjx
	s1R8DA3nQgwPPE+e7kynSr+jIGzC+9V+pDHJpe7EU90wRltwjUZdgldeH1jKsov7
	7FD744hIeLxRmk6WlVYE1aDr6Ls2BNbo7SM42Y8bNvg4okO3gIwI0KZ1WFVIsG14
	DED5ljMntjgg0jhiAPosSz5Ubn7nOdn8hSYLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bA4+o9vVHsJ14tHi36XsYi8dx5rtCwJT
	WChHCOTLzN0AKGTF5fsZWx0djl63cSuNmlYV8v0Q/APqoTv1ouEQoE6jat+/dMLL
	B3VxQmRZJMQsBvgyZ4PiexvgwTENkb/mBQiax6VXEE6tKg5wzfWHWaYsJk0sNRAe
	dQgZdGd9hfk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17617111B;
	Thu, 22 Sep 2011 00:28:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FFA2111A; Thu, 22 Sep 2011
 00:28:16 -0400 (EDT)
In-Reply-To: <CAMOZ1BtPJ_Ddxo1UG2cxJMnGv9y8sR0rAyk3d_5JEz4kLsUQJQ@mail.gmail.com> (Michael
 Witten's message of "Thu, 22 Sep 2011 03:24:42 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AC3F5C0-E4D3-11E0-8283-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181884>

Michael Witten <mfwitten@gmail.com> writes:

> On Thu, Sep 22, 2011 at 03:13, Andrew Ardill <andrew.ardill@gmail.com> wrote:
>>
>> Maybe:
>>
>> Note that if this option is specified, then only tags
>> are fetched. No other refs, such as a remote tracking
>> branch, will be updated, even if it has been updated
>> on the remote end.
>>
>> extra info on how this option is merely a short-hand for writing the
>> refspec `refs/tags/*:refs/tags/* could go here
>
> Junio just explained why your description is inadequate and confusing.
> ...
> If I were a newbie and were to read the text that I just proferred as
> a clarification of --tags, then I would next look up just WTF a
> refspec is, and then a branch, and then...

I do agree with you that it is a futile exercise to sweep fundamental
concepts under the rug, fearing that they are too detailed and too hard
for the casual readers. By understanding how simple the fundamental
concepts and rules are, readers can have a coherent and clear mental model
of the world and synthesize these fundamental rules to understand more
complex operations the Porcelain commands offer to help every day tasks.

I however do not think, and I certainly did not mean, that the description
of "--tags" option is necessarily the place we should bombard a new user
with the term refspec and "refs/tags/*:refs/tags/*" syntax.

I expect the readers to, and I hope the documentation to help them to,
understand the following three basic facts and rules before diving into
descriptions of individual options, such as the paragraph we are
discussing:

 * "git fetch" command serves two purposes:

   (1) It transfers objects the repository the command is invoked in does
   not have from the remote repository. The objects transferred are the
   commits that are necessary to complete the ancestry chain of _some_
   history, and data (i.e. trees and blobs) associated to use these
   commits.

   (2) It optionally can update the local refs (e.g. branches and tags)
   with copies of the refs taken from the remote repository.

 * In the above, the user needs to tell the command two things. One is
   "where the remote repository is". The other is "what refs to fetch and
   (optionally) how to store them". The latter "what to fetch" also
   determines what that "_some_ history" above is (i.e. everything
   reachable from the refs that are fetched).

 * "What to fetch and how to store" have a default, recorded in the
   repository configuration file, that is used when the user does not give
   that information to the command from the command line. If the user does
   give that information from the command line, that default is not used
   at all. IOW, the command line overrides the default.

With that understanding, the _only_ thing that "--tags" description needs
to talk about is that it is an explicit way to give that "what to fetch
and how to store" information from the command line. It instructs the
command to fetch all the tags from the remote repository and store them
locally.

If the logic flow of the document presents the list of options before
helping the readers understand the above basic facts and rules, then I
think _that_ is the problem with the document we need to be addressing,
not the description of an individual option such as "--tags".
