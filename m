From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Mon, 05 Apr 2010 23:09:01 -0700
Message-ID: <7v1vetkt8i.fsf@alter.siamese.dyndns.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
 <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <m2md411cc4a1004052157v200f902ek22420456e4a45512@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 08:09:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz1yQ-0003hO-EI
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 08:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266Ab0DFGJO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 02:09:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259Ab0DFGJM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 02:09:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65E9EA7F33;
	Tue,  6 Apr 2010 02:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WjHKt8Vj7Zm1
	D7Yta5u1tCBTh3w=; b=c0pvrthhA8IoxbvPd2wrHGk4xZjIts9Luc705OOAhlY6
	Hn+HYzTfQWso5esz1ESrSQnu7al7BqbYTgBSbANa6O7MhtWWHbECvH2dRCp9NuaV
	ovg08q7vagwtm84umRMoWjtYKvmFgzXuJj+0DKVQYGc+k+cWSJecHhtYkTHxI3I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=a+I6Vu
	Eyg5Zvw9BmKvGhFBof2iSYzFgZkq3FuHdGVMhmbEb3C2nU/dyBRLXXvXPLpb0fPh
	sK48LxApkMgCY9g0+lIL5MPo6xjr6/PjmNW4tiR69MBT2cpRTBiss2KNAJjsZ/YW
	lEqg9sGUlisULxXQ8CJMZHm3FZKxeMfxqX3KE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22D7DA7F31;
	Tue,  6 Apr 2010 02:09:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EB8DA7F2E; Tue,  6 Apr
 2010 02:09:03 -0400 (EDT)
In-Reply-To: <m2md411cc4a1004052157v200f902ek22420456e4a45512@mail.gmail.com>
 (Scott Chacon's message of "Mon\, 5 Apr 2010 21\:57\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E94D24AE-4142-11DF-9637-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144104>

Scott Chacon <schacon@gmail.com> writes:

> On Thu, Oct 8, 2009 at 10:22 PM, Shawn O. Pearce <spearce@spearce.org=
> wrote:
>> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
>> ---
>> =C2=A0Documentation/technical/http-protocol.txt | =C2=A0542 ++++++++=
+++++++++++++++++++++
>> =C2=A01 files changed, 542 insertions(+), 0 deletions(-)
>> =C2=A0create mode 100644 Documentation/technical/http-protocol.txt
>
> I just spent a while looking for this in my email archive - why was
> this document not added to the technical/ dir?  Can we put it there?

Perhaps because it was marked as RFC and not much discussion went on?
Sorry, but I cannot keep mental bandwidth to remember the threads from =
6
months ago while doing this as a part-time non-job ;-)

I wonder what other three patches were about, at the same time...
