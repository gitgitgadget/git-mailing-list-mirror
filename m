From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rebase -i: clean error message for --continue after failed
 exec
Date: Thu, 25 Aug 2011 15:04:27 +0200
Message-ID: <4E56485B.10206@kdbg.org>
References: <vpqk4a3rkwb.fsf@bauges.imag.fr>	<1314194508-12067-1-git-send-email-Matthieu.Moy@imag.fr>	<7v62lmps6k.fsf@alter.siamese.dyndns.org>	<7vy5yiod1h.fsf@alter.siamese.dyndns.org> <vpqzkiydl21.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 25 15:04:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwZc0-0001Wc-2V
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 15:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506Ab1HYNEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 09:04:38 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:32866 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750919Ab1HYNEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 09:04:36 -0400
Received: from [77.119.97.212] (77.119.97.212.wireless.dyn.drei.com [77.119.97.212])
	by bsmtp.bon.at (Postfix) with ESMTP id 8A000130052;
	Thu, 25 Aug 2011 15:04:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <vpqzkiydl21.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180076>

Am 25.08.2011 09:09, schrieb Matthieu Moy:
> Junio C Hamano<gitster@pobox.com>  writes:
>> I wonder if doing something like this would be more direct approach to
>> achieve the same thing.
>
> Not the same thing, but both patches could go well together.
>
> Mine covers
>
>    pick deadbeef
>    exec make test
>    # :-( make test failed, I'm going to fix it
>    hack hack hack
>    git add changes
>    # OK, seems fixed.
>    git rebase --continue
>    # -->  rebase tells me I forgot to commit my fixup patch

This is exactly my use-case that discovered the problem and which I would 
like to see fixed, FWIW.

-- Hannes
