X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: "cg-init arg" silently ignores its argument
Date: Thu, 02 Nov 2006 14:38:56 +0100
Message-ID: <vpqslh2m0i7.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 13:39:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 02 Nov 2006 14:38:57 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30748>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfcn9-0004Li-TL for gcvg-git@gmane.org; Thu, 02 Nov
 2006 14:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752320AbWKBNjc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 08:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbWKBNjb
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 08:39:31 -0500
Received: from imag.imag.fr ([129.88.30.1]:32643 "EHLO imag.imag.fr") by
 vger.kernel.org with ESMTP id S1752320AbWKBNjb (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 08:39:31 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52]) by
 imag.imag.fr (8.13.6/8.13.6) with ESMTP id kA2DcudO024507
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Thu, 2 Nov 2006 14:38:57 +0100 (CET)
Received: from ecrins.imag.fr ([129.88.43.124]) by mail-veri.imag.fr with
 esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GfcmW-0002Am-Lb for
 git@vger.kernel.org; Thu, 02 Nov 2006 14:38:56 +0100
Received: from moy by ecrins.imag.fr with local (Exim 4.50) id
 1GfcmW-0005Bn-IA for git@vger.kernel.org; Thu, 02 Nov 2006 14:38:56 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

It seems that

$ cg-init foo

does the same as

$ cg-init

At best, I'd expect it to do something like

$ mkdir -p foo; cd foo; cg-init

(probably it should disable autocommiting then). That's what bzr does,
and I find it handy to try something on a temporary toy repository.

and at least, if it doesn't, it should complain about invalid
argument.

Thanks,

-- 
