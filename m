X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Fri, 08 Dec 2006 15:59:44 -0800
Message-ID: <m2lkli9bwv.fsf@ziti.local>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
	<200612082310.24140.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 9 Dec 2006 00:01:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=W7vcWcGPSKEeZQ9IzOCkC2GANJuLo93Ts+POKdxIyyhGCOD9wqQL7drvKLhC6foEjiUYtHyQM+li+j/W7d7yreOkLbd/AdAe0sEsfCzEw+DOdYOA7pONnec6+IlWz26uIXL1Mv2ze13FKTTCN9HAS9SnfJ0JiF9H2H+I+vbEhxQ=
In-Reply-To: <200612082310.24140.Josef.Weidendorfer@gmx.de> (Josef Weidendorfer's message of "Fri, 8 Dec 2006 23:10:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33774>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gspei-0000Xq-Tf for gcvg-git@gmane.org; Sat, 09 Dec
 2006 01:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758826AbWLIAAS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 19:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759779AbWLIAAC
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 19:00:02 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:58158 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1947522AbWLHX7r (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec
 2006 18:59:47 -0500
Received: by wx-out-0506.google.com with SMTP id h27so949825wxd for
 <git@vger.kernel.org>; Fri, 08 Dec 2006 15:59:46 -0800 (PST)
Received: by 10.70.32.13 with SMTP id f13mr6925328wxf.1165622386585; Fri, 08
 Dec 2006 15:59:46 -0800 (PST)
Received: from ziti.local ( [140.107.181.122]) by mx.google.com with ESMTP id
 i20sm3655796wxd.2006.12.08.15.59.45; Fri, 08 Dec 2006 15:59:45 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Friday 08 December 2006 21:45, Luben Tuikov wrote:
>> This is how perforce does it*, and while it is useful, git is NOT perforce,
>> and I agree with Junio and Jakub.
>
> However, the idea itself is not bad. AFAIK, cogito does it this way.
> It could be done as separate command, e.g. "git add --interactive",
> and would only update the index.

I think such a feature could be quite useful and it would seem to be
an easy thing to provide in an optional or configurable fashion so
that those that don't like it could avoid it.  

Spelling out a bunch of files spread around your tree for update-index
can be annoying.  Some way of marking a list seems natural.  Maybe
that is a separate issue.

+ seth
