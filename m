From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Fri, 6 May 2011 09:51:17 +1000
Message-ID: <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
	<BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
	<4DB9329E.7000703@op5.se>
	<88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
	<7vhb986chl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:51:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI8KJ-0003u6-J0
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 01:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287Ab1EEXvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 19:51:19 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59152 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab1EEXvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 19:51:18 -0400
Received: by vxi39 with SMTP id 39so2814649vxi.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 16:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=4ktmU9HMnSVBLqZ9XLK4j+2Di0kL64MoqSXjqrHMgTw=;
        b=GzpuSYq8hEt8AytDg1vTlD8yUD6qijKaXR3ZBoRwh/6nxewdXMe4UWlTXvjjoUY4A3
         Zo/53Wci2e4ZfvMdqkOVqId+WpYOOEfdq1O13iIqln5zSWmM7tIHukLprAIyEQI67IfB
         8zewhRIPXSZbZ5kEOBwuMFON/M1NC3/jAh93Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=G/Ucpau/P/uTcRDsvdMtbzTYfBzsi8ZtmLPeEqJDFsuWscVfgZeNelE6tQZLvd9n7K
         lDhrvusD4Zt+ulFjnZwFFu9XwpTBeOTzo3j18C6h3QEyiOTzmPkhhO+mr8KjgLZIXlyH
         PYhsBAqOMY5Bt97rbcXCK4+LOCcI8dkHal7dg=
Received: by 10.52.177.106 with SMTP id cp10mr3759397vdc.199.1304639477160;
 Thu, 05 May 2011 16:51:17 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Thu, 5 May 2011 16:51:17 -0700 (PDT)
In-Reply-To: <7vhb986chl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172929>

| Junio: apologies, reply missed list. Edited slightly.

On Fri, May 6, 2011 at 7:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> On Apr 28, 2011, at 3:56 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
>>
>>> What is so hard about the concept of an application providing a
>>> facility that allows it to request, merely request, the installation
>>> of a plugin for itself by what ever happens to be the users choice of
>>> package manager or distribution.
>>
>> It's not hard.  We simply don't need it.
>>
>> Why do I need to activate my "plugin"?  That seems like a needless
>> feature. If I don't want "git gui" I apt-get uninstall git-gui.
>
> I mostly agree with you that what Jon has wrote so far is overengineering
> to solve a problem that does not exist [*1*].
>

I do accept that the consensus of the list is that any kind of package
or plugin management is over-engineering.

> But here is one thought.
>
> Imagine this "git gui" is not "git gui" but "git superadd" package that
> changes the behaviour of "git add" slightly.
>
>    Side note: Of course, for this kind of usage, the "git potty" needs to
>    be extended to look for things in different places, and also it needs
>    to be made easy for the implementation of "superadd" to call the
>    underlying "git add", bypassing itself, when necessary.
>
> You do not want that new interface, you are old timer and you like the old
> way of doing things like me ;-).  But your wife wants to use it.  You two
> share a computer.
>
> Do you or do you not run "apt-get install git-superadd"?
>
> One possible answer may be to run "apt-get install git-superadd", and then
> the users who want "git add" to behave in a new way to opt-in to use the
> "plug-in".  I think that is what Jon is getting at.
>

Yes, the basic premise is that an author of a git extension, which
depends only on git, should be able to provide an extension in a form
that allows others to drop the extension onto a system, knowing only
that the system has git installed.

The extension author should not need to know about how to build an
apt-get, yum, cygwin or brew package or too much about how to install
into a git installation that wasn't installed by a distro. Why should
they? Their dependency is simply git.

It would be good if something like:

    unzip -d $(git --plugins-dir) foobar.zip

installed scripts, info files and man pages into a place where git
would find them and then have git foobar start working without any
additional effort by the package author or user.

I accept that anything more sophisticated than "drop and go" style
deployment of extensions (e.g. plugin management) is overkill, given
that the current market for git extensions is miniscule. That said, I
would like to get the basic extension mechanism right so that if the
"market" for git plugins ever became wildly successful, then at least
we could implement more sophisticated plugin management if we wanted
to.

This was the point of the other thread: "RFC: a minimal plugin
architecture" where I tried to elicit feedback about what an minimal
solution would look like, sans my more elaborate visions.

http://permalink.gmane.org/gmane.comp.version-control.git/172419

>
> [Footnote]
>
> *1* I admit that I didn't read all of them carefully, as I was repelled by
> them as soon as I saw phrases like "for people who can grok this concept".

Junio: at least quote me accurately. I actually wrote:

"Contributors who grok the concept as I conceive it are welcome to
submit pull requests."

I am a little mystified why use of the word "grok" in this way, given the
circumstances, caused you to be "repelled".
