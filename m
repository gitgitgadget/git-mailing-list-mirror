From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: GPG capitalization
Date: Mon, 30 May 2016 15:07:21 -0700
Message-ID: <xmqq4m9f8ajq.fsf@gitster.mtv.corp.google.com>
References: <01020154fd9dec3d-61772857-8b92-4505-ac0f-5058d490f7dc-000000@eu-west-1.amazonses.com>
	<xmqqvb1vo25i.fsf@gitster.mtv.corp.google.com>
	<CAKp3HaMvsJ58fvtC+rp13wigw75vVm3F7T2U+Gqnyqke71279Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Nicolson <david.nicolson@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 00:07:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7VLW-0007bv-Us
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 00:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbcE3WH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 18:07:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162102AbcE3WHY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 18:07:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4469220C44;
	Mon, 30 May 2016 18:07:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p9nmo1og6psEw6Rnx2i+pCAkUTA=; b=aCVmPy
	7oITFv32U2vRzrgYUhc/OObTUpUMBHa4hRfcsBhj7mo4TQOfpF8Ux/sGSMXhDz8Q
	9VksxgckdKFIU4Bk+GpPjJpdbPdF359qIlomxf60dEZrjm7q4IE8lmL82ZVCSAEZ
	KmpB7uTd/gaMU5JPiFk4oMZrb5R+Rz2TUsr24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CXbTnabP2OxbLvw3NlbpdaS7vCGhZzDk
	a46GuSJIbUtIFIXfnPb7mvl9ju01vmlFXF11kNBNX4LxaurW+vJIV8GimN3qV4xs
	9Ix2n3T/Knq2p2L1pGOMVqjJYARQ1roBkPsJE95yTEobeMDcuRFLbir6TNlZC7mV
	DhRUMEKZF24=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C48120C43;
	Mon, 30 May 2016 18:07:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE4A220C42;
	Mon, 30 May 2016 18:07:22 -0400 (EDT)
In-Reply-To: <CAKp3HaMvsJ58fvtC+rp13wigw75vVm3F7T2U+Gqnyqke71279Q@mail.gmail.com>
	(David Nicolson's message of "Mon, 30 May 2016 23:43:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E27C9810-26B2-11E6-BB5D-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295936>

David Nicolson <david.nicolson@gmail.com> writes:

>>>  message part may contain a signature that Git itself doesn't
>>> -care about, but that can be verified with gpg.
>>> +care about, but that can be verified with GPG.
>>
>> Isn't this a name of the program, though?  Other two hunks in your
>> patch clearly refer to the concept and not to a particular program,
>> and they are good changes, I think.
>
> This one was not as clear as the other hunks. Git is referred to as
> "Git" in the preceding line, which in itself could be referring to the
> concept or the particular program I guess?

I think the "Git" you see above is clearly the "stupid content
tracker Git", not a particular implementation.  It is more about the
data model of Git than our particular implementation of it.  jgit, a
Java implementation of Git, does not care about the gibberish
in the "--BEGIN PGP..." block the same way we don't care.
