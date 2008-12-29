From: jidanni@jidanni.org
Subject: git-ls-files -l
Date: Tue, 30 Dec 2008 01:07:24 +0800
Message-ID: <87abae6hbn.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 19:14:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHMd0-0007Z3-AK
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 19:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbYL2SMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 13:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbYL2SMw
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 13:12:52 -0500
Received: from sd-green-bigip-177.dreamhost.com ([208.97.132.177]:42914 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751852AbYL2SMw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 13:12:52 -0500
Received: from jidanni.org (122-127-33-187.dynamic.hinet.net [122.127.33.187])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 9CF50D273A
	for <git@vger.kernel.org>; Mon, 29 Dec 2008 10:12:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104121>

Beginners, finding git-ls-files acts like ls,
are baffled as to why they can't go on to ls -l.

The git-ls-files man page should reveal the secret of how also to see
file sizes. Perhaps the closest one can get is
$ git-ls-tree -l --abbrev ...
