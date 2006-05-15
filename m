From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add "--branches", "--tags" and "--remotes" options to git-rev-parse.
Date: Mon, 15 May 2006 22:11:17 +0200
Organization: At home
Message-ID: <e4an8j$cti$1@sea.gmane.org>
References: <BAYC1-PASMTP0299DC98A51B55188BDF96AEAD0@CEZ.ICE> <7vd5ehu8og.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP043948149786B7EE06DED3AEA20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 15 22:12:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfjQ8-0002GV-FM
	for gcvg-git@gmane.org; Mon, 15 May 2006 22:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWEOULw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 16:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbWEOULw
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 16:11:52 -0400
Received: from main.gmane.org ([80.91.229.2]:35772 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965213AbWEOULv (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 16:11:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FfjPj-0002CI-Ct
	for git@vger.kernel.org; Mon, 15 May 2006 22:11:35 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 May 2006 22:11:35 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 May 2006 22:11:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20080>

Sean Estabrooks wrote:

> On Sat, 13 May 2006 10:38:23 -0700
> Junio C Hamano <junkio@cox.net> wrote:
> 
>> Makes sense perhaps.
>> 
>> I understand you added --tags for completeness.  Probably it
>> would make sense to add --remotes if you are shooting for that.
[...]

> +--remotes::
> +     Show tag refs found in `$GIT_DIR/refs/remotes`.
> +

In `Documentation/repository-layout.txt' there is information about
`$GIT_DIR/remotes' not `$GIT_DIR/refs/remotes` so either the patch should
be amended, or the layout documentation should be updated, or the layout
repository should be changed.

-- 
Jakub Narebski
Warsaw, Poland
