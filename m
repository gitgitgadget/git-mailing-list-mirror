From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 21:15:30 +0100
Message-ID: <20080115201530.GA17239@efreet.light.src>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.DEB.1.00.0801151612470.5289@eeepc-johanness> <c0f2d4110801150823u7899e6dds1192b5f3bb3f7133@mail.gmail.com> <alpine.DEB.1.00.0801151650240.5289@eeepc-johanness> <c0f2d4110801150907y59593407u820c7b3db556ed31@mail.gmail.com> <alpine.DEB.1.00.0801151709330.5289@eeepc-johanness> <c0f2d4110801151104j4c34dekc7d06dcfc89bfbe6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Chris Ortman <chrisortman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEsCs-0004TL-Od
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYAOUPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbYAOUPn
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:15:43 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:50500 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbYAOUPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:15:42 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id A56E357377;
	Tue, 15 Jan 2008 21:15:40 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id MpPzMYQLgXyj; Tue, 15 Jan 2008 21:15:35 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 51E045736C;
	Tue, 15 Jan 2008 21:15:35 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1JEsC2-0007wL-HU; Tue, 15 Jan 2008 21:15:30 +0100
Content-Disposition: inline
In-Reply-To: <c0f2d4110801151104j4c34dekc7d06dcfc89bfbe6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70550>

On Tue, Jan 15, 2008 at 13:04:23 -0600, Chris Ortman wrote:
> Myself and many others have excellent luck with the cygwin version.
> But the reasoning behind wanting this isn't so much for the developer
> that is creating the patch as it is for the person receiving it. Most
> of the projects I work on use tortoise to apply the patches and don't
> typically have patch.exe

Note, that tortoise might actually use the version numbers, so bonus points
for actually finding them (where applicable -- if the patch is not based on
subversion revision, you can't get them).

> If something like this was to be accepted and become part of standard
> git is there a requirement that it be written in perl or is some other
> scripting language fine?

Git currently uses C, shell, perl and tcl/tk. There would probably be some
resistance to adding more dependencies, but that would not apply to the
contrib directory (so useful things written in something else are likely to
end up there).

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
