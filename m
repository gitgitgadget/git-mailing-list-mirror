From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 22:34:24 +0100
Message-ID: <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
	 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
	 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	 <Pine.LNX.4.64.0708221713540.20400@racer.site>
	 <86mywjcwv7.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 23:34:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INxqQ-0007aH-Kk
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 23:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764109AbXHVVe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763711AbXHVVe1
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 17:34:27 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:15880 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763556AbXHVVeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 17:34:25 -0400
Received: by rv-out-0910.google.com with SMTP id k20so321572rvb
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 14:34:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KxvZXmYcldbfRid8hUssx4stUdlIMSBdx7nqXq46NFPALIH4F5c1St4dVYa5tebakXC9RvtyYoqPuLmjW9dEy8ekhhzJEoGbGNZO9zFsyrAaCQbkQh4nfAHiJYhwj9ubwPIgNK+vFuEaSNhib3APK05NYs9G0zhKOj1wM4zT7FI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rcUGZgGo2cG3iXLIcxkZcVi6CqSPBgv8VN+XocHvWOVwV2clg4mNF/bBpj5wYavvk4ovlHYqIS/BDbVzGXtXELYyZ5bPiQbpkibDhhis6mDxPN1cCy5sRjZsmne8UjJxtENJbxDhY5f5QGK3z1mIZ0n6rOw0pLSvYoqirXUOlHc=
Received: by 10.141.85.13 with SMTP id n13mr530693rvl.1187818464718;
        Wed, 22 Aug 2007 14:34:24 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Wed, 22 Aug 2007 14:34:24 -0700 (PDT)
In-Reply-To: <86mywjcwv7.fsf@lola.quinscape.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56423>

On 22/08/07, David Kastrup <dak@gnu.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Wed, 22 Aug 2007, Nicolas Pitre wrote:
> >
> >> On Wed, 22 Aug 2007, David Kastrup wrote:
> >> > If the scripting engine of choice for cobbling together
> >> > prototypes remains the Unix toolchain outside of git proper, then
> >> > Windows users will _always_ remain second class citizens since
> >> > they will get to work with and on new porcelain much later than
> >> > the rest of the world: namely when somebody bothers porting his
> >> > new favorite tool for them to C.
> >>
> >> Right.
> >
> > And not making the scripts builtins helps Windows users how,
> > exactly?
>
> Red herring.  The proposal was not to do nothing, but rather give git
> a dedicated scripting language internal to it.

That is a really neat idea.

> Two suggestions of
> mine with different advantages were git-busybox and Lua.  A third one
> was once proposed by Linus with some code example: starting a
> scripting language from scratch.

Do you have a link to the proposal?

> So obviously, the need for something
> like that is recognized, and not having to start from zero for that
> might be an advantage if a good, workable language can be found.

It would also aid the Windows porting effort by having a single,
builtin scripting engine that does not have differing behaviours on
different platforms.

One thing that will need sorting is the binding of the C
plumbing/builtin command API to the scripting language, but this
shouldn't be that difficult to do.

- Reece
