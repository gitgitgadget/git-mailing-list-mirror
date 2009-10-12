From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git refuses to work with gvim
Date: Mon, 12 Oct 2009 19:37:23 +0200
Message-ID: <200910121937.24376.markus.heidelberg@web.de>
References: <20091012134312.236d250e@gzip.coli.uni-saarland.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: sebastian@coli.uni-sb.de
X-From: git-owner@vger.kernel.org Mon Oct 12 19:44:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxOwi-000059-Jl
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 19:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbZJLRlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 13:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbZJLRlH
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 13:41:07 -0400
Received: from [217.72.192.227] ([217.72.192.227]:38387 "EHLO
	fmmailgate02.web.de" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932613AbZJLRlG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 13:41:06 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 8F0C912EACFB4;
	Mon, 12 Oct 2009 19:38:50 +0200 (CEST)
Received: from [89.59.75.30] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1MxOpV-0002bh-00; Mon, 12 Oct 2009 19:37:06 +0200
User-Agent: KMail/1.9.10
In-Reply-To: <20091012134312.236d250e@gzip.coli.uni-saarland.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Provags-ID: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130037>

sebastian@coli.uni-sb.de, 12.10.2009:
> Hi,
> a few days ago I decided to switch from vim to gvim. To make use of
> this in most cases I added :gui to my .vimrc which should make most
> applications automatically switch to use gvim if they used the vim
> command before.
> 
> But git seems to have problems with this. If I do now a "git commit
> something" not the gui is opened but the console-version of vim.

git probably calls vi and not vim. Maybe vi doesn't respect your .vimrc?

> OS: Debian Lenny

Doesn't install Debian a vim-tiny package for vi without gui and another
for vim?

Markus
