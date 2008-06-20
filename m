From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Build in merge
Date: Thu, 19 Jun 2008 20:04:14 -0700
Message-ID: <7v4p7oq029.fsf@gitster.siamese.dyndns.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 20 05:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Wwg-00017J-Ld
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 05:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbYFTDEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 23:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbYFTDEg
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 23:04:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbYFTDEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 23:04:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 314651DC30;
	Thu, 19 Jun 2008 23:04:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 794D71DC2F; Thu, 19 Jun 2008 23:04:18 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 988442B8-3E75-11DD-9AAD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85592>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Changes since the previous series I sent out to the list:
>
> - get_octopus_merge_bases() now always does a cleanup
>
> - added a new test to make sure git-merge handles more than 25 refs
>
> As usual, comments are welcome. :-)

Thanks.

I take that last line of comment to mean "this is still RFC and not for
inclusion yet" ;-) I think the series is fine up to eighth patch (get
octopus merge base).

I'll queue the whole thing (still strictly as "test merge" basis) to 'pu';
I've fixed 3 "old-style C function definition" issues you have in the
tenth patch (build in merge), and I have some other issues with the ninth
one (filter independent).
