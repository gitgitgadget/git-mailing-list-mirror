From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 08/10] t6050: add tests for listing with --format
Date: Mon, 09 Dec 2013 06:58:31 +0100 (CET)
Message-ID: <20131209.065831.1058089388384173102.chriscool@tuxfamily.org>
References: <20131207160514.21478.72966.chriscool@tuxfamily.org>
	<20131207162106.21478.8850.chriscool@tuxfamily.org>
	<CAPig+cTcacoNGstYeYRd3_WKAP6=ga7gV4puSsr7c2sO_OMNTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	joey@kitenet.net
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Dec 09 06:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vptrx-0007gh-Kg
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 06:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693Ab3LIF65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 00:58:57 -0500
Received: from [194.158.98.45] ([194.158.98.45]:45579 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754080Ab3LIF64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 00:58:56 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 6BB7C40;
	Mon,  9 Dec 2013 06:58:32 +0100 (CET)
In-Reply-To: <CAPig+cTcacoNGstYeYRd3_WKAP6=ga7gV4puSsr7c2sO_OMNTQ@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239060>

From: Eric Sunshine <sunshine@sunshineco.com>
>
> On Sat, Dec 7, 2013 at 11:21 AM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>> This patch adds tests for "git replace -l --format=<fmt>".
>> Only tests when <fmt> is 'medium' and 'full' are needed
>> because 'short' is the same as with no --format option.
> 
> Nevertheless, don't you want to test that it behaves in the expected
> manner when given --format=short and other legal or illegal
> combinations?
> 
>   --format
>   --format short
>   --format bogus
>   ...etc...

Ok, I will add more tests.

Thanks,
Christian.
