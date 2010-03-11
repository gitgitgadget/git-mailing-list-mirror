From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Thu, 11 Mar 2010 08:08:04 +0100
Message-ID: <4B9896D4.2020106@viscovery.net>
References: <loom.20100310T203316-38@post.gmane.org> <7vaaugrlqs.fsf@alter.siamese.dyndns.org> <20100310200728.GD21994@spearce.org> <loom.20100310T225229-469@post.gmane.org> <20100310221228.GA4223@sigill.intra.peff.net> <20100310221403.GF21994@spearce.org> <20100310223210.GC4223@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Patrick Higgins <patrick133t@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 11 08:08:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpcVG-0002Ur-2e
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 08:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab0CKHIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 02:08:11 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33890 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab0CKHIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 02:08:10 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NpcV3-0003Ke-5M; Thu, 11 Mar 2010 08:08:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BD2151660F;
	Thu, 11 Mar 2010 08:08:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100310223210.GC4223@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141934>

Jeff King schrieb:
> On Wed, Mar 10, 2010 at 02:14:03PM -0800, Shawn O. Pearce wrote:
>> I'd say its git-gui, yes?  Doesn't my shell automatically do
>> --exclude-from=~/my.list for me?  Its not the command's job
>> to do that expansion.
> 
> It depends on the shell. Bash will expand it in _some_ cases (but not
> this one). Dash never will:
> 
>   $ echo $BASH_VERSION
>   4.1.0(1)-release
>   $ echo foo=~/foo ;# expands
>   foo=/home/peff/foo

This is wrong, FWIW. Tilde expansion must happen only at the beginning of
a word or, when in an assignment, at the beginning of the assigned value
or after any unquoted ':'. Note that in `echo foo=~/foo`, what looks like
an assignment is *not* an assignment in POSIX shell lingo because it comes
after the command name.

http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_01

-- Hannes
