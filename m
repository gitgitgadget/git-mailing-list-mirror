From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Terminology question: "tracking" branches
Date: Mon, 27 Oct 2008 11:43:44 -0400
Message-ID: <4905E1B0.8040601@xiplink.com>
References: <48F7BBAC.2090907@xiplink.com> <48F83FD0.90606@drmicha.warpmail.net> <48F8A4E8.8070008@xiplink.com> <48F8AA5E.6090908@drmicha.warpmail.net> <48F8ECA2.3040208@xiplink.com> <48FC8624.9090807@fastmail.fm> <48FCB6B8.6090708@xiplink.com> <48FDA5A0.8030506@drmicha.warpmail.net> <48FDF28A.9060606@xiplink.com> <48FF3FEE.8020209@drmicha.warpmail.net> <20081022161302.GC16946@atjola.homenet> <490030AB.8090207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 16:44:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuUGk-0004kn-RW
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 16:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbYJ0PnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 11:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbYJ0PnX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 11:43:23 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:37980 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYJ0PnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 11:43:22 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 4944E1CBA57;
	Mon, 27 Oct 2008 11:43:21 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTP id 0EA5E1CBA55;
	Mon, 27 Oct 2008 11:43:21 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
In-Reply-To: <490030AB.8090207@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99240>

Michael J Gruber wrote:
> 
> remote tracking branch: Synonymous with tracking branch. [remote is a
> noun, an object for track here]

Er, "remote" is an adjective there...  :)

> [adjective to be found] branch: A local branch which is set up to pull
> or rebase automatically from a tracking branch. Used for local
> modifications to remote branches. [I'm tempted to use local tracking
> branch here, but that would just add to the confusion.]

I say there's no need for an adjective here, as this is just a plain old 
branch that git-branch creates by default (right?).

What's needed is an adjective for when git-branch is given the 
--no-track option (or when branch.automergesetup is false). 
"Non-tracking branch" perhaps?

		Marc
