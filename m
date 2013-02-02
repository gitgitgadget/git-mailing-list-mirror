From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: Enable tortoisemerge to handle filenames
 with spaces with TortoiseGitMerge
Date: Fri, 01 Feb 2013 18:08:18 -0800
Message-ID: <7vehgz8o31.fsf@alter.siamese.dyndns.org>
References: <50FBD4AD.2060208@tu-clausthal.de>
 <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de>
 <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de>
 <51024B02.9020400@tu-clausthal.de>
 <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
 <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org>
 <51032E96.2040209@tu-clausthal.de>
 <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com>
 <5104F009.5020606@tu-clausthal.de> <7vzjzuwm7s.fsf@alter.siamese.dyndns.org>
 <510C1872.3090304@tu-clausthal.de>
 <CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com>
 <510C229E.2050705@tu-clausthal.de>
 <CAJDDKr4L3efzp6eBdTKQxXu8sfvyT91bK6MNh5OhXzWvms8TtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 03:08:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1SX6-0008Ka-Rx
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 03:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757428Ab3BBCIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 21:08:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757349Ab3BBCIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 21:08:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09EFCBEDD;
	Fri,  1 Feb 2013 21:08:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fJLIYFKGmRlL8u9WpzK2Y3EAmrI=; b=WL3YYZ
	A4js+Fg26ataQUqrPu3Pc2R2ODSALg6ZldkH2Jq3na5lKbIDWgCcDiYBKfNAzC11
	eF2zG+ZX/9LvzEFleFOF2Gguf28ZSr5z5Qi6Zs9eLrVwz94Nhq1YcBxhYTop7CN7
	ngmVt3l+HeGCrCd3jqgcNQMd3f+mXSQ0t4NRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RvXv4L3HKoEgMn2ReuswEgUbKU+7aUyx
	WxN0/qf8lBeUIMK2s1FsKk/mWvEFqCWg8SufUts2OXpNGDoIvCYL/VDY9hqmwn4C
	nTA2RYkALS1LjISAPOO8kj9++CccUjOyohjFFDRSqTRnqPjdwZAaQf1NRXMidTwX
	Ka2sSxyjj60=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2F27BEDC;
	Fri,  1 Feb 2013 21:08:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BB17BEDB; Fri,  1 Feb 2013
 21:08:20 -0500 (EST)
In-Reply-To: <CAJDDKr4L3efzp6eBdTKQxXu8sfvyT91bK6MNh5OhXzWvms8TtQ@mail.gmail.com> (David
 Aguilar's message of "Fri, 1 Feb 2013 17:59:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A70227A-6CDD-11E2-A00A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215284>

David Aguilar <davvid@gmail.com> writes:

> On Fri, Feb 1, 2013 at 12:16 PM, Sven Strickroth
> <sven.strickroth@tu-clausthal.de> wrote:
>> TortoiseMerge caused to whole
>> argument instead of just the file name to be quoted
>
> s/caused to whole/caused the whole/
>
> I think this commit message is very nice.  Is it too late to replace
> the current patch with this one?

Haven't merged it to 'next'; I will replace with this, with a bit of
retitling to make it shorter.


commit 81ed7b9581f7eafb334824264abb492d85a5ffb8
Author: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Date:   Fri Feb 1 21:16:30 2013 +0100

    mergetools: teach tortoisemerge to handle filenames with SP correctly
    
    TortoiseGitMerge, unlike TortoiseMerge, can be told to handle paths
    with spaces in them by using -option "$FILE" (not -option:"$FILE",
    which does not work for such paths) syntax.
    
    This change was necessary because of MSYS path mangling [1], the ":"
    after the "base" etc. arguments to TortoiseMerge caused the whole
    argument instead of just the file name to be quoted in case of file
    names with spaces. So TortoiseMerge was passed
    
        "-base:new file.txt"
    
    instead of
    
        -base:"new file.txt"
    
    (including the quotes). To work around this, TortoiseGitMerge does not
    require the ":" after the arguments anymore which fixes handling file
    names with spaces [2] (as written above).
    
    [1] http://www.mingw.org/wiki/Posix_path_conversion
    [2] https://github.com/msysgit/msysgit/issues/57
    
    Signed-off-by: Sven Strickroth <email@cs-ware.de>
    Reported-by: Sebastian Schuberth <sschuberth@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
