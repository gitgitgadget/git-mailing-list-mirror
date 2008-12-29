From: jidanni@jidanni.org
Subject: shallow clone, shallow fetch?
Date: Tue, 30 Dec 2008 02:07:27 +0800
Message-ID: <87vdt24zz4.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 19:14:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHMcz-0007Z3-IV
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 19:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbYL2SMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 13:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbYL2SMr
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 13:12:47 -0500
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:42908 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751847AbYL2SMq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 13:12:46 -0500
Received: from jidanni.org (122-127-33-187.dynamic.hinet.net [122.127.33.187])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id D32DDD273B
	for <git@vger.kernel.org>; Mon, 29 Dec 2008 10:12:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104120>

man git-clone at --depth could also mention if updating procedures are
for shallow clones just like for plain git-clones, or is there a diet
way of updating too? (Not git-fetch --depth apparently.)

(The diet way would give results like one did
$ rm -r .git *; git-clone --depth 1 ...
all over again, but only cause a small download this time.)
