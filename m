From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 03/11] t6050-replace: test that objects are of the
 same type
Date: Thu, 05 Sep 2013 21:13:49 +0200 (CEST)
Message-ID: <20130905.211349.627536889681040925.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
	<20130903071026.29838.76131.chriscool@tuxfamily.org>
	<xmqqa9jsmich.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, philipoakley@iee.org, trast@inf.ethz.ch,
	j6t@kdbg.org, sunshine@sunshineco.com, jrnieder@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 05 21:13:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHf0B-0003oO-34
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 21:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960Ab3IETNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 15:13:55 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:36263 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756948Ab3IETNy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 15:13:54 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 4C54BDF;
	Thu,  5 Sep 2013 21:13:50 +0200 (CEST)
In-Reply-To: <xmqqa9jsmich.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233984>

From: Junio C Hamano <gitster@pobox.com>
>
> Christian Couder <chriscool@tuxfamily.org> writes:
>>  
>> +test_expect_success 'replaced and replacement objects must be of the same type' '
>> +	test_must_fail git replace mytag $HASH1 2>err &&
>> +	grep "mytag. points to a replaced object of type .tag" err &&
>> +	grep "$HASH1. points to a replacement object of type .commit" err &&
> 
> Hmm, would these messages ever get translated?  I think it is
> sufficient to make sure that the proposed replacement fails for
> these cases.

Ok, I will get rid of the grep statements.

Thanks,
Christian.
