From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 19 Apr 2008 21:08:30 -0700
Message-ID: <7vmynpdv7l.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
 <8c5c35580804190934q3ea27328j76418745b7e7665e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 06:09:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnQs2-0005Aj-HF
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 06:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbYDTEIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 00:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbYDTEIo
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 00:08:44 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55825 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbYDTEIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 00:08:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5274170DA;
	Sun, 20 Apr 2008 00:08:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9E83270D9; Sun, 20 Apr 2008 00:08:38 -0400 (EDT)
In-Reply-To: <8c5c35580804190934q3ea27328j76418745b7e7665e@mail.gmail.com>
 (Lars Hjemli's message of "Sat, 19 Apr 2008 18:34:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79948>

"Lars Hjemli" <hjemli@gmail.com> writes:

> On Sat, Apr 19, 2008 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * lh/branch-merged (Fri Apr 18 18:30:15 2008 +0200) 3 commits
>>   - Add tests for `branch --[no-]merged`
>>   - git-branch.txt: compare --contains, --merged and --no-merged
>>   - git-branch: add support for --merged and --no-merged
>
> I notice that you moved the test script into t3201 while still adding
> t3202, which probably wasn't your intent.
>
> Would you like me to resend the patches with your fixups to tests and
> docs (and maybe even squash them into a single patch)?

Thanks, but it's easy enough for me to amend the tip of lh/branch-merged
to drop t3202 and that should be sufficient.
