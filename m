From: jidanni@jidanni.org
Subject: git-add --verbose should say when something is already indexed
Date: Mon, 29 Dec 2008 14:46:24 +0800
Message-ID: <87eizr32db.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 07:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHBup-0001Gu-Hx
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 07:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbYL2Gq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 01:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbYL2Gq2
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 01:46:28 -0500
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:41737 "EHLO
	homiemail-a3.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752118AbYL2Gq2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 01:46:28 -0500
Received: from jidanni.org (122-127-43-85.dynamic.hinet.net [122.127.43.85])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a3.dreamhost.com (Postfix) with ESMTP id 19B34C595D
	for <git@vger.kernel.org>; Sun, 28 Dec 2008 22:46:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104074>

git-add or at least git-add --verbose should say upon
$ git-add bla.txt
$ git-add bla.txt
bla.txt is already in the index.

The git-add man page should mention how one can see all the files
added, perhaps by git-ls-files. If so mention in SEE ALSO too.
