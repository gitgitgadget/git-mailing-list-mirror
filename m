From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change octal literals to be XEmacs friendly
Date: Fri, 23 Jan 2009 12:13:26 -0800
Message-ID: <7vvds5u6ft.fsf@gitster.siamese.dyndns.org>
References: <871vuwbnio.fsf@linmac.oyster.ru>
 <7vbpty1m1r.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0901232158290.2186@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: malc <av1474@comtv.ru>
X-From: git-owner@vger.kernel.org Fri Jan 23 21:15:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQSQd-0001kC-IT
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 21:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbZAWUNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 15:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbZAWUNe
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 15:13:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZAWUNd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 15:13:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9AF3C1D218;
	Fri, 23 Jan 2009 15:13:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B4BBE1D1F4; Fri,
 23 Jan 2009 15:13:27 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0901232158290.2186@linmac.oyster.ru>
 (av1474@comtv.ru's message of "Fri, 23 Jan 2009 22:53:31 +0300 (MSK)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4E1C43FE-E98A-11DD-8283-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106910>

malc <av1474@comtv.ru> writes:

> On Fri, 23 Jan 2009, Junio C Hamano wrote:
>
>> malc@pulsesoft.com writes:
>>
>>> case uses eql and (eql ?\001 1) evaluates to nil under XEmacs
>>> (probably because some internal type of ?\001 is char)
>>
>> And I presume the new way to spell is compatible with non XEmacs emacs?
>> It may be obvious to you, but please spell it out.  Parenthesized
>> "probably" does not help building the confidence in the patch either.
>
> Fair enough.
>
> XEmacs:
> (type-of ?\1) yields character
>
> FSF Emacs:
> (type-of ?\1) yields integer

No use explaining that to me _here_.  Please use that knowledge to write a
better description in an updated commit log message when sending your v2
patch.

>>> Signed-off-by: Vassili Karpov <av1474@comtv.ru>
>>
>> How are the (nameless) author of the patch malc@pulsesoft.com and Vassili
>> Karpov, the person who signed off, related?
>
> Both are my e-mail address used in ~/.gitconfig and ~/.emacs (and used
> by GNUS which was used to post the message via gmane's nntp interface)
> respectively.

Assuming that you would want to be known as Vassili, please have that name
on From: line of the message -- the patch acceptance tool takes the author
name from there.

If you can't for whatever reason use the name on From: line of the e-mail
message, you can begin the body of the message with

	From: Vassili Karpov <av1474@comtv.ru>

(without indentation) and a blank line.  This trick can also be used when
you are forwarding a patch somebody else wrote.
