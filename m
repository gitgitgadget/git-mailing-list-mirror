X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH (amend)] gitweb: Slight visual improvements to commitdiff view
Date: Thu, 26 Oct 2006 17:39:14 -0700 (PDT)
Message-ID: <780488.44315.qm@web31803.mail.mud.yahoo.com>
References: <200610270150.40100.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 27 Oct 2006 00:41:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=aLrzSz/0TIhDHfGE99xBJlUOLgA5jpuXFX/nfp0nT4S0QReMUKKkfXKKieNhxt2fvG0bj/BICC/RmST5w1eQlLeYw/h8a6BA+Zni6Eo8A2L1cUtgUe3bKM60umWD1izVpJ08n3g8MzURpwSA4ngDXEj5HpOrYAo+orfYVgrKYio=  ;
X-YMail-OSG: YG5LEHkVM1leBuJ3szlXGdFC8M08wjWUwso_sz1b2UHS_ldEwpkXynu9A9D0C9otxvpVHdibDg67lYwUCWPtfOfoxDOGoZUT6FxcXBy9zv7g.xTYOCGKog0kgpjh8K5vARqMHgz4_UrUgWU-
In-Reply-To: <200610270150.40100.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30268>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdFks-0005qc-Jc for gcvg-git@gmane.org; Fri, 27 Oct
 2006 02:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423734AbWJ0AjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 20:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423735AbWJ0AjQ
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 20:39:16 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:22184 "HELO
 web31803.mail.mud.yahoo.com") by vger.kernel.org with SMTP id
 S1423734AbWJ0AjP (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006
 20:39:15 -0400
Received: (qmail 44642 invoked by uid 60001); 27 Oct 2006 00:39:14 -0000
Received: from [64.215.88.90] by web31803.mail.mud.yahoo.com via HTTP; Thu,
 26 Oct 2006 17:39:14 PDT
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> First, I have removed creating empty divs. The div with number of 
> changed files in git_difftree_body is added only if the message about 
> number of changed files is displayed (above 10).
> 
> Second, I have moved commit message body in commitdiff outside 
> "page_body" div, to be together with "author_date" div with authorship 
> info. The name of class was changed from "log" to more informative 
> "commitdiff_log". This required some changes and additions to CSS. Now 
> "commitdiff_log" div is responsible for displaying line separatring it 
> from "page_body".
> 
> I have added not full line above "patchset" div (between patchet and 
> difftree). It is added by "patchset" div and separated by 8px padding.
> 
> 
> Those changes might wait for proper refactoring of gitweb CSS (having 
> for example 8px padding in one place only).

Excellent!  I'd like this explanation to be part of the
commit message if that patchset is committed to git.git.

    Luben
