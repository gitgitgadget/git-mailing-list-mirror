From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] solaris test results
Date: Thu, 21 Feb 2008 21:29:11 -0800
Message-ID: <7vmyptpniw.fsf@gitster.siamese.dyndns.org>
References: <20080220235944.GA6278@coredump.intra.peff.net>
 <7vk5kz171q.fsf@gitster.siamese.dyndns.org>
 <20080221004146.GA6682@coredump.intra.peff.net>
 <7vr6f5pnmz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 06:30:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSQTy-0004V3-1d
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 06:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYBVF31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 00:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbYBVF31
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 00:29:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYBVF30 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 00:29:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EC37364C;
	Fri, 22 Feb 2008 00:29:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5E1F1364A; Fri, 22 Feb 2008 00:29:19 -0500 (EST)
In-Reply-To: <7vr6f5pnmz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 21 Feb 2008 21:26:44 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74691>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Feb 20, 2008 at 04:34:25PM -0800, Junio C Hamano wrote:
>> ...
>>> It is unfair to call diff without -u "totally broken".  It is
>>> not even in POSIX yet IIRC.
>>
>> Fair enough (and you are right that it is not even POSIX). Is it
>> something we want to work around? We "diff -u" quite a bit in the test
>> suite.
>
> Here is a possible solution.

I have another one that converts "cmp" and "cmp -s" to the same
test_compare_expect, but I do not think it is worth posting
here.

I'll either apply both or discard both.  Haven't decided.
