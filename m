From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Add basic test-script for git-submodule
Date: Fri, 01 Jun 2007 09:56:12 +0200
Organization: eudaptics software gmbh
Message-ID: <465FD11C.6B1D5172@eudaptics.com>
References: <11802980992216-git-send-email-hjemli@gmail.com> <7v7iqs6r6p.fsf@assigned-by-dhcp.cox.net> <8c5c35580705292348q74281f7eu15b3b61f45b2c6f5@mail.gmail.com> <7vzm3kz5w9.fsf@assigned-by-dhcp.cox.net> <op.ts8d71b89pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 09:55:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu1yy-0001AQ-Gh
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 09:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbXFAHz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 03:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752856AbXFAHz1
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 03:55:27 -0400
Received: from main.gmane.org ([80.91.229.2]:53058 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbXFAHz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 03:55:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hu1ye-0005QF-7S
	for git@vger.kernel.org; Fri, 01 Jun 2007 09:55:16 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 09:55:16 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 09:55:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48850>

Lars Hjemli wrote:
> +test_expect_success 'status should only print one line' '
> +       lines=$(git-submodule status | wc -l)

&& is missing.

> +       test "$lines" = "1"

Please don't put output of wc in quotes because some versions of wc emit
padding:

	test $lines = 1

(without the quotes around 1 - like in other test scripts).

-- Hannes
