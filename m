From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/5] trailer: reuse ignore_non_trailer() to ignore
 conflict lines
Date: Mon, 10 Nov 2014 20:05:02 +0100 (CET)
Message-ID: <20141110.200502.1295000903783079007.chriscool@tuxfamily.org>
References: <20141109092313.4864.54933.chriscool@tuxfamily.org>
	<20141109092344.4864.88180.chriscool@tuxfamily.org>
	<xmqqbnof9c9d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, tr@thomasrast.ch,
	mhagger@alum.mit.edu, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com,
	marcnarc@xiplink.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 10 20:05:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnuHQ-00043Q-LC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 20:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbaKJTF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 14:05:29 -0500
Received: from [194.158.98.15] ([194.158.98.15]:46190 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752156AbaKJTF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 14:05:26 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 59AABF7;
	Mon, 10 Nov 2014 20:05:03 +0100 (CET)
In-Reply-To: <xmqqbnof9c9d.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] trailer: reuse ignore_non_trailer() to ignore conflict lines
Date: Mon, 10 Nov 2014 09:49:34 -0800

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> Make sure we look for trailers before any conflict line
>> by reusing the ignore_non_trailer() function.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
> 
> It makes sense to unify the logic to decide where the trailer block
> is, I would think.  I however don't think I helped this change in
> any way, not more than "maintained the codebase as a solid
> foundation to build new features on", but at that point it would
> apply to any other change and not worth mentioning ;-).

Do you want me to resend the series with only the Helped-by removed?
