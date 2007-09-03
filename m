From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Mon, 03 Sep 2007 13:32:07 +0200
Message-ID: <86y7fohtmw.fsf@lola.quinscape.zz>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709022133190.28586@racer.site> <200709022342.42733.robin.rosenberg.lists@dewire.com> <46DBB2BE.8030505@eudaptics.com> <20070903112110.GE14853@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 13:32:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISAAI-0007Na-QB
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 13:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887AbXICLcU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 07:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756808AbXICLcU
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 07:32:20 -0400
Received: from main.gmane.org ([80.91.229.2]:53735 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756771AbXICLcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 07:32:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISAAD-0007s4-Oo
	for git@vger.kernel.org; Mon, 03 Sep 2007 13:32:17 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 13:32:17 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 13:32:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:V36glxkCqSFtAAKL+5CO4IllfNY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57469>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Mon, Sep 03, 2007 at 09:07:42AM +0200, Johannes Sixt <j.sixt@eudaptics.com> wrote:
>> >$ ls -ld x y
>> >lrwxrwxrwx 1 me me     8 sep  2 23:36 x -> Makefile
>> >-rw-r--r-- 1 me me 32164 sep  2 23:36 y
>
>> And if I understand the documentation correctly, then
>
>> $ mkdir foo && cd foo
>> $ cat ../x
>> x: No such file or directory
>
>> Right?
>
> correct.

Have you tested this, or is this from reading the documentation?  In
either case: brilliant, but the former would be funnier (depending on
one's sense of humor, of course).

-- 
David Kastrup
