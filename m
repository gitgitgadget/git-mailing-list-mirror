From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Mon, 10 Aug 2009 10:56:58 +0200
Message-ID: <vpqbpmo59np.fsf@bauges.imag.fr>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
	<1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
	<87prb6r9d1.fsf@iki.fi> <vpqab2aqqia.fsf@bauges.imag.fr>
	<7vy6pujmsc.fsf@alter.siamese.dyndns.org>
	<vpq63cwdee3.fsf@bauges.imag.fr>
	<7vljls7n4v.fsf@alter.siamese.dyndns.org>
	<vpq8whsawjs.fsf@bauges.imag.fr>
	<7v1vnk3vgc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:00:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQkJ-0001c9-Iy
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 11:00:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbZHJJAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 05:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752341AbZHJJAj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 05:00:39 -0400
Received: from imag.imag.fr ([129.88.30.1]:49500 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181AbZHJJAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 05:00:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n7A8uwpJ019618
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 10 Aug 2009 10:56:58 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MaQgc-0007NI-6X; Mon, 10 Aug 2009 10:56:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MaQgc-0001TN-5C; Mon, 10 Aug 2009 10:56:58 +0200
In-Reply-To: <7v1vnk3vgc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 10 Aug 2009 01\:49\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 10 Aug 2009 10:56:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125423>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> If you read "Integrate them with your changes" and understand that it is
>>> talking about "git pull" or "git pull --rebase", then you do not have to
>>> read the doc.  It should "click".
>>
>> But what's the point is being so vague, while you could just add "(see
>> git pull)"? See what you've just wrote: one should "understand that it
>> is about ...". So, why write Y thinking that the user should
>> understand that it is about X while you could write X directly?
>
> In order to cover both "pull" and "pull --rebase"?

"git pull" also covers both. "pull" is the command, "--rebase" is an
option of it.

-- 
Matthieu
