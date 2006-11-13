X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Mon, 13 Nov 2006 15:20:44 +0100
Organization: At home
Message-ID: <ej9utk$44p$1@sea.gmane.org>
References: <45530CEE.6030008@b-i-t.de> <7vvelnjd4p.fsf@assigned-by-dhcp.cox.net> <45587A09.3020605@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 13 Nov 2006 14:20:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31300>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjcf9-0002Zi-EQ for gcvg-git@gmane.org; Mon, 13 Nov
 2006 15:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754739AbWKMOTs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 09:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbWKMOTs
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 09:19:48 -0500
Received: from main.gmane.org ([80.91.229.2]:46017 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1754739AbWKMOTr (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 09:19:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gjcf1-0002XW-IN for git@vger.kernel.org; Mon, 13 Nov 2006 15:19:43 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 13 Nov 2006 15:19:43 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 13 Nov 2006
 15:19:43 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

sf wrote:

> Thanks, Junio. Paths with umlauts are returned correctly now both in 
> UTF-8 and ISO-8859-1. I guess git-cvsserver is now as encoding agnostic 
> as git core.

By the way, now that git has per user config file, ~/.gitconfig, perhaps
it is time to add i18n.filesystemEncoding configuration variable, to
automatically convert between filesystem encoding (somthing you usually
don't have any control over) and UTF-8 encoding of paths in tree objects.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

