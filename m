From: jidanni@jidanni.org
Subject: Re: git ls-tree prints wacko file sizes if it can't find the blob
Date: Fri, 02 Jan 2009 07:47:28 +0800
Message-ID: <87d4f6twq7.fsf_-_@jidanni.org>
References: <87eizmty25.fsf_-_@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 00:48:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIXHa-0004OQ-AQ
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 00:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbZAAXrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 18:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbZAAXrc
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 18:47:32 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:57990 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755159AbZAAXrb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 18:47:31 -0500
Received: from jidanni.org (122-127-33-68.dynamic.hinet.net [122.127.33.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 64A19D25DF
	for <git@vger.kernel.org>; Thu,  1 Jan 2009 15:47:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104342>

> It is even affected by --abbrev:
It's not. It is just randomly grabbing digits even without --abbrev.
