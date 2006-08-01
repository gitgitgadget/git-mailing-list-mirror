From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A few more fixups to gitweb
Date: Tue, 01 Aug 2006 09:36:54 +0200
Organization: At home
Message-ID: <ean0a1$irf$1@sea.gmane.org>
References: <200607292239.11034.jnareb@gmail.com> <200608010259.13721.jnareb@gmail.com> <7vzmep2icr.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 01 09:36:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7oo3-0003y6-Az
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 09:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161335AbWHAHgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 03:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161344AbWHAHgo
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 03:36:44 -0400
Received: from main.gmane.org ([80.91.229.2]:11181 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161335AbWHAHgn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 03:36:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7ony-0003xD-QP
	for git@vger.kernel.org; Tue, 01 Aug 2006 09:36:42 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 09:36:42 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 09:36:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24580>

Junio C Hamano wrote:

> One thing to note.  Please make sure that you do not see
> anything in Apache error log after you make your changes.  I do
> not remember the details but kernel.org folks were very unhappy
> earlier when gitweb spewed stuff into the error log, and if I
> recall correctly things that output to the error stream were not
> friendly to the http-server cache for some reason.

By the way, I wonder why git when cloning/fetching via http protocol
uses e.g. "git/1.4.2.rc2.ge0bed" as User-Agent: string when fetching objects
and packs, and e.g. "curl/7.15.4 (i486-pc-linux-gnu) libcurl/7.15.4
OpenSSL/0.9.8b zlib/1.2.3 libidn/0.6.5" as User-Agent: when fetching refs
(heads and tags) and info/refs.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
