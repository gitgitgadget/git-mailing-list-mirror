From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/6] Change 'git' to 'Git' whenever the whole system
 is referred to #2
Date: Tue, 22 Jan 2013 20:17:31 -0800
Message-ID: <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
References: <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Wed Jan 23 05:17:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txrme-0002i8-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 05:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab3AWERg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 23:17:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448Ab3AWERf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 23:17:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87AF7B9B7;
	Tue, 22 Jan 2013 23:17:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Y2BnJcWEVyZkbtXjP7Yf1U3aR4=; b=QZoUyt
	YzEj1Q1sdSj3KCgkFPvqOIAfNFk7ShCqFG75ZQ37LrbJAr/ccRbVQhIXdU3BeNN5
	YiHVr/k/vhXvgbeU6WXbkiFC+5mQ7A4g1uKllhZd221EwiS/aR8V/PlNvE6sK4Q0
	xyL3Z6KScDHWA2zMaY+YWrtAS0/2Uyu4nNFsU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ue/ImoTcdIb58e/oYoEFO7qCFnM+M4T6
	W7UA5EJhIu26KxkAAnvVtxQm42VlFRHKCoLvtR9lO5VAEMZoYMlfZ36e5jX+S+w2
	LVtT7VAuT0oC7J/z+/IDWHc65F5QZwrVMyDYlOzX9xfHXhRHOKknXlJ1vvNO75kd
	TfIjLv+xcWs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B180B9B6;
	Tue, 22 Jan 2013 23:17:34 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D944FB9B5; Tue, 22 Jan 2013
 23:17:33 -0500 (EST)
In-Reply-To: <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com> (David
 Aguilar's message of "Tue, 22 Jan 2013 19:44:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CFC2E1DE-6513-11E2-B9B1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214279>

David Aguilar <davvid@gmail.com> writes:

> On Mon, Jan 21, 2013 at 11:19 AM, Thomas Ackermann <th.acker@arcor.de> wrote:
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index b87f744..5a831ad2 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>>  push.default::
>> -       Defines the action git push should take if no refspec is given
>> +       Defines the action Git push should take if no refspec is given
>>         on the command line, no refspec is configured in the remote, and
>>         no refspec is implied by any of the options given on the command
>>         line. Possible values are:
>
> This should probably be "git push" in double quotes.

Yeah, or no quotes, or `git push` even.

I've pushed the result of my nitpicks I sent so far as part of the
'pu' branch, on topic 'ta/doc-no-small-caps'.  Its tip is now at
bfb8e1e (fixup! Change 'git' to 'Git' whenever the whole system is
referred to #4, 2013-01-22).

Thomas, I do not want to see many rounds of entire rerolls of this
series on the list (nobody will look at the whole series multiple
times with fine toothed comb).  I do not think you want to do that
either.  Can you collect remaining fixups like David's message, turn
them into patch form when you have collected enough to be reviewed
in one sitting (say, a patchfile at around 200 lines), and send them
over to the list to apply on top of the tree of that commit?

After a week or so, I'll squash the series into two commits (the
first one turns 'GIT' into 'Git', the second one turns selected
'git' into 'Git'), and merge the result to 'next'.
