From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simple update to bash completions to prevent unbound
 variable errors.
Date: Mon, 12 Jan 2009 21:37:05 -0800
Message-ID: <7vr637epha.fsf@gitster.siamese.dyndns.org>
References: <496C0003.7040909@tedpavlic.com>
 <7vy6xfew2n.fsf@gitster.siamese.dyndns.org> <496C18D8.9070707@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 06:38:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMbz3-00086X-2t
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 06:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbZAMFhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 00:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbZAMFhN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 00:37:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38512 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbZAMFhN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 00:37:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BECB08F515;
	Tue, 13 Jan 2009 00:37:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CBA7B8F514; Tue,
 13 Jan 2009 00:37:07 -0500 (EST)
In-Reply-To: <496C18D8.9070707@tedpavlic.com> (Ted Pavlic's message of "Mon,
 12 Jan 2009 23:30:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 39F1E86A-E134-11DD-857B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105459>

Ted Pavlic <ted@tedpavlic.com> writes:

>>> +# __gitcomp_1 requires 2 arguments
>>
>> ... and $1 and $2 mean?
>
> No clue. Patches are welcome.

To be absolutely honest, I think people with "set -u" in their interactive
environment are sick.  Bourne shells have been substituting unset
variables to empty string for eons, and this is not _my_ itch to scratch.

It seems to be yours, though, and I was merely trying to help.
