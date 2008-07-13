From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 FIXED] help (Windows): Display HTML in default
 browser using Windows' shell API
Date: Sun, 13 Jul 2008 01:58:23 -0700
Message-ID: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org>
References: <228FC26D-D318-487A-9BF3-B473096CB0C9@zib.de>
 <1215761822-21356-1-git-send-email-prohaska@zib.de>
 <7vtzevhjf8.fsf@gitster.siamese.dyndns.org>
 <8D150442-8B57-4025-9110-BC4C23C2310C@zib.de>
 <7vskufy40c.fsf@gitster.siamese.dyndns.org>
 <1215895277.487916ed43464@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Jul 13 10:59:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHxQd-0001ZV-Tq
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 10:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbYGMI6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 04:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752573AbYGMI6g
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 04:58:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYGMI6f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 04:58:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D840C2933A;
	Sun, 13 Jul 2008 04:58:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0FDB629339; Sun, 13 Jul 2008 04:58:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF6D5A9C-50B9-11DD-AE5F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88292>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Zitat von Junio C Hamano <gitster@pobox.com>:
>
>> Steffen Prohaska <prohaska@zib.de> writes:
>>
>> >> Do you mean to have that printf() or is it a leftover debugging
>> >> statement?
>> >
>> > I mean to have it.
>>
>> Ok, I was just checking.  Unless other Windows users complain, will apply
>> as-is.  As you might guess, I am completely neutral on this one.
>
> I'm working on followups to this series, and it turns out to be more
> convenient to have system_path() in exec_cmd.c instead of path.c.
> It'll make sense if I resend the series with an updated version of 1/3
> (instead of a patch that merely moves the function around).

Ok, will drop these three patches and wait for replacement from yours to
appear, and then we will see which ones to apply.
