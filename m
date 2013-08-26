From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/5] replace: forbid replacing an object with one of a
 different type
Date: Mon, 26 Aug 2013 09:19:37 +0200 (CEST)
Message-ID: <20130826.091937.1157849584660055093.chriscool@tuxfamily.org>
References: <521A4E83.9000400@kdbg.org>
	<20130825.214417.1308749312477487067.chriscool@tuxfamily.org>
	<521A6684.7090103@kdbg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, philipoakley@iee.org,
	trast@inf.ethz.ch
To: j6t@kdbg.org
X-From: git-owner@vger.kernel.org Mon Aug 26 09:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDr5r-00013Q-Js
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 09:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362Ab3HZHUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 03:20:01 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:47081 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756028Ab3HZHUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 03:20:00 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 4593496;
	Mon, 26 Aug 2013 09:19:38 +0200 (CEST)
In-Reply-To: <521A6684.7090103@kdbg.org>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232982>

From: Johannes Sixt <j6t@kdbg.org>

> Am 25.08.2013 21:44, schrieb Christian Couder:
>> What about:
>> 
>>      		die("Objects must be of the same type.\n"
>> 		    "'%s' points to a replaced object of type '%s'\n"
>> 		    "while '%s' points to a replacement object of type '%s'.",
> 
> Much better!

Ok, I will reroll with this change and the change you suggest in the test.

Thanks,
Christian.
