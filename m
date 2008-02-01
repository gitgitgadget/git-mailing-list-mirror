From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation/git-stash.txt: Adjust SYNOPSIS command syntaxes
Date: Fri, 01 Feb 2008 05:35:01 -0800 (PST)
Message-ID: <m33asc94xn.fsf@localhost.localdomain>
References: <7ihp802o.fsf@blue.sea.net> <m37iho9b70.fsf@localhost.localdomain>
	<1w7w966m.fsf@blue.sea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 14:35:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKw3R-0007FV-4S
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 14:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbYBANfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 08:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756961AbYBANfI
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 08:35:08 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:52148 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbYBANfE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 08:35:04 -0500
Received: by py-out-1112.google.com with SMTP id u52so1621875pyb.10
        for <git@vger.kernel.org>; Fri, 01 Feb 2008 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=Zmce71yYEQfJNKzcEVqxvnOd12Cyw77YnJ8oaVnKVsw=;
        b=IWbCAb5CyaSaGQfHwJ1GdSnBY+DtgHhHEiRtEoHl/Z6QarStV03mKK4gaCqaUfVCswKe1eVv1viJgGYvuBsfaOTHg8Un9m9uPjBI3cdJCkY0MxdfKDhO0anDf3yfseq9W29JOLwL8fCELebpOFhUXDQz9C1edJS13md68kMaJOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=jDvOeahnWi3Mu6lP6TcK128cSPp3Y0RK/22tqRadU+sCEvNst31sQ4/MGyiaLrFo5O7dBhBsAAvk2bQSlNQ7wXvpjZgXlqNjQDJdzbcccK3FGhlFNnw8aB1xiMcCYNUA7nZEVVe2ZMelQUAjiO4eIBWCBCDJknUZllCpe/h6dQk=
Received: by 10.141.69.1 with SMTP id w1mr2482607rvk.147.1201872903330;
        Fri, 01 Feb 2008 05:35:03 -0800 (PST)
Received: from localhost.localdomain ( [83.8.248.93])
        by mx.google.com with ESMTPS id i8sm8623552nfh.1.2008.02.01.05.35.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Feb 2008 05:35:01 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m11DYI7m017518;
	Fri, 1 Feb 2008 14:34:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m11DXvRi017510;
	Fri, 1 Feb 2008 14:33:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <1w7w966m.fsf@blue.sea.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72174>

Jari Aalto <jari.aalto@cante.net> writes:

> * Fri 2008-02-01 Jakub Narebski <jnareb@gmail.com>
> * Message-Id: m37iho9b70.fsf@localhost.localdomain
> >
> >
> > 'git-stash' (list | show [<stash>] | apply [<stash>] | clear)
> > 'git-stash' [save [<message>...]]
> >
> > Angle brackets if I understand correctly are meant to denote part
> > which you have to enter, the user supplied info (the reast ou have to
> > enter literally).
> 
> Nowhere I have seen "(" parenheses to mean "required". 

The "(" parentheses does not mean "required". They do mean "group",
just like for regular expressions. So "A (B | C)" means "A B" or
"A C".

> The angle brackets are commonly used to tell that the part is to be
> required:
> 
>     command <option> <file ...>
> 
> Reads:
> 
>     command -l file.txt

No, the "<" angle brackets are meant to denote: substitute your own
(user) input, and not use as literal value. So "command <option>"
mean select one of options ant put it in place of "<option>"

> Whereas this has no known meaning:
> 
>     command (option) <file ...>

It doesn't have meaning if there is no alternative in "("
parentheses. So it makes sense to use:

      command (subcmd1 | subcmd2) <file ...>

but not

      command (option) <file ...>

> But this does:
> 
>     command [option] <file ...>

The "[" brackets mean both "optional" and "group" (to reduce number of
parentheses-like operators).
 
> That's why I suggested to use:
> 
>     git stash <list | show [<stash>] | apply [<stash>] | clear>
>     git stash [save [<message>...]]

I hope that I have explained above why I think it is wrong. IMHO the
"<" angle brackets mean: substitute your own input, and are not meant
for grouping (limiting where alternates start and where end).

> NOTE:
> 
> There exists curly braces notation that is sometimes used for
> "required" part, but that not very common elsewhere other than
> printed books from commercial vendors.
> 
>     command {one|two|three}
> 
> I would hesitate to select parentheses notation, which is relatively unknown
> to mean "required" in the context of command syntax SYNOPSIS.

Lack of "[" brackets means required.


By the way, is the format used by SYNOPSIS in manpages somewhere
specified, for example in some RFC, like BNF notation and BNF-like
notation used by RFCs is?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
