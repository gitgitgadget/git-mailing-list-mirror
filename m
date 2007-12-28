From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reflog weirdness
Date: Fri, 28 Dec 2007 14:01:55 -0800
Message-ID: <7vtzm2cwbw.fsf@gitster.siamese.dyndns.org>
References: <87ve6iegny.fsf@ambire.localdomain>
	<7vhci2ectr.fsf@gitster.siamese.dyndns.org>
	<87prwqec4a.fsf@ambire.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thien-Thi Nguyen <ttn@gnuvola.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 23:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8NHj-0005WB-Oi
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 23:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXL1WCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 17:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbXL1WCG
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 17:02:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbXL1WCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 17:02:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F178023A8;
	Fri, 28 Dec 2007 17:02:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 927A223A6;
	Fri, 28 Dec 2007 17:01:58 -0500 (EST)
In-Reply-To: <87prwqec4a.fsf@ambire.localdomain> (Thien-Thi Nguyen's message
	of "Fri, 28 Dec 2007 22:35:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69299>

Thien-Thi Nguyen <ttn@gnuvola.org> writes:

> i see that the body of the log message (three bytes)
> corresponds to the first three bytes of the associated
> line in .git/logs/HEAD.

Thanks.

Was it a buggy "git commit" command, or a bad commit log message
was fed to "git commit" by the user, and there is nothing for me
to worry about?
