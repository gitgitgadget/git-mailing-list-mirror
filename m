From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH v2] make diff --color-words customizable
Date: Tue, 13 Jan 2009 10:50:29 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0901131045470.14865@alien.or.mcafeemobile.com>
References: <87wsd48wam.fsf@iki.fi> <200901101436.48149.jnareb@gmail.com> <alpine.DEB.1.10.0901100950230.21891@alien.or.mcafeemobile.com> <200901130152.24401.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 19:52:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMoNI-0004v6-Cd
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 19:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759855AbZAMSup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 13:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759843AbZAMSup
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 13:50:45 -0500
Received: from x35.xmailserver.org ([64.71.152.41]:44175 "EHLO
	x35.xmailserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758509AbZAMSun (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 13:50:43 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.26 ESMTP Server]
	id <S2C6ACE> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 13 Jan 2009 13:50:41 -0500
X-X-Sender: davide@alien.or.mcafeemobile.com
In-Reply-To: <200901130152.24401.jnareb@gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105518>

On Tue, 13 Jan 2009, Jakub Narebski wrote:

> Is this core algorithm available as some exported function in libxdiff?
> I mean would it be easy to replace default line tokenizer (per-line
> pre-processing) and post-processing to better deal with word diff?

In libxdiff, no. I hadn't thought to export the raw Meyer algo, and nobody 
ever asked before.


> The other side would be to generate per-paragraph diffs (with empty
> line being separator)...

In Git I guess you can use it to generate other kind of diffs. I don't see 
any problems with that. Just requires more memory WRT a line based one.


- Davide
