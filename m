From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for URLs to git-apply
Date: Sun, 09 Dec 2007 14:54:58 -0800
Message-ID: <7vhciro4vx.fsf@gitster.siamese.dyndns.org>
References: <1197194672-28568-1-git-send-email-mh@glandium.org>
	<1197194672-28568-2-git-send-email-mh@glandium.org>
	<475C5869.4080900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Dec 09 23:55:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1V3d-0005nI-Kw
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 23:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXLIWzM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 17:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbXLIWzM
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 17:55:12 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:50776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbXLIWzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 17:55:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E66285304;
	Sun,  9 Dec 2007 17:55:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D7CE5302;
	Sun,  9 Dec 2007 17:55:01 -0500 (EST)
In-Reply-To: <475C5869.4080900@op5.se> (Andreas Ericsson's message of "Sun, 09
	Dec 2007 22:04:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67663>

Andreas Ericsson <ae@op5.se> writes:

> Mike Hommey wrote:
>> Instead of doing several "wget -O - url | git-apply -" in a raw, you now
>> can just git-apply url1 url2 ...
>>
>
> I seriously like this idea. Combined with gitweb (or cgit), it could be
> used as a cherry-pick from someone else's repo :)

FWIW, my initial impression is that I seriously dislike this.  It may be
good if the patch were to git-am, but when git-apply rejects an
inapplicable patch, there won't be nothing left for you to recover with
and you need to re-download the patch anyway.

Note that I said my "initial" impression.  I reserve the right to change
my mind, as always ;-)
