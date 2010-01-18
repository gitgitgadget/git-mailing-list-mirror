From: Adam Megacz <adam@megacz.com>
Subject: "warning: Updating the currently checked out branch may cause confusion" on bare repositories
Date: Mon, 18 Jan 2010 22:41:26 +0000
Organization: Myself
Message-ID: <xuu2ska3doix.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 23:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX0ID-0006TW-8e
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 23:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260Ab0ARWlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 17:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449Ab0ARWlw
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 17:41:52 -0500
Received: from lo.gmane.org ([80.91.229.12]:45225 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab0ARWlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 17:41:51 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NX0I7-0006Ro-MA
	for git@vger.kernel.org; Mon, 18 Jan 2010 23:41:47 +0100
Received: from gentzen.megacz.com ([65.23.129.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 23:41:47 +0100
Received: from adam by gentzen.megacz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 23:41:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gentzen.megacz.com
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:/etr3IesbiC8mDGH4t2LLJLrkxM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137410>


It seems that the message "warning: Updating the currently checked out
branch may cause confusion" is unnecessary when pushing to a bare
"myproject.git" repository (instead of a "myproject/.git" repository).

Is this the case?

If so, perhaps the warning should be omitted when the target is a bare
repository.

  - a
