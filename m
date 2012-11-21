From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Duplicate test numbers in pu.
Date: Wed, 21 Nov 2012 19:14:02 +0000
Message-ID: <50AD27FA.3010006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@adamspiers.org,
	GIT Mailing-list <git@vger.kernel.org>,
	felipe.contreras@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:15:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFlZ-0004oD-HG
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805Ab2KUTPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:15:02 -0500
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:51289 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755800Ab2KUTPB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:15:01 -0500
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 481E86F88CD;
	Wed, 21 Nov 2012 19:15:00 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id C165B6F88CF;	Wed, 21 Nov 2012 19:14:59 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;	Wed, 21 Nov 2012 19:14:58 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210162>


Hi Junio,

I noticed that the pu branch has two tests with number t0007, viz:

    $ cd t
    $ make test-lint-duplicates
    duplicate test numbers: t0007
    make: *** [test-lint-duplicates] Error 1
    $ 

In particular, t/t0007-git-var.sh is added by branch 'jk/send-email-\
sender-prompt', while t/t0007-ignores.sh is added by branch 'as/check-ignore'.

Also:

    $ make test-lint-executable
    non-executable tests: t5801-remote-helpers.sh
    make: *** [test-lint-executable] Error 1
    $

(added in branch 'fc/fast-export-fixes').

HTH

ATB,
Ramsay Jones
