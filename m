From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git push failure in the case of SSH to localhost
Date: Wed, 11 Feb 2009 11:27:04 -0800
Message-ID: <7vd4doepvb.fsf@gitster.siamese.dyndns.org>
References: <8e04b5820902110824u1ab99cc1r4df6349b20d62f84@mail.gmail.com>
 <20090211180559.GC19749@coredump.intra.peff.net>
 <8e04b5820902111042q138a2e79vc97c533007482e5c@mail.gmail.com>
 <20090211184429.GA27896@coredump.intra.peff.net>
 <8e04b5820902111103n69cde3e1le5781fb1818b622c@mail.gmail.com>
 <20090211191445.GU30949@spearce.org>
 <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 20:29:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXKlZ-0007iE-4J
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 20:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbZBKT1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 14:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755758AbZBKT1O
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 14:27:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZBKT1N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 14:27:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B9A10985C8;
	Wed, 11 Feb 2009 14:27:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EA2A1985C6; Wed,
 11 Feb 2009 14:27:05 -0500 (EST)
In-Reply-To: <8e04b5820902111120w4cb87b41sfca647a838bab43c@mail.gmail.com>
 (Ciprian Dorin's message of "Wed, 11 Feb 2009 21:20:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB04BA24-F871-11DD-BC52-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109510>

"Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> writes:

> On Wed, Feb 11, 2009 at 9:14 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com> wrote:
>>>
>>>     Here is what I'm trying to accomplish: I want to add to the git
>>> search path also the folder ${GIT_DIR}/bin if this already exists...
>>> (This allows me to have repository specific commands...)
>>
>> for f in `cd $(git rev-parse --git-dir)/bin && ls *`; do
>>  git config alias.$f '!$(git rev-parse --git-dir)/bin/'$f
>> done
>>
>> No need to patch git.
>>
>> --
>> Shawn.
>
>     :) Yes I know about the alias trick...
>
>     But I find it easier to just create a bin folder and drop my
> scripts there... (For example git-branch-import that takes a new
> branch name and an URL and creates the branch with no ancestry and
> knows http, ftp, svn, tar.{gz,bz2}, zip, etc...)

And why isn't it in $HOME/bin/?
