X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-explain
Date: Tue, 05 Dec 2006 11:43:04 +0100
Organization: At home
Message-ID: <el3ibq$9kn$2@sea.gmane.org>
References: <200612031701.15594.alan@chandlerfamily.org.uk> <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org> <7v1wngwws6.fsf@assigned-by-dhcp.cox.net> <7vwt57j94c.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 5 Dec 2006 10:41:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33335>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrXjc-0001p8-Mt for gcvg-git@gmane.org; Tue, 05 Dec
 2006 11:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967586AbWLEKlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 05:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937497AbWLEKlJ
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 05:41:09 -0500
Received: from main.gmane.org ([80.91.229.2]:55829 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S937496AbWLEKlG
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 05:41:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrXjU-0002kS-CB for git@vger.kernel.org; Tue, 05 Dec 2006 11:41:04 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 11:41:04 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05 Dec 2006
 11:41:04 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> [PATCH] git-explain
> 
> This patch adds "git-explain" script that notices various clues
> other commands can leave the working tree and repository in and
> intended to guide the end user out of the confused mess.

I like it, although I think that it explains a bit too little
about aborted git-rebase / git-am, and for example doesn't touch
git-bisect at all. Both as an end-user script (BTW. the name could
be changed using aliases), and as a policy for git commands.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

