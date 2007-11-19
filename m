From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-send-email: show all headers when sending mail
Date: Mon, 19 Nov 2007 00:17:51 -0800
Message-ID: <7voddqodhs.fsf@gitster.siamese.dyndns.org>
References: <7vbq9ywqmq.fsf@gitster.siamese.dyndns.org>
	<1195445695-27262-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Mon Nov 19 09:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu1pf-0002pK-Dd
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 09:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbXKSIR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 03:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbXKSIR5
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 03:17:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:46567 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbXKSIR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 03:17:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C73B42F0;
	Mon, 19 Nov 2007 03:18:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 550CC964C0;
	Mon, 19 Nov 2007 03:18:15 -0500 (EST)
In-Reply-To: <1195445695-27262-1-git-send-email-ddkilzer@kilzer.net> (David
	D. Kilzer's message of "Sun, 18 Nov 2007 20:14:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65414>

Thanks.  Looks nice and obviously correct.

One thing that has been bugging me for a long time now stands
out like a sore thumb much more: empty Cc: is shown.

    $ git-send-email --dry-run --to=junio@my.isp.net 0001-branch-contains.txt
    Who should the emails appear to be from? [Junio C Hamano <gitster@pobox.com>]
    Emails will be sent from: Junio C Hamano <gitster@pobox.com>
    Message-ID to be used as In-Reply-To for the first email?
    0001-branch-contains.txt
    Dry-OK. Log says:
    Date: Mon, 19 Nov 2007 00:10:04 -0800
    Server: my.isp.net
    MAIL FROM:<gitster@pobox.com>
    RCPT TO:<junio@my.isp.net>
    From: Junio C Hamano <gitster@pobox.com>
    Subject: [PATCH] branch --contains=<commit>
    Cc:
    To: junkio@cox.net

    Result: OK
