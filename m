From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use GIT_CONFIG in t5505-remote
Date: Wed, 27 Feb 2008 00:16:49 -0800
Message-ID: <7vk5kqx18u.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802261713520.19665@iabervon.org>
 <20080226221959.GB6098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 27 09:17:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUHU4-0005xA-JO
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 09:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbYB0IRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 03:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbYB0IRK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 03:17:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbYB0IRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 03:17:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 479C9189A;
	Wed, 27 Feb 2008 03:17:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5CDEF1899; Wed, 27 Feb 2008 03:17:01 -0500 (EST)
In-Reply-To: <20080226221959.GB6098@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 26 Feb 2008 17:19:59 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75211>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 26, 2008 at 05:15:31PM -0500, Daniel Barkalow wrote:
>
>> For some reason, t5505-remote was setting GIT_CONFIG to .git/config
>> and exporting it. The sole effect of this was to cause the tests to
>> fail if "git clone" obeyed it (which it presumably should).
>> 
>> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
>> ---
>> Maybe test-lib used to set GIT_CONFIG to something that would interfere? 
>> Or the default behavior was wrong?
>
> test-lib used to set it to ".git/config" until recently, so this would
> have been a no-op. As to why it was ever in here, I have no idea.

Right.
