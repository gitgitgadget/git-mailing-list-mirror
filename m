X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git-commit: select which files to commit while editing the commit message
Date: Fri, 8 Dec 2006 23:10:23 +0100
Message-ID: <200612082310.24140.Josef.Weidendorfer@gmx.de>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 22:10:43 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <360959.72234.qm@web31809.mail.mud.yahoo.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33757>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsnvN-0004uL-P0 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 23:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947434AbWLHWKa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 17:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947432AbWLHWKa
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 17:10:30 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:35693 "EHLO
 mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK) by
 vger.kernel.org with ESMTP id S1947430AbWLHWK3 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 17:10:29 -0500
Received: from dhcp-3s-46.lrr.in.tum.de (dhcp-3s-46.lrr.in.tum.de
 [131.159.35.46]) by mail.in.tum.de (Postfix) with ESMTP id 8B2AD282A; Fri,  8
 Dec 2006 23:10:28 +0100 (MET)
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

On Friday 08 December 2006 21:45, Luben Tuikov wrote:
> This is how perforce does it*, and while it is useful, git is NOT perforce,
> and I agree with Junio and Jakub.

However, the idea itself is not bad. AFAIK, cogito does it this way.
It could be done as separate command, e.g. "git add --interactive",
and would only update the index.

