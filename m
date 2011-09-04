From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Retrieving logs matching pattern for all time.
Date: Sun, 04 Sep 2011 11:59:26 -0700
Message-ID: <7vy5y4yvzl.fsf@alter.siamese.dyndns.org>
References: <CA+eQo_0gZpbz399GN1b+0mq8OY3Xoo+kij=UGSjwbJcNreYBvw@mail.gmail.com>
 <201109041813.24418.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremy Nickurak <vger-lists@trk.nickurak.ca>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Sep 04 21:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Hwp-0004mw-TN
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 21:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab1IDS7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 14:59:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35063 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab1IDS7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 14:59:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8612E300B;
	Sun,  4 Sep 2011 14:59:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mPHqdOLGi2JF1XXSobs/UBpsTlw=; b=rPo7Or
	smRqnDLpt932GOiccMXq7Hu5gLrhXvPo96uj3o5p47xktQnAyal7cXzWRZtVx9mg
	sx5iOifz0JhUbLZE1f9sX4QYa2ePqyC3sHnblM+2AMhwzxKeXU3Y/u9F2AxnoqWZ
	y414N1sOKsnH2e93X4ffJSs2YY3bXgWMi49yU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DACBfhzMTKRnt6hDDf/1uQDUZI3C8fGJ
	qZCfrSOoSTkodkyozasjjPGemFHsbXW5/SY0e+BBzC8BpvVRW0SfAS70pXvey9Dr
	7KYI+QUU15lAwTD1pvZR6eaCt5h17RmdPk087ISQC+hrzfR9JESWtzwu0LQ6UneO
	oKHFkq7KadQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D7D7300A;
	Sun,  4 Sep 2011 14:59:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4FED3009; Sun,  4 Sep 2011
 14:59:27 -0400 (EDT)
In-Reply-To: <201109041813.24418.trast@student.ethz.ch> (Thomas Rast's
 message of "Sun, 4 Sep 2011 18:13:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 037B1526-D728-11E0-82C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180693>

Thomas Rast <trast@student.ethz.ch> writes:

> Jeremy Nickurak wrote:
>> > user@host:~/something$ git log -- 'hel*'
>> > user@host:~/something$
>> 
>> IE, git doesn't seem to interpret globs itself in patterns.
>
> It does for me:
>
> thomas@thomas:~/g(next u+59)$ g log --oneline --name-status -- "REA*"
> f73b3af README: git lives at http://git-scm.com these days
> M       README
>
> etc.

The "git log" family learned globbing pathspecs in 1.7.5 if I believe the
Release Notes.
