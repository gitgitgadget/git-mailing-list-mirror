From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] contrib/hooks/post-receive-email: send individual
 mails to recipients
Date: Wed, 12 Nov 2008 10:01:10 -0800
Message-ID: <7vbpwkq0wp.fsf@gitster.siamese.dyndns.org>
References: <E1L0Iv1-00BwsF-Jh@intern.SerNet.DE>
 <491B0D9B.7080306@viscovery.net> <E1L0JjD-00ByqG-1I@intern.SerNet.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
To: Michael Adam <obnox@samba.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:04:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0K4H-0003qF-VH
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbYKLSCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 13:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbYKLSCb
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 13:02:31 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbYKLSCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 13:02:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 82BFE7C543;
	Wed, 12 Nov 2008 13:02:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 540927C517; Wed,
 12 Nov 2008 13:01:17 -0500 (EST)
In-Reply-To: <E1L0JjD-00ByqG-1I@intern.SerNet.DE> (Michael Adam's message of
 "Wed, 12 Nov 2008 18:42:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12312C62-B0E4-11DD-9A88-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100795>

Michael Adam <obnox@samba.org> writes:

> Johannes Sixt wrote:
>> Michael Adam schrieb:
>> > This changes the behaviour of post-receive-email when a list of recipients
>> > (separated by commas) is specified as hooks.mailinglist. With this modification,
>> > an individual mail is sent out for each recipient entry in the list, instead
>> > of sending a single mail with all the recipients in the "To: " field.
>> 
>> I don't think this is well-behaved:
> ...
> Your concerns are surely valid.
> Maybe it would be useful to make this optional?

What benefit could anybody possibly get by making this optional?

If you do not want to show multiple names on To: header to the mail
recipients, there already is a well-known solution, and it is called
(surprise!) mailing list ;-)
