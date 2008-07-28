From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Allow installing in the traditional way
Date: Mon, 28 Jul 2008 22:00:44 +0200
Message-ID: <1217275244.488e256c06da0@webmail.nextra.at>
References: <7vod4itrgg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:01:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNYuh-0004H3-Ud
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbYG1UAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbYG1UAt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:00:49 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:56216 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902AbYG1UAs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:00:48 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp2.srv.eunet.at (Postfix) with ESMTPS id 3D0E0BEF20;
	Mon, 28 Jul 2008 22:00:46 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6SK0iQ3014571;
	Mon, 28 Jul 2008 22:00:45 +0200
Received: from 77.117.178.94 ([77.117.178.94]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Mon, 28 Jul 2008 22:00:44 +0200
In-Reply-To: <7vod4itrgg.fsf@gitster.siamese.dyndns.org>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.117.178.94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90495>

Zitat von Junio C Hamano <gitster@pobox.com>:

> In an earlier commit c70a8d9 (Makefile: Do not install a copy of 'git' in
> $(gitexecdir), 2008-07-21), we tried to avoid installing two git, one in
> /usr/bin/git and the other in /usr/libexec/git-core/git.  It mistakenly
> removed the only copy of git when gitexecdir and bindir are set to the
> same directory, i.e. the traditional layout.

The patch looks fine. Thanks for fixing up my mistakes.

-- Hannes
