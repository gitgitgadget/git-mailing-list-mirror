From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: git to libgit2 code relicensing
Date: Tue, 25 Nov 2008 10:19:21 -0500
Message-ID: <1227626361.4612.4.camel@gaara.bos.redhat.com>
References: <491DE6CC.6060201@op5.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 25 16:21:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4zjN-000377-4O
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 16:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbYKYPUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 10:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbYKYPUV
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 10:20:21 -0500
Received: from mx2.redhat.com ([66.187.237.31]:46555 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbYKYPUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 10:20:20 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mAPFK8vb018291;
	Tue, 25 Nov 2008 10:20:11 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mAPFK77v017122;
	Tue, 25 Nov 2008 10:20:07 -0500
Received: from [10.16.3.198] (dhcp-100-3-198.bos.redhat.com [10.16.3.198])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mAPFK4RN011751;
	Tue, 25 Nov 2008 10:20:06 -0500
In-Reply-To: <491DE6CC.6060201@op5.se>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101664>

On Fri, 2008-11-14 at 21:59 +0100, Andreas Ericsson wrote:
> I've been working quite a lot on git -> libgit2 code moving,
> but the licensing stuff is a bit depressing, as I can't know
> if the work I'm doing is for nothing or not.
> 
> The license decided for libgit2 is "GPL with gcc exception".
> Those who are OK with relicensing their contributions under
> that license for the purpose of libgit2, can you please say
> so?
> 
> I'm planning on writing a tool for this that will have "ok",
> "not ok" and "ask-each-patch" as options.
> 
> The list of people whose position I know is rather short.
> Please correct me if you're on it and would like not to be.
> Junio C. Hamano		ask
> Johannes Schindelin	ok
> Shawn O. Pearce		ok
> Andreas Ericsson	ok
> Pierre Habouzit		ok
> Brian Gernhardt		ok
> 
> 
> I've put everyone who "owns" more than 500 lines of code
> on the bcc list, figuring your permission is important
> but that you don't want the hundreds (well, one can hope)
> of emails from people saying "ok". The list of major owners
> was generated with "git showners *.c" in a worktree from
> the next branch of git.git.

You're welcome to use any of the code I've written under the GPL +
exception license, though most of it is probably not that useful, as
it's mostly porting shell commands to builtins.  I'm very happy to see
this effort start up, as I've been tempted to do something similar
myself :)

cheers,
Kristian
