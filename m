From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 19:07:07 +0100
Message-ID: <80skfn4r04.fsf@tiny.isode.net>
References: <4a8c373f@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ib@wupperonline.de (Ingo Brueckl)
X-From: git-owner@vger.kernel.org Wed Aug 19 20:07:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdpZD-0006hw-7m
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 20:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbZHSSHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 14:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbZHSSHJ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 14:07:09 -0400
Received: from rufus.isode.com ([62.3.217.251]:56405 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbZHSSHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 14:07:08 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <Sow=SwB9YYR2@rufus.isode.com>; Wed, 19 Aug 2009 19:07:07 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 19 Aug 2009 19:07:07 +0100
X-Hashcash: 1:20:090819:ib@wupperonline.de::aoZ7AP9jNitQoIJ/:00000000000000000000000000000000000000000001PIn
X-Hashcash: 1:20:090819:git@vger.kernel.org::H3PIEVelNlUQdisw:0000000000000000000000000000000000000000001Vd8
In-Reply-To: <4a8c373f@wupperonline.de> (Ingo Brueckl's message of "Wed, 19
	Aug 2009 19:33:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126569>

ib@wupperonline.de (Ingo Brueckl) writes:

> I'm a git novice and have a comprehension question concerning branches.
>
> Within a git repository, I do:
>
>   git branch test
>   git checkout test
>   # edit foo.bar
>   git checkout master
>
> I'd expect that master is in the exactly same unchanged state it was at
> branching time, but what a surprise, foo.bar is modified here, too!

You didn't commit your change to foo.bar.

[...]

> What must I do to get a test branch I can't work without affecting master?

commit changes.
