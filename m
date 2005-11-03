From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cogito: make tutorial-script a testsuite
Date: Thu, 3 Nov 2005 11:36:37 +0100
Message-ID: <20051103103637.GI1431@pasky.or.cz>
References: <1130980582.20017.14.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Thu Nov 03 11:37:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXcSj-00079y-Mw
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 11:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVKCKgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 05:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVKCKgk
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 05:36:40 -0500
Received: from w241.dkm.cz ([62.24.88.241]:52638 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964822AbVKCKgk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2005 05:36:40 -0500
Received: (qmail 11676 invoked by uid 2001); 3 Nov 2005 11:36:37 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1130980582.20017.14.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11073>

Dear diary, on Thu, Nov 03, 2005 at 02:16:22AM CET, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Documentation/tutorial-script/script.sh can be used as a testsuite.
> Errors should cause the script to exit.  Unexpected success should be
> treated like an error.  Successful completion should be reported.

Thanks, applied. Perhaps we could invoke it during make test as well...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
