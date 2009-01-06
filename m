From: jidanni@jidanni.org
Subject: git-branch man page contains rendered nroff
Date: Tue, 06 Jan 2009 11:06:36 +0800
Message-ID: <87hc4dnner.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 04:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK2IR-0007wm-9r
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 04:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbZAFDGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 22:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753966AbZAFDGl
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 22:06:41 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:41299 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753957AbZAFDGk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2009 22:06:40 -0500
Received: from jidanni.org (122-127-36-59.dynamic.hinet.net [122.127.36.59])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 4BFCA4154B
	for <git@vger.kernel.org>; Mon,  5 Jan 2009 19:06:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104625>

$ make git-branch.1 && man -l git-branch.1|col -b|fgrep .ft|sort|uniq -c
      2 	       .ft
      2 	       .ft C
Yuck.
