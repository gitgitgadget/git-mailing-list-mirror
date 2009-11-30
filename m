From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Sun, 29 Nov 2009 23:47:31 -0800
Message-ID: <7vtywcwj1o.fsf@alter.siamese.dyndns.org>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
 <7vhbsfi4bz.fsf@alter.siamese.dyndns.org>
 <36ca99e90911280408v186777f1h22254744fb61bf1f@mail.gmail.com>
 <36ca99e90911292307w769913fdn1f610eeb065b41e@mail.gmail.com>
 <7v4ooczdoe.fsf@alter.siamese.dyndns.org>
 <36ca99e90911292341o524840ebo47d79f06b1588d5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:47:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0z6-0006De-Qk
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbZK3Hrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753727AbZK3Hrh
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:47:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbZK3Hrg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:47:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A8B6A26A4;
	Mon, 30 Nov 2009 02:47:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ytJShit2ahwIG5/ntEAWj0sqZYQ=; b=Ojk/b6
	u5m9uXLJtcNRhG1wcdEqJJSqXP+uEn75qebaKtYkTXS0dDpqPXWv1ycuuuYp8XGY
	s9cHw8mm4NIRZHX8rRo1UtqP3KglRBIhQzsKpOX5bkAUjoT58vUC5MB4epFiPgxC
	a49BIoEMa+N4/uVbt5gsGP7z1mxT1aqSgcjpI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m1egsIYW8OEyBerdi26oEHzBb+o7rBPJ
	bjWxeO8YU4uoiRHS6nTmZf3CEzO2uQx2akNvteCz8tkaPay7FJd7IYq+pNynxje+
	IuToLIMEbuLUOTHgJwtqnoiSNyGQhimtOY4sdydAUqfOUlG+Ej+fXx3YGMjB3PHk
	b8OPt9Sl4Pg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E5029A26A3;
	Mon, 30 Nov 2009 02:47:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4ED6AA26A1; Mon, 30 Nov 2009
 02:47:32 -0500 (EST)
In-Reply-To: <36ca99e90911292341o524840ebo47d79f06b1588d5c@mail.gmail.com>
 (Bert Wesarg's message of "Mon\, 30 Nov 2009 08\:41\:49 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A1DD13DA-DD84-11DE-818F-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134070>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

> On Mon, Nov 30, 2009 at 08:15, Junio C Hamano <gitster@pobox.com> wrote:
>> Sorry, but I think the fix is already in 'next', no?
> Yes it is, should have fetched first. sorry.

Don't be sorry; thanks for catching it.

The current 'next' branch has the original commit with a botched rewrite
by mine, and also a fixed commit, so unfortunately shortlog would list the
patch twice.  I'll merge the updated (i.e. rewound and then rebuilt) tip
of the topic branch when the topic graduates to the master (hopefully
before 1.6.6-rc1), so we won't see the botched one in the end result.
