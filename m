X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Did anyone have trouble learning the idea of local vs. remote branches?
Date: Wed, 08 Nov 2006 06:19:15 +0100
Message-ID: <vpqbqnisegc.fsf@ecrins.imag.fr>
References: <20061107172450.GA26591@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 05:19:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <20061107172450.GA26591@spearce.org> (Shawn Pearce's message of "Tue\, 7 Nov 2006 12\:24\:50 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Wed, 08 Nov 2006 06:19:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31116>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghfqh-0001Ij-BJ for gcvg-git@gmane.org; Wed, 08 Nov
 2006 06:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754288AbWKHFTj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 00:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbWKHFTj
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 00:19:39 -0500
Received: from imag.imag.fr ([129.88.30.1]:43913 "EHLO imag.imag.fr") by
 vger.kernel.org with ESMTP id S1754288AbWKHFTj (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 00:19:39 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52]) by
 imag.imag.fr (8.13.6/8.13.6) with ESMTP id kA85JFcx018329
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO) for
 <git@vger.kernel.org>; Wed, 8 Nov 2006 06:19:15 +0100 (CET)
Received: from ecrins.imag.fr ([129.88.43.124]) by mail-veri.imag.fr with
 esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GhfqF-00077I-DW for
 git@vger.kernel.org; Wed, 08 Nov 2006 06:19:15 +0100
Received: from moy by ecrins.imag.fr with local (Exim 4.50) id
 1GhfqF-0002Tj-Af for git@vger.kernel.org; Wed, 08 Nov 2006 06:19:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Today I was talking with someone that I collaborate with through
> Git and they still seemed to not get the idea that all branches
> in their repository are local, and that at least a 'git fetch'
> is needed to update the local tracking branches to the version
> in the central repository that we collaborate through.  And this
> isn't the first time we've had such discussions.

To me, the biggest difficulty was to understand the vocubulary. I
started with cogito, and looked for branching features in cg-branch-*.
The /features/ themselves seem nice, but the names of commands are
confusing to me. I'd expect something called cg-branch-add to create a
new branch, while it just tells cogito where to find one. And the git
Vs cogito increased the confusion.

-- 
