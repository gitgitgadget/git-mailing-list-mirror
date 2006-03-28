From: Linus Torvalds <torvalds@osdl.org>
Subject: Gitk strangeness..
Date: Mon, 27 Mar 2006 18:05:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 28 04:06:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO3ar-00011Q-E2
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 04:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWC1CF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 21:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWC1CF5
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 21:05:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14034 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932135AbWC1CF5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 21:05:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2S25oDZ021540
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Mar 2006 18:05:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2S25nJ8010458;
	Mon, 27 Mar 2006 18:05:49 -0800
To: Junio C Hamano <junkio@cox.net>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18100>



On Mon, 27 Mar 2006, Junio C Hamano wrote:
>
> GIT 1.3.0-rc1 is pushed out and will be mirrored out soon.

I did 

	gitk ORIG_HEAD..

with this, and the end result looks horrible. I think it's the new gitk 
that does it.

Paul, do this on the current git tree:

	gitk b0a3de42..dff86e28

and tell me it doesn't look horrid.

Maybe it's not a new thing, and it's just that the recent pattern of 
merges in the git tree makes any version of gitk do horrible things.

		Linus
