From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Handling large files with GIT
Date: Tue, 14 Feb 2006 14:01:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602141357300.3691@g5.osdl.org>
References: <46a038f90602080114r2205d72cmc2b5c93f6fffe03d@mail.gmail.com> 
 <87slqty2c8.fsf@mid.deneb.enyo.de> <46a038f90602081435x49e53a1cgdc56040a19768adb@mail.gmail.com>
 <Pine.OSX.4.64.0602131416530.25089@piva.hawaga.org.uk>
 <Pine.LNX.4.64.0602121939070.3691@g5.osdl.org> <Pine.LNX.4.64.0602122049010.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602122058260.3691@g5.osdl.org> <43F113A5.2080506@f2s.com>
 <Pine.LNX.4.63.0602141953000.22451@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0602141108050.3691@g5.osdl.org> <43F249F7.5060008@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ian Molton <spyro@f2s.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 23:01:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F98F0-0003Qy-Qj
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 23:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbWBNWBn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 17:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWBNWBn
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 17:01:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422823AbWBNWBm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 17:01:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1EM1YDZ003173
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 14 Feb 2006 14:01:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1EM1X9k029502;
	Tue, 14 Feb 2006 14:01:34 -0800
To: Sam Vilain <sam@vilain.net>
In-Reply-To: <43F249F7.5060008@vilain.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16183>



On Wed, 15 Feb 2006, Sam Vilain wrote:
> 
> This seems to me to be another use case where git could gain orders of
> magnitude speed improvement by either explicit ("forensic") history
> objects, or a history analysis cache.

Well, the thing is, it could get that _without_ any cache too.

The problem really isn't that we couldn't make things faster, the problem 
is that at least for _me_ the thing is fast enough.

If somebody is interested in making the "lots of filename changes" case go 
fast, I'd be more than happy to walk them through what they'd need to 
change. I'm just not horribly motivated to do it myself. Hint, hint.

			Linus
