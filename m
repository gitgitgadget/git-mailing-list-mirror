From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bisect feature suggestion: "git-bisect diff"
Date: Fri, 07 Dec 2007 11:28:52 -0800
Message-ID: <7vmysm1eyz.fsf@gitster.siamese.dyndns.org>
References: <20071207093439.GA21896@elte.hu>
	<7v63za4yic.fsf@gitster.siamese.dyndns.org>
	<7vwsrq3iox.fsf@gitster.siamese.dyndns.org>
	<20071207112159.GA11035@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Dec 07 20:36:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0izf-00066x-1l
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 20:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbXLGTfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 14:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbXLGTfu
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 14:35:50 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:33875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbXLGTft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 14:35:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BEEF1A74;
	Fri,  7 Dec 2007 14:29:09 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D73821A73;
	Fri,  7 Dec 2007 14:29:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67445>

Ingo Molnar <mingo@elte.hu> writes:

> ... One small detail though: i frequently ssh to testboxes that have 
> DISPLAY set but i want text output. So git-bisect view --text should be 
> a special-case perhaps?

Yeah, but at that point, wouldn't "git bisect view log" be shorter to
type?
