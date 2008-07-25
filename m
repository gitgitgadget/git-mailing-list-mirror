From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid warning when From: is encoded
Date: Fri, 25 Jul 2008 09:33:56 -0700
Message-ID: <7vhcadudmz.fsf@gitster.siamese.dyndns.org>
References: <1216991208-18782-1-git-send-email-4ux6as402@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Valdemar =?utf-8?Q?M=C3=B8rch?= <4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 18:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQGD-0004A5-6f
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 18:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbYGYQeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 12:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbYGYQeF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 12:34:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273AbYGYQeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jul 2008 12:34:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 91E673BE60;
	Fri, 25 Jul 2008 12:34:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C13133BE5F; Fri, 25 Jul 2008 12:33:59 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7D9282EA-5A67-11DD-8185-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90067>

Peter Valdemar M=C3=B8rch  <4ux6as402@sneakemail.com> writes:

> From: Peter Valdemar M=C3=B8rch <peter@morch.com>
>
> In commit 0706bd19ef9b41e7519df2c73796ef93484272fd $1 is used from a =
regexp
> without using () to set up $1. Later, when that value was used, it ca=
used a
> warning about a variable being undefined.
>
> Signed-off-by: Peter Valdemar M=C3=B8rch <peter@morch.com>

Thanks.  The patch is obviously correct; I think you are fixing 8291db6
(git-send-email: add charset header if we add encoded 'From', 2007-11-1=
6),
not 0706bd1 (send-email: specify content-type of --compose body,
2008-03-28).

Will apply to maint and merge upwards.
