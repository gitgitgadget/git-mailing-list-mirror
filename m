From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unpack-trees: fix D/F conflict bugs in verify_absent
Date: Thu, 01 Jan 2009 13:28:22 -0800
Message-ID: <7vfxk2hg21.fsf@gitster.siamese.dyndns.org>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Jan 01 22:29:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIV72-0004JT-Pp
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 22:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbZAAV2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 16:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752164AbZAAV2c
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 16:28:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbZAAV2b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 16:28:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CB8371B8BB;
	Thu,  1 Jan 2009 16:28:29 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E11191B8D9; Thu, 
 1 Jan 2009 16:28:24 -0500 (EST)
In-Reply-To: <1230843273-11056-1-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Thu, 1 Jan 2009 21:54:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 22289AFE-D84B-11DD-8918-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104330>

Clemens Buchacher <drizzd@aon.at> writes:

> I came across a few bugs while investigating the changes I proposed in the
> modify/delete conflict thread. The first two are quite obvious. The third I'm
> not so sure about. I could not find a testcase where it matters. Junio, do you
> recall the original intention of that code?

Thanks, but I see only [PATCH 1/3] and [PATCH 2/3] (both of which look
sane, by the way).
