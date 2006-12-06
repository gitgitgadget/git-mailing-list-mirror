X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add builtin merge-file, a minimal replacement for RCS merge
Date: Wed, 06 Dec 2006 16:30:08 +0100
Organization: At home
Message-ID: <el6nhv$58n$1@sea.gmane.org>
References: <Pine.LNX.4.63.0612061609430.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Wed, 6 Dec 2006 15:28:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33474>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gryh9-0002wD-1n for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935412AbWLFP2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935757AbWLFP2Y
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:28:24 -0500
Received: from main.gmane.org ([80.91.229.2]:34207 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S935412AbWLFP2W
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 10:28:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Grygt-00086s-NT for git@vger.kernel.org; Wed, 06 Dec 2006 16:28:11 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 16:28:11 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 16:28:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:

> merge-file has the same syntax as RCS merge, but supports only the
> "-L" option.

Would it be hard to add "-p / --stdout" options, and "-q / --quiet" option?
I understand that non-standard output format options are rather out of
question...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

