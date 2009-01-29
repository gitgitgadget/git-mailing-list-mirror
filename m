From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH/RFC v1 5/6] combine-diff.c: remove a call to fstat() inside
 show_patch_diff()
Date: Thu, 29 Jan 2009 09:20:49 +0100
Organization: private
Message-ID: <86y6wuh6am.fsf@broadpark.no>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
 <1233004637-15112-6-git-send-email-barvik@broadpark.no>
 <7v63jznp58.fsf@gitster.siamese.dyndns.org>
 <7vab9akj2p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 09:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSSAN-0008Bn-2w
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 09:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbZA2IVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 03:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZA2IVB
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 03:21:01 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:33594 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbZA2IVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 03:21:00 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE800FGS4IRB7D0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 29 Jan 2009 09:20:51 +0100 (CET)
Received: from localhost ([80.203.78.10]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE800BE14IQH530@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 29 Jan 2009 09:20:51 +0100 (CET)
In-reply-to: <7vab9akj2p.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107644>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Kjetil Barvik <barvik@broadpark.no> writes:
>>
>>> Currently inside show_patch_diff() we have and fstat() call after an
>>> ok lstat() call.  Since we before the call to fstat() have already
>>> test for the link case with S_ISLNK() the fstat() can be removed.
>>
>> Good eyes.  Thanks.
>
> Heh, I noticed you will update the commit log message, so I'll dequeue
> this and wait for an update.

  Yes, I am planing a v2 in 1 or 3 days (it takes some time to run long-
  running tests).  And then hopefully I have addressed all comments so
  far.  Thanks for comments!

  -- kjetil
