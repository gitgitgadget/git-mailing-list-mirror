From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for documented features of "git reset".
Date: Fri, 14 Sep 2007 15:10:00 -0700
Message-ID: <7v7imsaog7.fsf@gitster.siamese.dyndns.org>
References: <46E5EAE0.70603@gmail.com>
	<7vr6l5oi4r.fsf@gitster.siamese.dyndns.org>
	<1b46aba20709141501l6f0f7440hd22b2bd6c4838a0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Carlos Rica" <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 00:10:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJMZ-0004f4-77
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392AbXINWKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 18:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755745AbXINWKH
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:10:07 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756244AbXINWKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:10:05 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9CA0613507D;
	Fri, 14 Sep 2007 18:10:23 -0400 (EDT)
In-Reply-To: <1b46aba20709141501l6f0f7440hd22b2bd6c4838a0b@mail.gmail.com>
	(Carlos Rica's message of "Sat, 15 Sep 2007 00:01:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58191>

"Carlos Rica" <jasampler@gmail.com> writes:

> 2007/9/11, Junio C Hamano <gitster@pobox.com>:
>> I also suspect this would not pass on CRLF boxes.
>
> I finally removed the hardcoded object IDs (patch attached,
> to be applied on top of the previous patch).
>
> But I don't know what to fix for making the test to pass
> in CRLF boxes.

The blobs created by the test script would be different on CRLF
boxes, and exact object IDs hardcoded in your test would not
match.  That was the only thing I meant.

But now you bring it up, I guess the expected output may not
match as well.  Hmmm..

Anyway, thanks for the update.
