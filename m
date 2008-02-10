From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH TAKE 2] Avoid a useless prefix lookup in strbuf_expand()
Date: Sun, 10 Feb 2008 02:52:58 -0800
Message-ID: <7v4pchgk1h.fsf@gitster.siamese.dyndns.org>
References: <1202568019-20200-1-git-send-email-mcostalba@gmail.com>
	<7vr6fl5yhz.fsf@gitster.siamese.dyndns.org>
	<e5bfff550802092259u4139312cufc4756e9d81f4154@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 11:53:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO9ol-0002u8-9N
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 11:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474AbYBJKxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 05:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756543AbYBJKxO
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 05:53:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756450AbYBJKxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 05:53:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E18561517;
	Sun, 10 Feb 2008 05:53:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 72D371516;
	Sun, 10 Feb 2008 05:53:07 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73335>

"Marco Costalba" <mcostalba@gmail.com> writes:

> On Feb 10, 2008 3:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I do recall pointing out that a rather common "format:%an <%ae>"
>> ends up parsing the same line twice, and mentioned we may want
>> to memoise the first call's result in the format_commit_context
>> structure, but what else did I suggest???
>>
>
> Please read thread: "[PATCH RESEND] Avoid a useless prefix lookup in
> strbuf_expand()"
>
> you will find your suggestions and following answers.

Yeah, I mentioned the comment needing to be adjusted (which you
did in this round), asked a minor question about the code (you
answered in the thread), besides pointing out that a rather
common "format:%an <%ae>" being inefficient (which you brushed
aside, claiming that is a special case).

I've touched-up a few typoes and style glitches and will park
this on 'pu' for now.
