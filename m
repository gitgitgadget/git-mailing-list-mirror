X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: how to pass ssh options to git?
Date: Thu, 02 Nov 2006 10:20:23 +0100
Message-ID: <vpqejsm433c.fsf@ecrins.imag.fr>
References: <20061102090717.GE7468@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 09:21:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061102090717.GE7468@mellanox.co.il> (Michael S. Tsirkin's message of "Thu\, 2 Nov 2006 11\:07\:17 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 02 Nov 2006 10:20:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30695>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfYlT-00073P-4I for gcvg-git@gmane.org; Thu, 02 Nov
 2006 10:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752766AbWKBJVb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 04:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbWKBJVb
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 04:21:31 -0500
Received: from imag.imag.fr ([129.88.30.1]:695 "EHLO imag.imag.fr") by
 vger.kernel.org with ESMTP id S1752766AbWKBJVa (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 04:21:30 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52]) by
 imag.imag.fr (8.13.6/8.13.6) with ESMTP id kA29KORt025270
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO); Thu, 2 Nov 2006
 10:20:25 +0100 (CET)
Received: from ecrins.imag.fr ([129.88.43.124]) by mail-veri.imag.fr with
 esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GfYkJ-00054w-88; Thu,
 02 Nov 2006 10:20:23 +0100
Received: from moy by ecrins.imag.fr with local (Exim 4.50) id
 1GfYkJ-0004TZ-4L; Thu, 02 Nov 2006 10:20:23 +0100
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Sender: git-owner@vger.kernel.org

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> How is it possible to pass ssh options to git?
> for example, I use these options to log into some machine:
> ssh -i <private> -o HostKeyAlias=<alias> -p <port> -l <user> <address>

Not answering the question, but this can go to ~/.ssh/config :

Host *.domain.net
User some_user
IdentityFile ~/.ssh/foobar

Host another.host
...

-- 
