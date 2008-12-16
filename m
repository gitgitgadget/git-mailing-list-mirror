From: jidanni@jidanni.org
Subject: Re: git-diff should not fire up $PAGER if there is no diff
Date: Wed, 17 Dec 2008 01:38:23 +0800
Message-ID: <87iqpkggvk.fsf@jidanni.org>
References: <20081216040722.GA4551@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: peff@peff.net
X-From: git-owner@vger.kernel.org Tue Dec 16 18:40:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCdtb-0001Tc-UH
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 18:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbYLPRi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 12:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYLPRi3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 12:38:29 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:51737 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752016AbYLPRi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Dec 2008 12:38:28 -0500
Received: from jidanni1.jidanni.org (122-127-36-214.dynamic.hinet.net [122.127.36.214])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 746EAD273A;
	Tue, 16 Dec 2008 09:38:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103284>

Oh barf, having LESS=F in one's environment messes up less +G:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=508919
