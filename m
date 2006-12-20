X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: git-merge-recursive segmentation error
Date: Tue, 19 Dec 2006 17:00:38 -0800 (PST)
Message-ID: <693577.67723.qm@web31813.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 20 Dec 2006 01:02:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=yJoK//QcMh/CpVnmfmOqivYhYXjjYmMhlbgbjgwqps30YqiGrpkyiL+iSQSE0kcl7Gnkgkzm+M/vEWrRfgWyKL013IG+KspLkmqhF6534pmp3fMurARGDMVt2JOKj4kwpmC8toOHJ297rgsLoK0kwBVPEE3jM7sJRfsB6ZVc9ac=;
X-YMail-OSG: mqEftPMVM1m2xcrunqCQOnltE3KlkJO.QhV03MgoAGbXo_cpb.OeXPChdjP9NsNpYG58mPgdc6lbBmzmq6DHp0SdzD7e0ggLhQFNXovjhVfy83yzxTUm0Vdh8ydqEFFXtNLcLG8qhyfyhg--
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34880>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpqJ-0006pJ-94 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932822AbWLTBAk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932826AbWLTBAk
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:00:40 -0500
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:38530 "HELO
 web31813.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S932821AbWLTBAj (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 20:00:39 -0500
Received: (qmail 68584 invoked by uid 60001); 20 Dec 2006 01:00:38 -0000
Received: from [64.215.88.90] by web31813.mail.mud.yahoo.com via HTTP; Tue,
 19 Dec 2006 17:00:38 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

So, I'm merging Linux master into my own dev tree and
here is what I get in syslog:

Dec 19 16:56:38 lion kernel: [ 1704.395478] git-merge-recur[12030] general protection rip:4285ef
rsp:7ffff727bf40 error:0

and on the command line:
...
Auto-merging init/Kconfig
Auto-merging init/version.c
/home/luben/bin/git-merge: line 394: 12030 Segmentation fault      git-merge-$strategy $common --
"$head_arg" "$@"
Merge with strategy recursive failed.

I'm running "next".

Are the people aware of this issue?

It is 100% reproducible on my trees.

Anyone has a patch?

     Luben


