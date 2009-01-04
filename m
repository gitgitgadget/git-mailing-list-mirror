From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH next] git-cherry usage: correct nesting of commit-ish options
Date: Sun, 4 Jan 2009 19:01:18 +0100
Message-ID: <200901041901.18801.markus.heidelberg@web.de>
References: <200901041711.23026.markus.heidelberg@web.de> <20090104173559.GG21154@genesis.frugalware.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jan 04 19:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJXIj-0006rr-R8
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 19:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbZADSAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 13:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbZADSAv
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 13:00:51 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:41108 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbZADSAv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 13:00:51 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 15B31FB62870;
	Sun,  4 Jan 2009 19:00:49 +0100 (CET)
Received: from [89.59.126.169] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #273)
	id 1LJXHM-0005HU-00; Sun, 04 Jan 2009 19:00:48 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090104173559.GG21154@genesis.frugalware.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/Z2ffOp/rkNJSPAip7x6u/+U4L7h6DT96IsOmm
	FoI0B6vEr17Jb80D926rT+Uz8p+Uy6CN26LnGeOu5K6+mxZYt2
	+0RWIv1zxNQEMTBi/hDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104530>

Miklos Vajna, 04.01.2009:
> On Sun, Jan 04, 2009 at 05:11:22PM +0100, Markus Heidelberg <markus.heidelberg@web.de> wrote:
> > Another question: should this patch be split up into two, one for
> > maint/master and another for next?
> 
> AFAIK sending patches against next is not preferred at all.

>From Documentation/SubmittingPatches:

    If you are preparing a work based on "next" branch,
    that is fine, but please mark it as such.

I guess the only reason is a required dependency not available in
'master'.

> You should
> send your patches against master, or - if you have a strong reason - on
> top of a given topic branch.

This patch depends on a commit in 'next'. But right, I could have
mentioned that it's against 'mh/cherry-default' as Junio suggested a few
days ago.
