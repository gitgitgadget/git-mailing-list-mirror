From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Tue, 02 Jun 2009 08:50:57 -0700
Message-ID: <7v7hzufxcu.fsf@alter.siamese.dyndns.org>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de>
	<7v7i0scvcf.fsf@alter.siamese.dyndns.org>
	<op.utlq3vgx1e62zd@merlin.emma.line.org>
	<7vprek0ywq.fsf@alter.siamese.dyndns.org> <op.utlylkb61e62zd@balu>
	<7vskje6wsy.fsf@alter.siamese.dyndns.org> <op.utva2vxh1e62zd@balu>
	<7vy6t03ik0.fsf@alter.siamese.dyndns.org>
	<20090602195533.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	"Matthias Andree" <matthias.andree@gmx.de>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:51:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBWGe-0002NU-0G
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 17:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbZFBPvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 11:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755115AbZFBPu7
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 11:50:59 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51981 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbZFBPuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 11:50:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090602155058.ZCFC2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 2 Jun 2009 11:50:58 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id z3qx1b0034aMwMQ043qxV8; Tue, 02 Jun 2009 11:50:57 -0400
X-Authority-Analysis: v=1.0 c=1 a=Sb75fb6s3KMA:10 a=5qu_ZHnkUusA:10
 a=UQnXkbzPAAAA:8 a=ybZZDoGAAAAA:8 a=7hIf9uYYAAAA:8 a=oUcuN1OXTfh552oj9n8A:9
 a=KDwplxJmBZmZPEVtpQcA:7 a=i6L2XpaP7hsGbH0HuZ13MnInzjoA:4 a=Q21-j9j7q-gA:10
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120523>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> I actually like the rationale you mentioned in the thread (perhaps in the
>> original proposed commit message as well) that we should ask the freshly
>> built git to describe the version if available, falling back to whichever
>> git of random vintage found on the original $PATH.
>>
>> If it weren't for $X [*1*], my preference would have been (as I said in
>> the discussion) to run ./git if available locally.
>>
>> But I think your "deal with details like $X to figure out the name of the
>> freshly built git binary is in the Makefile, and pass it via GIT variable
>> to GIT-VERSION-GEN" is a sensible approach.  I do not remember if your
>> patch gave precedence to an installed git on the original $PATH or a
>> freshly built one, though---the precedent probably does not matter in
>> practice, and favoring the one found on $PATH over freshly built one does
>> have an advantage if we were to support cross compilation (I have a
>> suspicion that the current setup does not).
>>
>> Thanks.
>
> Junio, I think you forgot to take a follow-up action on this thread after sending this message.  The patch favors the git program in the current directory.

Indeed, I did, and I think I am Ok with the patch.  Thanks for a
reminder.

I thought there was an "simplicity" issue raised by J6t that was not
addressed, but after re-reading the thread I do not think it applies
(J6t?)

> Do you want to ask Matthias to resend the patch with an updated log message?

The proposed commit log message indeed does look somewhat incompatible
with the normal style of our log messages, but I think I can rewrite it.

> P.S. a happy birthday ;-)

Heh, depending on where you are, you are a day or so late, but thanks
anyway.

> -- 
> Nanako Shiraishi
> http://ivory.ap.teacup.com/nanako3/
