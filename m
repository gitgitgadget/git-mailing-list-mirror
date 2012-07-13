From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Teach remote.c about the remote.default
 configuration setting.
Date: Fri, 13 Jul 2012 13:29:10 -0700
Message-ID: <7vehof8kx5.fsf@alter.siamese.dyndns.org>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
 <1342020841-24368-3-git-send-email-marcnarc@xiplink.com>
 <7vr4siduq3.fsf@alter.siamese.dyndns.org> <4FFDE4EB.3060100@xiplink.com>
 <7v8veqdkfd.fsf@alter.siamese.dyndns.org> <500078E4.3000901@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 22:29:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpmUj-0008Uj-DV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 22:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294Ab2GMU3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 16:29:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38370 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757016Ab2GMU3N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 16:29:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 626C78038;
	Fri, 13 Jul 2012 16:29:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oSF+DnS3r1LBlfJdkIP1FzX85m4=; b=w2jfJ6
	g+nctFx+rlebI7t96h1npwLsrDgBFq+zpVOaylHQW42wJvEoVjSKz7KOAc0VZWwJ
	wn0LjYvEX68XP7HW2juAyY0rBxxu6gKwmRbY36YM1eJJ6c2N00yEQas7pjkbgYSZ
	YkhYW78PNgEUaU5CKls4gztWDqAUtFP7VFbNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uYevPup0kqENkFUBKGsS5UUbsZCAVHVS
	Ox+NJJbMFb/Luv0fWmnyoBgFUuPCNfUIBUt5ml1l/7gMfQZ5jpOLqf0L1kH/h+cl
	yuGPHNBL3a6e0LWJssAJf2P9asF72MQYHn209jMJa3Jwt3RpWJgrt5qjz4/yzulw
	MzfXks/jBDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F8D48033;
	Fri, 13 Jul 2012 16:29:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C077E802D; Fri, 13 Jul 2012
 16:29:11 -0400 (EDT)
In-Reply-To: <500078E4.3000901@xiplink.com> (Marc Branchaud's message of
 "Fri, 13 Jul 2012 15:37:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67E0DAD0-CD29-11E1-A78E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201422>

Marc Branchaud <marcnarc@xiplink.com> writes:

>> Is it even a _side effect_?  Isn't this one of the primary points of
>> the series?  I do not think this patch makes sense if we did not
>> want that change to happen.
>> 
>> Or am I missing something?
>
> No, you're not -- I agree that this change in behaviour makes sense.  I
> simply hadn't anticipated this effect when I first did the work.
>
> So should the commit message simply say "This changes the default behavior of
> 'git push' ..."?  Or are you suggesting the message needn't mention it at all?

It is one of the more important behaviour changes we are making on
purpose with this series; it deserves to be described in the log, I
would think.
