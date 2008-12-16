From: jidanni@jidanni.org
Subject: git-diff should not fire up $PAGER if there is no diff
Date: Tue, 16 Dec 2008 08:21:33 +0800
Message-ID: <874p15x94i.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 16 01:22:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCNiB-0006iG-LM
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 01:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbYLPAVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 19:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbYLPAVh
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 19:21:37 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:50875 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753145AbYLPAVg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Dec 2008 19:21:36 -0500
Received: from jidanni2.jidanni.org (122-127-35-251.dynamic.hinet.net [122.127.35.251])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id B2F0CD26D2
	for <git@vger.kernel.org>; Mon, 15 Dec 2008 16:21:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103220>

git-diff should not fire up $PAGER if there is no diff output.
Just exit. The man page doesn't even mention $PAGER too.
