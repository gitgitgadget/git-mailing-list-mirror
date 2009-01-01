From: jidanni@jidanni.org
Subject: got wet with make --dry-run
Date: Fri, 02 Jan 2009 01:03:58 +0800
Message-ID: <87eizn0xhd.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 01 19:52:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LISey-0006vw-9w
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 19:52:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbZAASuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 13:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753401AbZAASuv
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 13:50:51 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:53707 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753559AbZAASuu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 13:50:50 -0500
Received: from jidanni.org (122-127-33-68.dynamic.hinet.net [122.127.33.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id A11E7D25E0
	for <git@vger.kernel.org>; Thu,  1 Jan 2009 10:50:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104309>

Gentlemen, make --dry-run is booby trapped to still execute commands:
$ (cd Documentation; make --dry-run); find -mtime -1 -type f
./Documentation/doc.dep
./GIT-VERSION-FILE
Forgot $(MAKEFLAGS)? (info "(make)Options/Recursion").
By the way, why would an offline make need
/bin/sh: curl-config: command not found
