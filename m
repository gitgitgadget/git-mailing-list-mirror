From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow passing of --directory to git-am.
Date: Thu, 04 Dec 2008 14:33:26 -0800
Message-ID: <7v7i6fd0zt.fsf@gitster.siamese.dyndns.org>
References: <49382612.3010207@fs.ei.tum.de>
 <7vhc5jeo60.fsf@gitster.siamese.dyndns.org> <49385908.5020202@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 23:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8MmX-0002FP-Ie
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 23:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbYLDWdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 17:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbYLDWdc
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 17:33:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbYLDWdb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 17:33:31 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 583DA181E2;
	Thu,  4 Dec 2008 17:33:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 46B70181CA; Thu, 
 4 Dec 2008 17:33:27 -0500 (EST)
In-Reply-To: <49385908.5020202@fs.ei.tum.de> (Simon Schubert's message of
 "Thu, 04 Dec 2008 23:26:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94155174-C253-11DD-8A06-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102373>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> writes:

> You mean not storing/restoring the flags across an invocation?  No,
> that's a different thing.  My patch only adds the --directory option,
> it does not fix the previously existing bug.

The question is if it _introduces_ a bug that the directory given in the
initial invocation of "git am --directory=foo" is lost if an patch does
not apply and you need to manually resolve and continue.

If it does not introduce such a bug, you do not have the same issue as the
old patch.  Otherwise you have the same issue as the old patch.  The
question was if you have the same issue or you don't.  Yes?  No?
