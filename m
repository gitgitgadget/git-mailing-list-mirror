From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 17:52:38 -0700
Message-ID: <56b7f5510705041752o74b59284x872480e4413f83ab@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com>
	 <463AFAAE.853DEF7B@eudaptics.com>
	 <7vabwktsng.fsf@assigned-by-dhcp.cox.net> <f1gg1o$p52$2@sea.gmane.org>
	 <7vy7k4p24s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 02:52:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk8W3-0001Fk-Pl
	for gcvg-git@gmane.org; Sat, 05 May 2007 02:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423711AbXEEAwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 20:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423712AbXEEAwt
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 20:52:49 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:36988 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423711AbXEEAws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 20:52:48 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1079023wra
        for <git@vger.kernel.org>; Fri, 04 May 2007 17:52:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T1GUhTfl66hQlISOus8AtKZMrXgL2l16/MZuZFJqwyVwbqz8UwL0W4kprjCw9rhCJtUdRqFrqrPKpUQeMLTifyJev9NqX3JV0BOGR7d1xbqvA3sIaBh9pa3uN2CPF/DwNsTdUgqoNE20Z+mCvz3sT3b5PjYubiHd6ybb5SMCUok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lI6oK6o6Uueb1lYJ0yKgkgixm0J3RQ/KMUifYWJuJfKYSfi1wEAqQoyp6HCrfFsBqgoGauBjFpWA6iQAjGcU/8E445/S+NIwCGsQQeC/X9gP58M9zBGPlKYNU6likKc4lsnHxQpi2Boix/aeII15eoTgFI8skjhsLyqKfKtcREI=
Received: by 10.114.53.1 with SMTP id b1mr1317700waa.1178326364044;
        Fri, 04 May 2007 17:52:44 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 17:52:38 -0700 (PDT)
In-Reply-To: <7vy7k4p24s.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46233>

On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > I'm not sure about "<tree-ish>:<path>" with <path> being relative by
> > default. For me it is <path> in <tree-ish> (like in
> > "git-ls-tree -r <tree-ish>" result).
>
> That's right (and Dscho is also).
>
> "v1.5.1:git.c" IS "git.c that appears at the toplevel of
> v1.5.1's tree."
>
> Ok, for now let's forget about this relative stuff.

Hmm, most of the work I do in the parts of our
perforce repository I want to convert to git is
far enough down that the paths have 6 in-repo path components.
I don't want to type all those when I want to fetch an
older version with git-show.  Everything I do is relative.
In fact,  I think perforce supports typing absolute paths,
(using an 8-character prefix!) but I have never used it,
nor would I if it were shorter.
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
