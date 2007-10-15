From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue with excludes (was: Re: git-svn and
 submodules)
Date: Mon, 15 Oct 2007 10:10:33 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710151009460.6887@woody.linux-foundation.org>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org>
 <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp>
 <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site>
 <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma>
 <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled>
 <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr>
 <alpine.LFD.0.999.0710150848380.6887@woody.linux-foundation.org>
 <C7EA8AD7-BACA-4116-9C6B-90BA23F0005C@lrde.epita.fr>
 <alpine.LFD.0.999.0710150928450.6887@woody.linux-foundation.org>
 <45410184-8D7D-47ED-AB10-1A4E52D0ADB0@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Oct 15 20:20:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhTU7-0006qz-RQ
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 19:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765650AbXJORLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 13:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765648AbXJORLf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 13:11:35 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47777 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765641AbXJORLd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2007 13:11:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9FHAYB8014877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Oct 2007 10:10:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9FHAXwh015166;
	Mon, 15 Oct 2007 10:10:33 -0700
In-Reply-To: <45410184-8D7D-47ED-AB10-1A4E52D0ADB0@lrde.epita.fr>
X-Spam-Status: No, hits=-2.677 required=5 tests=AWL,BAYES_00,TW_SV
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61016>



On Mon, 15 Oct 2007, Benoit SIGOURE wrote:
> 
> There is no .gitignore, only .git/info/exclude.

They do exactly the same thing (apart from the nesting nature of 
.gitignore wrt subdirectories), so that doesn't change anything.

		Linus
