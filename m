X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Undocumented long options
Date: Wed, 20 Dec 2006 17:06:59 +0100
Message-ID: <200612201707.00346.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 16:04:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gGo6gI/jHpxGjkiBbQXwizQZW25tYC+eDoilRZndHa3mlger9HT40ulcPYIJWYwqGHdfCtZpqutz10LHENfKv3UTe5i3A7ApOUT3Lose2SanKQvmSVjkQtJ+fd3fG7+S5UlFHB+Y4W3NaK1+TppxPlssOC874bgvi+vKZUN6PV4=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34943>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx3vf-0005uK-Na for gcvg-git@gmane.org; Wed, 20 Dec
 2006 17:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030182AbWLTQEY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 11:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbWLTQEY
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 11:04:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:31012 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1030182AbWLTQEX (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 11:04:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2274742uga for
 <git@vger.kernel.org>; Wed, 20 Dec 2006 08:04:22 -0800 (PST)
Received: by 10.67.22.2 with SMTP id z2mr9575203ugi.1166630661857; Wed, 20
 Dec 2006 08:04:21 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 59sm12863560ugf.2006.12.20.08.04.21; Wed, 20 Dec
 2006 08:04:21 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Here is the list of undocumented long options I have found in git:

* --abbrev-commit (in revision.c) - I'm not sure _where_ it should
  be added, as it afects most visible I think git-log, git-show,
  git-rev-list. Implies --abbrev.
* --exclude-existing of git-show-ref; new option
* --reflog of git-show-branch, similar to --no-name and --ahs1-name
  options I think; new option
* --timestamp option of git-rev-list. Bit strange, but perhaps useful.
  I don't quite know what it does.
* --full-history option of git-rev-list (--full-diff just got
  documented). I think it would be nice to have described while at it
  git history simplification, and how options like --full-history, path
  limiter, --parents interacts with it.
* --trivial option of git-read-tree. It looks like opposite of
  (documented) --aggresive option, but source indicates that it might
  be not exactly opposite.
* --thin and --no-thin of send-pack. It is plumbing option, but even
  plumbing should be documented. Not sure which commands are affected by
  this.

-- 
Jakub Narebski
