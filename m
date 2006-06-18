From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Is there such a thing as a git:// proxy?
Date: Sun, 18 Jun 2006 10:02:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606180953510.5498@g5.osdl.org>
References: <20060618124250.15471.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 18 19:02:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs0fg-00012e-5D
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 19:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWFRRCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 13:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWFRRCp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 13:02:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4326 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932255AbWFRRCo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 13:02:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5IH2egt023894
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Jun 2006 10:02:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5IH2d5G031231;
	Sun, 18 Jun 2006 10:02:40 -0700
To: linux@horizon.com
In-Reply-To: <20060618124250.15471.qmail@science.horizon.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.76__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22094>



On Sun, 18 Jun 2006, linux@horizon.com wrote:
> 
> Has anyone put together something that can automatically check
> upstream for updates when someone fetches from it?

Well, there's actually a much easier solution: just add a "pre-pull" hook 
to "git-send-objects", and then have that hook check the real remote.

Does anybody see any problems with that?

		Linus
