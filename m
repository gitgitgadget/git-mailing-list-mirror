From: jidanni@jidanni.org
Subject: some git-commands --help don't act like git commands --help
Date: Mon, 29 Dec 2008 14:25:51 +0800
Message-ID: <87iqp333bk.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 29 07:27:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHBau-0006K5-O5
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 07:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYL2GZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 01:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbYL2GZz
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 01:25:55 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:52611 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750862AbYL2GZy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 01:25:54 -0500
Received: from jidanni.org (122-127-43-85.dynamic.hinet.net [122.127.43.85])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 8B078119DB7
	for <git@vger.kernel.org>; Sun, 28 Dec 2008 22:25:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104072>

Hmmm, some git-commands --help act just like git commands --help,
$ git commit --help 2>&1|wc -l
336
$ git-commit --help 2>&1|wc -l
336

But others don't
$ git am --help 2>&1|wc -l
152
$ git-am --help 2>&1|wc -l
19

$ git --version
git version 1.5.6.5
on Debian sid.
