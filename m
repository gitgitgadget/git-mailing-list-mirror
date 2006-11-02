X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: git and "dumb protocols"
Date: Thu, 02 Nov 2006 11:36:07 +0100
Message-ID: <vpqu01i16g8.fsf@ecrins.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 10:37:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 02 Nov 2006 11:36:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30706>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfZwb-0004am-TN for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161311AbWKBKhG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbWKBKhF
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:37:05 -0500
Received: from imag.imag.fr ([129.88.30.1]:54971 "EHLO imag.imag.fr") by
 vger.kernel.org with ESMTP id S1752813AbWKBKhC (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:37:02 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52]) by
 imag.imag.fr (8.13.6/8.13.6) with ESMTP id kA2AaAes012548
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Thu, 2 Nov 2006 11:36:10 +0100 (CET)
Received: from ecrins.imag.fr ([129.88.43.124]) by mail-veri.imag.fr with
 esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GfZvb-0006fz-Gf for
 git@vger.kernel.org; Thu, 02 Nov 2006 11:36:07 +0100
Received: from moy by ecrins.imag.fr with local (Exim 4.50) id
 1GfZvb-0004dE-Cx for git@vger.kernel.org; Thu, 02 Nov 2006 11:36:07 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

Is it possible with git to push to a server on which git is not
installed, and if so, how?

From the man page of git, sftp doesn't seem supported, and ssh://
complains about git-receive-pack not being installed on the server.

The man page documents a rsync:// protocol, but

$ git push rsync://some.location.com/
fatal: I don't handle protocol 'rsync'
$ 

What am I missing?

Thanks,

-- 
