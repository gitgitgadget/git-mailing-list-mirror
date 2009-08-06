From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] rebase: consistent error messages for staged and unstaged changes.
Date: Thu, 06 Aug 2009 11:56:27 +0200
Message-ID: <vpqljlx465w.fsf@bauges.imag.fr>
References: <1249485221-10510-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vws5i9nsy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 11:57:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYzij-0000EM-Bt
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 11:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbZHFJ4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 05:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZHFJ4e
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 05:56:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51990 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbZHFJ4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 05:56:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n769sJ0b007630
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 11:54:19 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MYzhz-0004Jv-G6; Thu, 06 Aug 2009 11:56:27 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MYzhz-0007Yd-Es; Thu, 06 Aug 2009 11:56:27 +0200
In-Reply-To: <7vws5i9nsy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 05 Aug 2009 10\:24\:13 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 06 Aug 2009 11:54:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n769sJ0b007630
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250157260.96197@ik9OZkWGAaRxBcX9gPZyJQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125061>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Previous version expose the output of the plumbing update-index to the
>> user, which novice users have difficulty to understand.
>
> Can't -q(uiet) option of update-index be used for this?

No, since update-index -q doesn't set the exit status properly:

$ git update-index --ignore-submodules    --refresh  > /dev/null; echo $? 
1
$ git update-index --ignore-submodules -q --refresh             ; echo $?  
0

-- 
Matthieu
