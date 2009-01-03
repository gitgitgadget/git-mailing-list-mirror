From: jidanni@jidanni.org
Subject: git-fast-export bundle doc
Date: Sat, 03 Jan 2009 08:52:35 +0800
Message-ID: <87r63lus6k.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 03 01:54:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIumA-0003ZQ-39
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 01:54:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758287AbZACAwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 19:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758247AbZACAwk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 19:52:40 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:58295 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750917AbZACAwj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jan 2009 19:52:39 -0500
Received: from jidanni.org (122-127-35-226.dynamic.hinet.net [122.127.35.226])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 3142C414C1
	for <git@vger.kernel.org>; Fri,  2 Jan 2009 16:52:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104449>

Please improve git-fast-export.txt. It says

       This program dumps the given revisions in a form suitable to be
       piped into git-fast-import.

<revlist> isn't mentioned in the SYNOPSIS.
And there is no hyperlink to the git-fast-import man page, nor in SEE ALSO.)

       You can use it as a human readable bundle replacement (see
       git-bundle(1))

But I tried it and there are apparently a few steps not mentioned that
are needed after git-fast-import before you can actually see the files
again on the other side of the sneakernet.

I used --all, which is in EXAMPLES but not OPTIONS.

Else nothing happens and no error is caught:
$ git fast-export
$

Also the git-bundle man page should SEE ALSO git-fast-export and maybe
even git-fast-import, which itself makes no mention of git-fast-export.
