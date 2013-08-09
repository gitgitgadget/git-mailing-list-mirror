From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] .mailmap: mark bouncing email addresses
Date: Fri, 09 Aug 2013 16:32:07 -0700
Message-ID: <7vr4e230g8.fsf@alter.siamese.dyndns.org>
References: <1376072305-15255-1-git-send-email-stefanbeller@googlemail.com>
	<1376072305-15255-3-git-send-email-stefanbeller@googlemail.com>
	<20130809200101.GX14690@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 01:32:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7wAJ-0004hT-Ne
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 01:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031583Ab3HIXcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 19:32:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57752 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031469Ab3HIXcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 19:32:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB16137457;
	Fri,  9 Aug 2013 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=guSwvNyLhzUtUer4n0fjaVhP2Ck=; b=c2w6rd
	533FLAYF8g91t9c8+vMijS+c9JgpJiBTzrK+iFpxBwNDLWYOJk/Zw7Ou9FxZjsVY
	Xbd4kVDSwWcmdYNVUTAlx/4tGR1I3+vGX2Jhqj+WRnV5iN9a1YwKL2uxSgtvtYKv
	TfA1VIkn6jM1+x0+4sTrzYoc5nbWfNhegpJWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AgzNIJCu1qjti29QRvhLV2hD+VwHWciw
	zofntOsUbTP6SW3IVVXsbsYTUshinfdGGw6dTronp7Ew4WhWwJkJ4MA2KrkCLsqt
	rsSPVbOjWHbcrZtaaC6kW8dNAzHMS4hPXkxQj7XgBtFEjG1IOBozRNDZi9eWofEw
	O3dBu4tQY/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E056637456;
	Fri,  9 Aug 2013 23:32:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 394953744F;
	Fri,  9 Aug 2013 23:32:09 +0000 (UTC)
In-Reply-To: <20130809200101.GX14690@google.com> (Jonathan Nieder's message of
	"Fri, 9 Aug 2013 13:01:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8E06D24-014B-11E3-98B2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232054>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +# The 2 following authors are probably the same person,
>> +# but both emails bounce.
>>  Nanako Shiraishi <nanako3@bluebottle.com>
>>  Nanako Shiraishi <nanako3@lavabit.com>
>
> I don't know how to contact Nanako these days. :(  Maybe mailmap
> should learn a way to say "there's no current public email address for
> this person".

I don't, either, but these two entries describe the same person.

One option that I didn't give other old-and-now-left-the-project
contributors in my previous message (but I should have) is to let
them say: I left the project, you can use my existing contributions,
but I prefer you not to list my current address in your address
book.

The reason I didn't but I think I should have is because mailmap is
not meant to record the current address to be used to contact the
person.  Its primary purpose is to make sure we group contributions
by the same person under a single name.  So in that sense, it is OK
if they choose to give us the address they used the last time they
contributed, even that address no longer works.

I'd suggest using the lavabit address unless we hear the preferred
address from her, as the lavabit address was used in 5bf46841
(git-gui: update Japanese translation, 2010-02-02), while the last
use of the bluebottle address was in 6762079a (Cloning from a repo
without "current branch", 2007-06-16).
