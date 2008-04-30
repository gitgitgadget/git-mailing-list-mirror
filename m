From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Make read_in_full() and write_in_full() consistent with
 xread() and xwrite()
Date: Wed, 30 Apr 2008 02:23:39 -0700
Message-ID: <7vlk2v1ysk.fsf@gitster.siamese.dyndns.org>
References: <20080427182158.GA29232@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heikki Orsila <heikki.orsila@iki.fi>
X-From: git-owner@vger.kernel.org Wed Apr 30 11:24:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr8YN-0005Zs-0q
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 11:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271AbYD3JXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 05:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757241AbYD3JXz
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 05:23:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbYD3JXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 05:23:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A90A3991;
	Wed, 30 Apr 2008 05:23:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id F162F3990; Wed, 30 Apr 2008 05:23:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26A049C2-1697-11DD-BE61-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80817>

Heikki Orsila <heikki.orsila@iki.fi> writes:

> Requesting comments on the following patch.
>
> xread() and xwrite() return ssize_t values as their native POSIX
> counterparts. To be consistent, read_in_full() and write_in_full()
> should also return ssize_t values.

I guess this change would not hurt.
