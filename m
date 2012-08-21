From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git svn: don't introduce new paragraph for
 git-svn-id
Date: Tue, 21 Aug 2012 15:35:44 -0700
Message-ID: <7vsjbfc1q7.fsf@alter.siamese.dyndns.org>
References: <1343856197-6393-1-git-send-email-robert@debian.org>
 <20120801214318.GA10384@dcvr.yhbt.net> <5019AD3A.8030609@debian.org>
 <20120801230118.GA15479@dcvr.yhbt.net> <50315ED1.6080803@debian.org>
 <20120821214538.GA4879@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Luberda <robert@debian.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 22 00:35:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3x3D-0007bN-Dw
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 00:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab2HUWft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 18:35:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab2HUWfr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 18:35:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2127992B5;
	Tue, 21 Aug 2012 18:35:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ajz8hZGwfF+c+JIa8qHfh1hPGWo=; b=M0d3QF
	oyf0hD7OCefwkEi3CP6KLSYAl2rMo616TUKk2+GMLbI69EotJZmC6Qzi/ebbJcEi
	6YXBFWvcf53ZVqV2nb2YBrHZ+GcAaBzJhkQBwvp42zXbLIF/r5KELcm9+isUpRlY
	PvGDpEbhl+Yo+E0ungPTW9mCT6BVr/4gRj0mU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NdNaJAdmgVlCEaHJO6Dpwv8Ns20f00QR
	8C7wxAGP/Ll1qw1hNKaALyd59x7Fz+F4ZBWGhAXhHgtMuArHidALfmGN9saKdgf8
	lWYv2KBr5QDgK0/X4DvoFErZjfFBPUwTr5IMlJWxRkWgZRy2m+/SKZEm0EA3/Yfr
	x29AGtMYQ0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D65292B4;
	Tue, 21 Aug 2012 18:35:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75D0792B1; Tue, 21 Aug 2012
 18:35:46 -0400 (EDT)
In-Reply-To: <20120821214538.GA4879@dcvr.yhbt.net> (Eric Wong's message of
 "Tue, 21 Aug 2012 21:45:38 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CC76C58-EBE0-11E1-BAFB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204001>

Eric Wong <normalperson@yhbt.net> writes:

> Robert Luberda <robert@debian.org> wrote:
>> I have been quite a busy recently, so it took me longer that I thought.
>
> No worries, thanks for following up.
>
>> It was quite hard for me to think some sensible option name, and finally
>> have chosen --trim-svn-log (svn.trimsvnlog as config key name). Please
>> let me know if such name is ok for you. If not, I'll try to find a
>> different one (but as I wrote I'm not really good at giving names to
>> options/functions/variables, etc. :()
>
> I think having "svn" in "svn.trimsvnlog" twice is redundant and not ideal.
> Perhaps just --trim-log and svn.trimlog?

Do we ever want to trim "our" log when relaying the Git commits back
to subversion?  Having "svn" in "trimsvnlog" makes it clear that the
logs from subversion side is getting trimmed.

> Default behavior should not change, especially not without warning.

Makes sense.
