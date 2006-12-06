X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more obvious
Date: Wed, 06 Dec 2006 13:32:32 +0100
Organization: At home
Message-ID: <el6d50$p7e$2@sea.gmane.org>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 12:35:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 19
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33444>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grvzf-0002NF-WA for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760552AbWLFMfV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760557AbWLFMfV
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:35:21 -0500
Received: from main.gmane.org ([80.91.229.2]:33738 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760552AbWLFMfT
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:35:19 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GrvzK-0001IO-Ga for git@vger.kernel.org; Wed, 06 Dec 2006 13:35:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 13:35:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 13:35:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> +  * Since every working tree contains a repository, a commit will not
> +    publish your changes; it will only create a revision. You have to
> +    "push" your changes to a public repository to make them visible
> +    to others.
> +

I'm not sure about context of this addition, but it is simply not
true if you publish your working repository. Granted, usually one
sets up bare public publishing repository...

By publish I mean set up http(s):// or git://, or ssh+git://, or local
transport.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

