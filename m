X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Gerrit Pape <pape@smarden.org>
Subject: Re: spurious .sp in manpages
Date: Wed, 13 Dec 2006 10:17:28 +0000
Message-ID: <20061213101728.18138.qmail@017513e6f43450.315fe32.mid.smarden.org>
References: <7vodq8kw97.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 10:24:01 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 05:23:48 EST
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vodq8kw97.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34200>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuRHE-0004Sk-8R for gcvg-git@gmane.org; Wed, 13 Dec
 2006 11:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932648AbWLMKXt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 05:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWLMKXt
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 05:23:49 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:53640 "HELO
 a.mx.smarden.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S932648AbWLMKXs (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 05:23:48 -0500
Received: (qmail 18139 invoked by uid 1000); 13 Dec 2006 10:17:28 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wed, Dec 13, 2006 at 12:58:28AM -0800, Junio C Hamano wrote:
> This is just a random hack to work around problems people seem
> to be seeing in manpage backend of xmlto (it appears we are
> getting ".sp" at the end of line without line break).
> 
> Could people test this out?

The workaround works fine for me on Debian/unstable.

