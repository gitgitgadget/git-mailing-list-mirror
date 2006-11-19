X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nikolai Weibull" <now@bitwi.se>
Subject: Shouldn't git-ls-files --others use $GIT_DIR?
Date: Sun, 19 Nov 2006 14:37:42 +0100
Message-ID: <dbfc82860611190537q77c8a358m184377a21d5a3e11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 19 Nov 2006 13:37:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=NqVgf3/CoJTytU2hjamdQ7W56CEZxMcIDqkNc59QCrS493J8P5KN7OBJU5bywxnC0UXL+FzHnMyEVvT1CiOnTfZruWKdwr3jfk4qEESBbS7qg3w+ne/Vi/57gue+2Xxape6+IqIxEAAchJxupe3UEhS/ND8UrgXcbO+fjLMAVAE=
Content-Disposition: inline
X-Google-Sender-Auth: a16c2ed43698bdc8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31830>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glmrj-0005r3-IU for gcvg-git@gmane.org; Sun, 19 Nov
 2006 14:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756663AbWKSNho (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 08:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756664AbWKSNho
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 08:37:44 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:53276 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1756663AbWKSNhn
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 08:37:43 -0500
Received: by wx-out-0506.google.com with SMTP id s7so1476490wxc for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 05:37:43 -0800 (PST)
Received: by 10.90.78.1 with SMTP id a1mr2699601agb.1163943462960; Sun, 19
 Nov 2006 05:37:42 -0800 (PST)
Received: by 10.90.65.18 with HTTP; Sun, 19 Nov 2006 05:37:42 -0800 (PST)
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

If I do

GIT_DIR=$HOME/projects/<project>/.git git ls-files --others

from, e.g., $HOME, I get a list of all the files in $HOME and its
subdirectories that aren't in said git repository.  Shouldn't --others
use $GIT_DIR, instead of ".", or am I missing something here?

