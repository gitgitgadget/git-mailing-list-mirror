From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 19:17:16 +0200
Message-ID: <86mywjcwv7.fsf@lola.quinscape.zz>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 19:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INtq4-0006ht-JF
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 19:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765653AbXHVRRg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 13:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765647AbXHVRRg
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 13:17:36 -0400
Received: from main.gmane.org ([80.91.229.2]:55891 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765632AbXHVRRe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 13:17:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INtpe-0006B0-TK
	for git@vger.kernel.org; Wed, 22 Aug 2007 19:17:26 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 19:17:26 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 19:17:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:mdgB5SRajczTF7WXH4YcbKl6MTE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56402>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 22 Aug 2007, Nicolas Pitre wrote:
>
>> On Wed, 22 Aug 2007, David Kastrup wrote:
>> 
>> > Personally, I would prefer an approach of using an embedded script 
>> > interpreter: then language incompatibilities become a non-issue. 
>> > git-busybox sounded like a great idea for portability.
>> 
>> Indeed.  And while the conversion of some script into C was the right 
>> thing to do performance wise, many other scripts are hardly performance 
>> critical.
>
> What is wrong with going from shell to C?

That it is not a script language where cause and effect of tying
simple functionality together is apparent, and easy to do.

> C _is_ portable.  Instead of relying on _yet_ another scripting
> language, introducing _yet_ another language that people have to
> learn to hack git, introducing _yet_ another place for bugs to hide,
> why not just admit that shell is nice for _prototyping_?

git-busybox would not be "yet another scripting language" that would
need an introduction.

Emacs did not become one of the most used editors by chance: it is
exactly _because_ its scripting language Emacs Lisp is good for
prototyping, and the prototypes can be _retained_ and improved.

Once development is dead, the need for prototyping stops.

>> > If the scripting engine of choice for cobbling together
>> > prototypes remains the Unix toolchain outside of git proper, then
>> > Windows users will _always_ remain second class citizens since
>> > they will get to work with and on new porcelain much later than
>> > the rest of the world: namely when somebody bothers porting his
>> > new favorite tool for them to C.
>> 
>> Right.
>
> And not making the scripts builtins helps Windows users how,
> exactly?

Red herring.  The proposal was not to do nothing, but rather give git
a dedicated scripting language internal to it.  Two suggestions of
mine with different advantages were git-busybox and Lua.  A third one
was once proposed by Linus with some code example: starting a
scripting language from scratch.  So obviously, the need for something
like that is recognized, and not having to start from zero for that
might be an advantage if a good, workable language can be found.

You could better address my points if you did not keep me in your
killfile.

-- 
David Kastrup
