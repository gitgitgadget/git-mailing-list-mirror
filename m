From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Fix random sha1 in error message in http-fetch and http-push
Date: Fri, 14 Dec 2007 14:17:53 -0800
Message-ID: <7vbq8sq5ta.fsf@gitster.siamese.dyndns.org>
References: <1197667081-9909-1-git-send-email-mh@glandium.org>
	<1197667081-9909-2-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 23:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3IrX-0007C4-8K
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 23:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933753AbXLNWSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 17:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932941AbXLNWSL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 17:18:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757711AbXLNWSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 17:18:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D8FE07705;
	Fri, 14 Dec 2007 17:18:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F9CC7704;
	Fri, 14 Dec 2007 17:18:01 -0500 (EST)
In-Reply-To: <1197667081-9909-2-git-send-email-mh@glandium.org> (Mike Hommey's
	message of "Fri, 14 Dec 2007 22:18:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68354>

Mike Hommey <mh@glandium.org> writes:

> Please note that this is already fixed in my strbuf patch for these files,
> which had been applied in pu, but it seems to have disappeared from pu's
> history. This also means the strbuf patch conflicts with this one. Please
> tell me if you want a new strbuf patch made after this one.

The branch 'pu' almost always rewind and gets rebuilt from the tip of
'next'.  Since I am more worried about master and next, even more so
than usual these days, most of the backburnered topics are not even in
'pu' but I still keep tips of them not to lose (they are found in
'offcuts').

Give me a few days to get back to your series.  I think it is a series
of good clean-up patches, (I just read [1/2] which was trivially correct
although I am not sure if it is the optimum fix to sprinkle free(url) to
everywhere we have return), but I just haven't got around to them.
