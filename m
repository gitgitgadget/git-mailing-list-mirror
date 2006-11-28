X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 12:15:00 +0100
Organization: At home
Message-ID: <ekh5k8$vih$1@sea.gmane.org>
References: <ekh2uh$nk2$1@sea.gmane.org> <ekh4cu$q6e$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 28 Nov 2006 11:13:48 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 23
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32511>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp0uI-0004dF-Fh for gcvg-git@gmane.org; Tue, 28 Nov
 2006 12:13:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935861AbWK1LNi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 06:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935853AbWK1LNi
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 06:13:38 -0500
Received: from main.gmane.org ([80.91.229.2]:59339 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935861AbWK1LNh (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 06:13:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp0tt-0004aA-E6 for git@vger.kernel.org; Tue, 28 Nov 2006 12:13:21 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 12:13:21 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 12:13:21 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote:

> Han-Wen Nienhuys escreveu:
>> Trim hint printed when gecos is empty.
>> Remove asterisks for readability
>> Suggest use of git-config for easy cut & pasting.
>> ---
> 
> and 
> 
> Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
> 
> is there a reason why git-format-patch doesn't add a sign-off by default?

Yes. You are supposed to add Signed-off-by on commit (I hope that
git-format-patch doesn't dulicate signoff lines), using git-commit -s.

But perhaps a config option...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

