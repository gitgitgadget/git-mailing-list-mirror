From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Sun, 03 Aug 2008 14:21:20 -0700
Message-ID: <7v3allu75b.fsf@gitster.siamese.dyndns.org>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de>
 <1217793328.48960d306d2b7@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	=?utf-8?Q?B?= =?utf-8?Q?j=C3=B6rn?= Steinbrink 
	<B.Steinbrink@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 03 23:23:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPl3P-0003Fs-1d
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 23:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbYHCVVa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2008 17:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756512AbYHCVVa
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 17:21:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbYHCVV3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Aug 2008 17:21:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 652B448DA5;
	Sun,  3 Aug 2008 17:21:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C40BD48DA4; Sun,  3 Aug 2008 17:21:22 -0400 (EDT)
In-Reply-To: <1217793328.48960d306d2b7@webmail.nextra.at> (Johannes Sixt's
 message of "Sun, 3 Aug 2008 21:55:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22003548-61A2-11DD-92CA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91273>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Zitat von Steffen Prohaska <prohaska@zib.de>:
> ...
>> The modified define works.
>>
>> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
>
> Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
>
> I was not aware that my version (block-scoped static function forward
> declaration) is not valid C. Thanks, Bj=C3=B6rn, for pointing out the=
 gcc bugzilla
> entries.

Thanks all.  Applied.
