From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] graph API: always print 'M' for merge commits
Date: Sat, 24 May 2008 18:28:08 -0700
Message-ID: <7vabifkw9j.fsf@gitster.siamese.dyndns.org>
References: <20080524182530.GB2997@mithlond.arda.local>
 <1211662321-28846-1-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sun May 25 03:29:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K052t-0008C7-1l
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 03:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbYEYB2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 21:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbYEYB2T
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 21:28:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbYEYB2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 21:28:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CDB92F7C;
	Sat, 24 May 2008 21:28:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 973C22F79; Sat, 24 May 2008 21:28:11 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D976CDEE-29F9-11DD-8A0E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82845>

Adam Simpkins <adam@adamsimpkins.net> writes:

> On Sat, May 24, 2008 at 09:25:30PM +0300, Teemu Likonen wrote:
>> 
>> I'd rather show merge commits always with M. They are still conceptually
>> merges even if the current log view shows only one parent. This patch
>> changes symbols * and M to be visual symbols, not logical symbols which
>> I'd prefer.
>> 
>> For example user may be interested in finding certain merge but chooses
>> to limit the output with a commit range. It helps if user can always
>> trust the symbols * and M to have this conceptual difference.
>
> Okay.  Here's a simple patch to restore the behavior of always printing
> 'M' for merge commits, even if less than 2 parents are shown in the
> graph.

I have to wonder if that is really necessary.  A merge commit, unless you
amend it, always starts with "Merge ...", and I think it is enough clue of
what the particular commit did.  Besides, I think letter "M" in the
pictorial part of the graph simply looks rather ugly.

I would even suggest not to use 'M' at all, whether its parents are
interesting or not.
