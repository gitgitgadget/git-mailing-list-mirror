From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Extract remaining classes from git-svn
Date: Fri, 27 Jul 2012 12:00:06 -0700
Message-ID: <5012E536.5080507@pobox.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com>
 <5011E07A.807@pobox.com>
 <CABPQNSYjvW9GZs18j+m4mUT6jiJ5VTUdnyi-L5Q8tHeqE7R+tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net,
	jrnieder@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jul 27 21:00:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suplt-0001IL-CH
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 21:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab2G0TAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 15:00:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249Ab2G0TAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 15:00:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42A9B8568;
	Fri, 27 Jul 2012 15:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=Bq6XzFq88QmI
	tPX/z4kd67oyFhU=; b=vEsikmvdP85OvjGdRAjAJzPMghRHmEZTtm9kIkFxP+Y8
	N69ZQzRMdmULWJoA7UpS+Q6Ddjuie/3Fa/GuPeEH0JY/CQbEWjaERwDr/V4wYATq
	vsf47qk38oeSRMaZ1xBbFOUHrgDKdXQP1e4bc8vdcgTY5fAHIbFesMYXAlYJebI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FdSBtV
	9/IHUocnmB0ZRhRrjJYwuo+Af1BTPppMnXcHDibeKGvOQlG61QcBJ4P11dbRtRGM
	NxJyLkNrNvpGJwYwTEBJGNZoMHQBjRJY2nRvahBZvNcIf+dmaKmparMXsP/Wl1s7
	HikZshSS0ErYvRA427pyjLF6JeenSliocuHx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D4618563;
	Fri, 27 Jul 2012 15:00:10 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C787E8556; Fri, 27 Jul
 2012 15:00:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CABPQNSYjvW9GZs18j+m4mUT6jiJ5VTUdnyi-L5Q8tHeqE7R+tg@mail.gmail.com>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 48CB121A-D81D-11E1-A878-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202367>

On 2012.7.27 4:29 AM, Erik Faye-Lund wrote:
> On Fri, Jul 27, 2012 at 2:27 AM, Michael G Schwern <schwern@pobox.com> wrote:
>> On 2012.7.26 5:25 PM, Michael G. Schwern wrote:
>>> This series of patches extracts the remaining classes from git-svn.  They're
>>> all simple extractions and functionally have no change.
>>
>> PS  This is on top of the previous Git::SVN extraction patch series.
>>
> 
> Nice :-)
> 
> Do you have somewhere I can pull this from? I have a git-svn topic
> that I suspect will be much easier to maintain on top of these
> patches.

Why yes I do!
https://github.com/schwern/git

The git-svn branches should be fairly self explanatory and they stack on top
of each other.  I'll probably be doing a lot of rebasing still, but there
should be little content change up to git-svn/canonicalize-accessors.  Up to
there passes tests with SVN 1.6.

Things get a little fuzzy after that.


-- 
24. Must not tell any officer that I am smarter than they are, especially
    if it's true.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
