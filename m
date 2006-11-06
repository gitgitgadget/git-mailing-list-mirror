X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Tue, 07 Nov 2006 00:16:22 +0100
Organization: At home
Message-ID: <eiofmt$8nc$1@sea.gmane.org>
References: <200610301953.01875.jnareb@gmail.com> <7virhw5hoi.fsf@assigned-by-dhcp.cox.net> <200611032333.49794.jnareb@gmail.com> <200611062258.08320.jnareb@gmail.com> <7v8xiochw0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 6 Nov 2006 23:16:40 +0000 (UTC)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31031>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhDhh-0000su-AZ for gcvg-git@gmane.org; Tue, 07 Nov
 2006 00:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753688AbWKFXP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 18:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbWKFXP7
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 18:15:59 -0500
Received: from main.gmane.org ([80.91.229.2]:31107 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1753688AbWKFXP6 (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 18:15:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GhDgy-0000jA-U2 for git@vger.kernel.org; Tue, 07 Nov 2006 00:15:48 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 00:15:48 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 07 Nov 2006
 00:15:48 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Here is example code for this:
> 
> Ok.  The issues I raised in the previous round seem to have been
> addressed.  Maybe you would want not to use nested 'sub' and it
> is good to go, I think.
 
Nested sub makes it easy to change gitweb quoting from Character Escape
Codes (CEC) to e.g. Unicode Printable Representation (PR).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

