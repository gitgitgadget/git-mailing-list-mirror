X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] xdl_merge(): fix and simplify conflict handling
Date: Tue, 05 Dec 2006 23:27:37 +0100
Organization: At home
Message-ID: <el4rko$aqe$1@sea.gmane.org>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org> <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org> <7vejri20mf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4575B32F.5060108@ramsay1.demon.co.uk> <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org> <Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de> <7vac22glzz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612052209030.28348@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekqf0yh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 5 Dec 2006 22:25:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 12
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33379>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrijW-0006pG-0z for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936574AbWLEWZr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936571AbWLEWZr
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:25:47 -0500
Received: from main.gmane.org ([80.91.229.2]:34159 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S936574AbWLEWZq
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 17:25:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrijI-0001Dk-6q for git@vger.kernel.org; Tue, 05 Dec 2006 23:25:36 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 23:25:36 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 05 Dec 2006
 23:25:36 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Looking at some other cases after applying your patch, I noticed
> that I really like one thing that your version does over what
> RCS merge does.

Is it with "try harder" option?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

