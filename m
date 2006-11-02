X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Minor documentation problems [RFC PATCH]
Date: Thu, 02 Nov 2006 14:29:35 +0100
Message-ID: <vpqwt6em0xs.fsf@ecrins.imag.fr>
References: <vpqmz7a1694.fsf@ecrins.imag.fr>
	<BAYC1-PASMTP018DA61B5F35F9603DF8A8AEFF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 13:30:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <BAYC1-PASMTP018DA61B5F35F9603DF8A8AEFF0@CEZ.ICE> (Sean's message of "Thu\, 2 Nov 2006 07\:39\:43 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Thu, 02 Nov 2006 14:29:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30747>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfceP-0002OP-IQ for gcvg-git@gmane.org; Thu, 02 Nov
 2006 14:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752874AbWKBNaa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 08:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752867AbWKBNaa
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 08:30:30 -0500
Received: from imag.imag.fr ([129.88.30.1]:29684 "EHLO imag.imag.fr") by
 vger.kernel.org with ESMTP id S1752874AbWKBNa3 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 08:30:29 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52]) by
 imag.imag.fr (8.13.6/8.13.6) with ESMTP id kA2DTaWD022366
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Thu, 2 Nov 2006 14:29:37 +0100 (CET)
Received: from ecrins.imag.fr ([129.88.43.124]) by mail-veri.imag.fr with
 esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GfcdT-0001y6-Cr for
 git@vger.kernel.org; Thu, 02 Nov 2006 14:29:35 +0100
Received: from moy by ecrins.imag.fr with local (Exim 4.50) id
 1GfcdT-00058B-9k for git@vger.kernel.org; Thu, 02 Nov 2006 14:29:35 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

> This is the git version :
>
> $ git repo-config user.email "myself@myisp.com"
> $ git repo-config user.name "me"

Great!

But this should be mentionned in
http://www.kernel.org/pub/software/scm/git/docs/git-commit-tree.html
too.

Perhaps, "As an alternative to editing the .git/config or ~/.gitconfig
manually, you can use git-repo-config".

BTW,
http://www.kernel.org/pub/software/scm/git/docs/git-commit-tree.html
also fails to mention ~/.gitconfig.

-- 
