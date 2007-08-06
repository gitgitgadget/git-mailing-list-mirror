From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add support for an info version of the user manual
Date: Mon, 06 Aug 2007 12:19:43 +0200
Message-ID: <86myx5c6dc.fsf@lola.quinscape.zz>
References: <86r6mhc6k7.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 12:20:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHzh9-0003ri-NY
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 12:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762460AbXHFKUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 06:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762414AbXHFKUK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 06:20:10 -0400
Received: from main.gmane.org ([80.91.229.2]:51453 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755686AbXHFKUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 06:20:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IHzgv-0000kB-TV
	for git@vger.kernel.org; Mon, 06 Aug 2007 12:20:01 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 12:20:01 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Aug 2007 12:20:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:1BMPQiLkMlpxHGJTDlQDinzetf0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55136>

David Kastrup <dak@gnu.org> writes:

> These patches use docbook2x in order to create an info version of the
> git user manual.  No existing Makefile targets (including "all") are
> touched, so you need to explicitly say

Scrap that.  The installation case where install-info is used does not
work properly yet.  Another version coming up.

-- 
David Kastrup
