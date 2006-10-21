From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/4] gitweb: Improving tree view (plus some cleanups)
Date: Sat, 21 Oct 2006 17:50:48 +0200
Message-ID: <200610211750.49188.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 21 17:55:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbJBa-0004Tu-RJ
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 17:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993117AbWJUPyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 11:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993116AbWJUPyz
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 11:54:55 -0400
Received: from hu-out-0506.google.com ([72.14.214.225]:48549 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S2993111AbWJUPyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 11:54:54 -0400
Received: by hu-out-0506.google.com with SMTP id 28so571711hub
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 08:54:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=rM7qQvZ7SgKZDZDsFg8diJSh65jijYJjwRlFkvtl9aZ/90gNvG3HXW2bW5AShiRCUR3x6GgfYB8hOI/Ay/z8V7vP6ssLghThLqkK1b7bWvxtrBAEmnR45Dx+CeVcvcWQA/F4fp87iGsS2Jvdv1mOBcGOnDQf2VO+miBK3iWp0cs=
Received: by 10.67.117.2 with SMTP id u2mr3939632ugm;
        Sat, 21 Oct 2006 08:54:52 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id s1sm2762273uge.2006.10.21.08.54.52;
        Sat, 21 Oct 2006 08:54:52 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29622>

This series of patches is road to patch introducing '..'
(up directory) link in "tree" view in gitweb; patches 1-3
corrects errors or inconistencies noticed in code generating
"tree" view.

Shortlog:
 [PATCH 1/4] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (2)
 [PATCH 2/4] gitweb: Do not esc_html $basedir argument to git_print_tree_entry
 [PATCH 3/4] gitweb: Improve git_print_page_path
 [PATCH 4/4] gitweb: Add '..' (up directory) to tree view if applicable.

Diffstat:
---
 gitweb/gitweb.perl |  109 ++++++++++++++++++++++++++++++++--------------------
 1 files changed, 68 insertions(+), 41 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
Poland
