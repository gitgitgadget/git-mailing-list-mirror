From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Apply patch on server w/o git
Date: Sat, 29 Mar 2008 19:46:06 +0100
Message-ID: <20080329184606.GB4920@efreet.light.src>
References: <CA08AA77-A9EA-4490-B1BE-25E8B7402290@faithfulgeek.org> <200803252057.38326.robin.rosenberg.lists@dewire.com> <323B72DF-3387-40ED-8235-213A9FAD6CDD@faithfulgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Sat Mar 29 19:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfg4y-00040B-Ti
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 19:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbYC2SqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 14:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYC2SqR
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 14:46:17 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:58164 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753765AbYC2SqR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 14:46:17 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 03D4E574F1;
	Sat, 29 Mar 2008 19:46:16 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id hGqlUcfQjRPX; Sat, 29 Mar 2008 19:46:13 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id D9677574E6;
	Sat, 29 Mar 2008 19:46:12 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1Jfg46-000558-3j; Sat, 29 Mar 2008 19:46:06 +0100
Content-Disposition: inline
In-Reply-To: <323B72DF-3387-40ED-8235-213A9FAD6CDD@faithfulgeek.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78477>

On Tue, Mar 25, 2008 at 23:03:58 -0400, Joe Fiorini wrote:
> Thanks for all your replies.  Unfortunately, I cannot use git apply  
> because I will not have access to git on the server where I'm doing the 
> patch.  I will try Jan's suggestion of ignoring whitespace.

By the way, why *can't* you use git there? There is win32 build of git
(http://code.google.com/p/msysgit/) and if you can't get the repository over
(but if you can get anything there, you should be able to get bundles there
too), you can still use git-apply, since it can work without a repository as
a pure patch replacement.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
