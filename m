From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] completion: Change "if [...]" to "if test ..." to
 match git convention
Date: Wed, 11 Feb 2009 09:14:51 -0800
Message-ID: <7vljscgak4.fsf@gitster.siamese.dyndns.org>
References: <1234366634-17900-1-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-2-git-send-email-ted@tedpavlic.com>
 <1234366634-17900-3-git-send-email-ted@tedpavlic.com>
 <20090211162432.GF30949@spearce.org> <4992FE78.6000206@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:16:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXIhH-0003Fs-BI
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757796AbZBKRO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757544AbZBKRO7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:14:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757412AbZBKRO6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:14:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EE6062AEB1;
	Wed, 11 Feb 2009 12:14:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0132D2AEAE; Wed,
 11 Feb 2009 12:14:52 -0500 (EST)
In-Reply-To: <4992FE78.6000206@tedpavlic.com> (Ted Pavlic's message of "Wed,
 11 Feb 2009 11:36:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8182E796-F85F-11DD-BADA-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109449>

Ted Pavlic <ted@tedpavlic.com> writes:

>> NAK.
>>
>> This script only runs in bash.  bash supports [...].  The
>> prevailing convention in the script is to use [...].  Only
>> 4 tests inside of __git_ps1 use "test", the rest of the code
>> is using [...].
>
> So this trumps Documentation/CodingGuidelines, which says:
>
>  - We prefer "test" over "[ ... ]".
>
> ?

No, this paragraph from Documentation/CodingGuidelines trumps you.

    As for more concrete guidelines, just imitate the existing code
    (this is a good guideline, no matter which project you are
    contributing to). It is always preferable to match the _local_
    convention. New code added to git suite is expected to match
    the overall style of existing code. Modifications to existing
    code is expected to match the style the surrounding code already
    uses (even if it doesn't match the overall style of existing code).
