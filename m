From: Michael G Schwern <schwern@pobox.com>
Subject: Re: Teach Makefile.PL to find .pm files on its own
Date: Wed, 25 Jul 2012 15:56:14 -0700
Message-ID: <5010798E.6020401@pobox.com>
References: <1343186471-1024-1-git-send-email-schwern@pobox.com>
 <7vhasvdbk9.fsf@alter.siamese.dyndns.org> <5010567B.1060907@pobox.com>
 <7vehnzbmyt.fsf@alter.siamese.dyndns.org> <50106136.5000404@pobox.com>
 <7vsjcfa3ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:56:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuAVC-0007Zc-7G
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 00:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962Ab2GYW4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 18:56:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab2GYW4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 18:56:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFBF68AED;
	Wed, 25 Jul 2012 18:56:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=KAdFP1yVUNOd
	H26N6V566nRchRI=; b=oFWGO/VErNb/YbKK/YPopr7YTTUbSNhVILDLOw5LnSCy
	ecDoP+GOElCLjGVmhVS4Efz7yIupaLNCRoq0JdvoyQ5dvKk48Er4dhuvhYHdaSoX
	Fq4wTH5xxjlXwBFkdaMrxdyzlD3fzPRzikzxDjKPqfrC0LroTzsg3sRos8KyQSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kh4OE/
	KwwSrcowbfpodt2rCzLWEhcKKk0li9jFP/DgwB3GivHsnMQWXPgRn7LXTgxfR4vl
	L5fiaIfUT3gx+PUbdlUCpMAR6A4RN+i6HU0d08qrtxz4yL8uo1shxmfn5+DaMn+o
	BIb2FRECMCfwsYKrXhv6Rs4NUAQJChvFNInk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC9C28AEC;
	Wed, 25 Jul 2012 18:56:15 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D8378AEA; Wed, 25 Jul
 2012 18:56:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vsjcfa3ha.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: F02CD14C-D6AB-11E1-9DE1-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202213>

On 2012.7.25 3:19 PM, Junio C Hamano wrote:
> Michael G Schwern <schwern@pobox.com> writes:
>> How about the git-svn SVN 1.7 fix in general?  All of these patch sets I'm
>> sending build on one another, is that going to be a problem?  It's going to
>> come in about six parts.
> 
> Judging from the rate of the discussion this is progressing, I was
> imagining that this series would be ready by 1.7.13 at the earliest,
> possibly back-merged to 1.7.12.X maintenance series, and 1.7.11.X
> maintenance series is no longer relevant by then.
> 
> But I certainly do not mind seeing the series based on earlier
> maintenance releases, e.g. maint-1.7.9.  There however are tons of
> other git-svn.perl and perl/ updates since then, so basing the
> series on the current maint branch to abandon 1.7.10.X and earlier
> but still leaving the door open to downmerge to 1.7.11.X may be a
> good trade-off.

So... is that master or maint?  Just let me know which one.


-- 
91. I am not authorized to initiate Jihad.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
