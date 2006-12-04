X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] git-fetch: do not use "*" for fetching multiple refs
Date: Mon, 04 Dec 2006 20:48:27 +0100
Organization: At home
Message-ID: <el1tud$n07$2@sea.gmane.org>
References: <1165261102.20055.9.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 4 Dec 2006 19:48:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 24
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33232>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrJnH-0001Qe-M0 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 20:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937347AbWLDTru (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 14:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966116AbWLDTrN
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 14:47:13 -0500
Received: from main.gmane.org ([80.91.229.2]:33333 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S966059AbWLDTqo
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 14:46:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrJlr-0000p1-29 for git@vger.kernel.org; Mon, 04 Dec 2006 20:46:35 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 20:46:35 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 20:46:35 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Michael Loeffler wrote:

> The trailing / is enough to decide if this should map everything under
> refs/heads/ to refs/somewhere/.
> 
> The "*" should be reserved for the use as regex operator.
> 
> Signed-off-by: Michael Loeffler <zvpunry@zvpunry.de>
> ---
> I want to use regular expressions to match remote refs, so I try to
> implement this. But the current globfetch syntax needs the '*'.
> 
> Maybe it is not to late to change the syntax to this:
> Pull: refs/heads/:refs/remotes/origin/
> 
> What do you think?

I'm not sure if regexp support is truly better than the usual path globbing,
as in fnmatch / glob.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

