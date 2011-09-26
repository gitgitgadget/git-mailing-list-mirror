From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Mon, 26 Sep 2011 11:52:53 -0700
Message-ID: <7vmxdr2l16.fsf@alter.siamese.dyndns.org>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
 <CAP2yMaL3rewYZSXQFxkSLkiNbaBAP8r707x2dScVK1zeVr8hXQ@mail.gmail.com>
 <7vvcsjuojp.fsf@alter.siamese.dyndns.org>
 <7vsjnnt5vg.fsf@alter.siamese.dyndns.org>
 <CAP2yMaL=Ox7mFQSA8yyOB9CoBaa_pQQ3bE4B9FugOnfJCT6XeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 20:53:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8GIg-0001bK-LD
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 20:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab1IZSw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 14:52:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab1IZSw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 14:52:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D62D4E39;
	Mon, 26 Sep 2011 14:52:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fV1E5lLWt7jgzzk3G/uyQ/YVmfE=; b=XprHGy
	XioeoW+gfpDqI1W1jXL/baevZJX3OcgoFDrc9HeHjkmr7eXM17QZIm0IfLph7wCf
	qOv80VjtzaREhH2kqh+bc1bWEglCzTDDCBTD4BMPZ5qE0OBgmDOIOZ1V5H6+ncaZ
	2TPwXic+0EIaVINMatA+7nYkzH+g+fgxOpUb8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ROv46TsrH3V8DVDLtaWZxUxeOteSFLVj
	QMgRDNOr22ud0vrL/bMe43ZUCLBgL0ktIXkRTI7IvauWUY41eB4+ALhQtuf+lKW9
	vZbwZS2oA5/Ke4HsmbVlqeOOitoXJgqZSug8EsMvj2t6+tRqLA4h9Jm7vszhk1iJ
	Hya7bz/yO1s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54CB44E38;
	Mon, 26 Sep 2011 14:52:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA43D4E36; Mon, 26 Sep 2011
 14:52:55 -0400 (EDT)
In-Reply-To: <CAP2yMaL=Ox7mFQSA8yyOB9CoBaa_pQQ3bE4B9FugOnfJCT6XeA@mail.gmail.com> (Scott
 Chacon's message of "Mon, 26 Sep 2011 07:03:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BEEE6A0C-E870-11E0-BBB1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182149>

Scott Chacon <schacon@gmail.com> writes:

> On Fri, Sep 23, 2011 at 12:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> It just occurred to me that https://github.com/git/git repository might be
>> the one you are talking about, but that repository is not even mine. The
>> page at https://github.com/git says git@logicalawesome.com is its contact
>> person.
>>
>> I _suspect_ it is set up to mirror from my k.org repository and obviously
>> nothing is updated from that route for the past few weeks. It is correct
>> to say "html branch in that repository is no longer updated", but I cannot
>> do anything about that repository ;-).
>
> git/git is a mirror I set up from k.org years ago for git-scm.com. I
> believe you've been a collaborator on it for a while now, so you can
> push to it if you'd like.  The mirroring system is down since k.org
> died and I've since moved it off the host I had been using to Heroku,
> so I can't do the mirroring that way anymore.  If you want to push to
> it I'll leave it there, otherwise I'll reroot your repo to be the head
> of the GitHub network instead.

Ok, to clarify this discussion for people who have been pulling from me
and have been wondering where to reset their "origin" to...

 * I'll start to also push into https://github.com/git/git/ directly,
   treating it like git://repo.or.cz/alt-git.git/ and other secondary
   distribution points, that have the integration branches, todo, html and
   man.

 * Eventually git://git.kernel.org/pub/scm/git/git.git/ will again start
   receiving my direct pushes just like it used to. The secondary
   distribution points will also get my pushes directly (I've made sure
   with Scott that mirroring into https://github.com/git/git/ from my
   k.org repository will stay turned off).

 * https://github.com/gitster/git.git/ will stay a mirror of my private
   development repository with the topic branches (but without non-source
   branches like html and mah).

I haven't figured out how the preformatted documentation branches will be
managed in the longer term, as it seems likely that I no longer would have
the post-update hook access to update them upon pushing into my k.org
repository. I might end up dropping these branches altogether if it gets
too cumbersome for me to maintain, but I do not know yet.
