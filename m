From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff: allow turning on textconv explicitly for
 plumbing
Date: Sun, 07 Dec 2008 20:08:35 -0800
Message-ID: <7vbpvn9um4.fsf@gitster.siamese.dyndns.org>
References: <20081208025700.GB22072@coredump.intra.peff.net>
 <7vfxkz9v8f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 05:10:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9XRc-0008Lt-Dt
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 05:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbYLHEIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 23:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754841AbYLHEIr
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 23:08:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754831AbYLHEIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 23:08:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B09085337;
	Sun,  7 Dec 2008 23:08:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 43AFD85336; Sun,
  7 Dec 2008 23:08:39 -0500 (EST)
In-Reply-To: <7vfxkz9v8f.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 07 Dec 2008 19:55:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E6398B32-C4DD-11DD-9B70-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102527>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I know this is not strictly a bugfix and we are in -rc, but:
>>
>>   1. It is an enhancement to a previously unreleased feature, and
>>      shouldn't affect anything outside of that.
>>
>>   2. It affects the scripting interface to textconv, so I would like to
>>      get it in before textconv is ever released so that it is always the
>>      "right way" to turn text conversion off or on.
>
> I'd agree with #1, especially if you said "doesn't" instead of
> "shouldn't".
>
> But I am not 100% sure if the scripting part is "the right way".

But I'll apply them anyway.
