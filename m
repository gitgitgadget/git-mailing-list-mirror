From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 16:24:35 +0200
Message-ID: <86bqbsta3g.fsf@lola.quinscape.zz>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz> <7vhcllc9bz.fsf@gitster.siamese.dyndns.org> <85ps08k2fj.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 16:36:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZp2r-0006co-QI
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 16:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055AbXIXOgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 10:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXIXOgN
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 10:36:13 -0400
Received: from main.gmane.org ([80.91.229.2]:60107 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbXIXOgM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 10:36:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IZozA-0005nD-UH
	for git@vger.kernel.org; Mon, 24 Sep 2007 14:32:32 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 14:32:32 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 14:32:32 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:n+/BXzO8z9NAcM0wo+xC6FPZnRk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59054>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Well, as we all know that we disagree on this point, stating what
>> you consider one-sidedly here is quite inappropriate.
>
> Hm.  If I create a patch after you basically said "go ahead, I don't
> mind, but I consider it unimportant", how am I going to put the
> motivation for the patch in the commit message while expressing
> _your_ opinion?  I thought that using "I" to make clear that it is
> my personal view would be doing that.
>
> So what am I supposed to write instead?
>
> "There is no good reason for this patch, but we might as well do
> it."?

[...]

>> In other words, I am somewhat disgusted with the first part of
>> your proposed commit log message, although I like what the patch
>> does ;-).
>
> Could you propose a commit message that would be acceptable to you,
> yet not make it appear like a mistake to actually commit the patch?
>
>>> -while case "$#" in 0) break ;; esac
>>> +while test "$#" != 0
>>>  do
>>>      case "$1" in
>>>      -a)
>>
>> And let's not quote "$#".
>
> I kept this as it was originally.  Some authors prefer to quote
> every shell variable as a rule in order to avoid stupid syntactic
> things happening.  Of course, $# never needs quoting, but I did not
> want to change the personal style of the respective authors.  I can
> make this consistent if you want to.

It seems like the window of opportunity to fix the objectable commit
message has closed for me, as well as doing the work of removing the
"$#" (which you did already): I find that the patch has already made
it into upstream.

I am somewhat taken aback that a commit message considered offensive
(though I still have a problem understanding why and certainly did not
intend this) has been committed into master without giving me a chance
to amend it.

Unfortunately, the ensuing discussion around the _technical_ merits is
somewhat lopsided since Dscho keeps me in his killfile, and so the
commit message in the repository is all he'll ever be able to see from
me concerning this matter.

Which makes it more unfortunate that I have not been able to amend it.

Too bad.

-- 
David Kastrup
