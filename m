From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 15:35:35 -0700
Message-ID: <7v628l85l4.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
 <7v628lbdcw.fsf@alter.siamese.dyndns.org>
 <CAE1pOi2DZNkYYwkH1MFh0m708T=DEdJawZCQgvk1HTGrqjkz2w@mail.gmail.com>
 <87lihh8c7s.fsf@thomas.inf.ethz.ch>
 <CAE1pOi3a9ZMFfJ2qjkaZ_O-DuQa3xkKtsMU5GYYUuiwcRoFjbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 00:35:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1PiC-0005DJ-VM
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 00:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab2HNWfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 18:35:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53938 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab2HNWfi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 18:35:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF5709D06;
	Tue, 14 Aug 2012 18:35:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aC+raZS+flK5yBNVRjrPEKTLoEM=; b=cEznsV
	U2RP6M6idEnEM+mqDNnMhDUCWwRvW3PVlNyDLByettumWpqbYaCTNdeqyBcUUF8M
	vv0CkE0NeAcJYQPiaZWnlScAxIt+ZDgblq0x+1tW765dUHVH3cdgm7Ayq/bj3CYt
	lvBGoIEIf9A/hcspbslBDjK5G3Xm6M6BILFLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCArTo9b6rk2Yd0NcPcyfBhZClYbkPK4
	uAbH/ziVEmeENo39xtlMtInnzdOAiWWrxrlv4yLCz2bkRaatDGQHDV/jODcFmtSo
	IsMPqPLClBSLbpZkkBW5bn4UlUGG81ACLsLCA/YF0Xbz3WyVYq38YMYia5/oK4EB
	16PepNMmWKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC2799D05;
	Tue, 14 Aug 2012 18:35:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10B7D9D04; Tue, 14 Aug 2012
 18:35:36 -0400 (EDT)
In-Reply-To: <CAE1pOi3a9ZMFfJ2qjkaZ_O-DuQa3xkKtsMU5GYYUuiwcRoFjbg@mail.gmail.com> (Hilco
 Wijbenga's message of "Tue, 14 Aug 2012 15:15:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E46CCAA-E660-11E1-A7A6-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203458>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

>> I meant something else than Junio hinted at.  Saying
>>
>>   git fetch origin master
>>   # or by extension
>>   git pull origin master
>>
>> does not update the origin/* namespace, not even origin/master.  All
>> fetching happens only into FETCH_HEAD.  This leads to confusion such as
>> yours because origin/master and thus the upstream tracking displays will
>> not know about the change.
>
> I'll say. Now I'm really confused.
>
> If what you say is true then what is updating origin/master? I've been
> using "git pull" daily for over a year and origin/master is definitely
> getting updated (at least according to gitk).

Now it is really the time for you to go back to "git fetch --help"
and read up on refspecs.

With

    $ git fetch origin

you are not telling "fetch" what to fetch, so it goes to your .git/config
and finds remote.origin section to find what refspec to use.  They
would say something like

	[remote "origin"]
        	url = ...
                fetch = refs/heads/*:refs/remotes/origin/*

meaning (see the manual) "fetch all the branches there, store them
with the corresponding name under  refs/remotes/origin".

With

    $ git fetch origin master

you are overiding the refspec in .git/config and explicitly saying
"I want to fetch the master branch, but do not want to update
anything with it".  It is a short-hand for

    $ git fetch origin refs/heads/master

which in turn is a short-hand for

    $ git fetch origin refs/heads/master:

If you wanted to update the tracking ref, you would use a refspec
with non-empty strings on the both sides of colon, i.e.

    $ git fetch origin master:refs/remotes/origin/master
