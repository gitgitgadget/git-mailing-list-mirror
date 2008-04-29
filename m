From: "Geoffrey Irving" <irving@naml.us>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 13:31:51 -0700
Message-ID: <7f9d599f0804291331v2f44bee1y29c1580d68a3107a@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se>
	 <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
	 <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
	 <alpine.LFD.1.10.0804291232130.23581@xanadu.home>
	 <7f9d599f0804291048n2c706f3amdf159ffe86bdbc8@mail.gmail.com>
	 <alpine.LFD.1.10.0804291352120.23581@xanadu.home>
	 <7f9d599f0804291102j4a30c344h18d12d03a6d5953b@mail.gmail.com>
	 <alpine.LNX.1.00.0804291410340.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Andreas Ericsson" <ae@op5.se>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Henrik Austad" <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 22:32:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqwVG-0002fj-RS
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 22:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455AbYD2Uby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 16:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753454AbYD2Ubx
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 16:31:53 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:33499 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbYD2Ubw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 16:31:52 -0400
Received: by py-out-1112.google.com with SMTP id u52so281195pyb.10
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=848EqKoJDPjUjNQbojOvB6lwgscD3seM4cozkfDQ+cY=;
        b=QB5dPUfhZmYvN6Y/BD8NKUd/4v3LjDpPtX3Qwf+yFjIqPGkxIyeOOrPwc4z7RdWB24her20Ciq0fFRJqKiOLkFVhvG1ULB/IKc1IDVfw3rHWJAwcxxDZgkcYmjbYZXndPZ3vEgREp+at4dI76yHPLttzXLAjoi9f6EwcoReVTXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=h+JhQnRV+7s4yxzL3WRo9Z//UdOw+wnueLvUmHQlXxk6BloRdUoNH6rtqodBYeuz7JAmfmIAVZy8xXQFWNa+elLBcJ7aMzzS9YcfTbNUG4oX22Lv0Rd6ejuKUP3RKCcAo+kPzoXWZH9mxRNebhBP2iMMYRy9DyU/YdGYmWaaIvE=
Received: by 10.141.89.13 with SMTP id r13mr3471350rvl.177.1209501111327;
        Tue, 29 Apr 2008 13:31:51 -0700 (PDT)
Received: by 10.140.178.16 with HTTP; Tue, 29 Apr 2008 13:31:51 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0804291410340.19665@iabervon.org>
Content-Disposition: inline
X-Google-Sender-Auth: 75a91a08b5ee8f22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80727>

On Tue, Apr 29, 2008 at 11:41 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 29 Apr 2008, Geoffrey Irving wrote:
>
>  > On Tue, Apr 29, 2008 at 10:55 AM, Nicolas Pitre <nico@cam.org> wrote:
>  > > On Tue, 29 Apr 2008, Geoffrey Irving wrote:
>  > >
>  > >
>  > > > Sorry for the confusion: it would handwaving if I was saying git was insecure,
>  > >  > but I'm not.  I'm saying that if or when SHA1 becomes vulnerable to collision
>  > >  > attacks, git will be insecure.
>  > >
>  > >  Right.  And if or when that happens then we'll make Git secure again
>  > >  with a different hash.  In the mean time there is low return for the
>  > >  effort involved.
>  >
>  > Yes.  I wasn't trying to advocate switching, just making sure people
>  > know that the "collisions don't matter" argument is bogus.
>
>  It's bogus to say they completely don't matter, but I still claim that
>  they don't matter for the things people actually care about. If people can
>  generate collisions, they can commit a "weak" blob with a conditional that
>  can be switched by replacing the blob. But it's almost always true that
>  people could commit a blob with a conditional that can be switched by
>  something else under the attacker's more direct control. Using a better
>  hash function won't save you from a document like:
>
>  if (getdate() < 2009)
>   render_good_text
>  else
>   render_evil_text
>
>  even if it does help with:
>
>  if (AA == AA)
>   render_good_text
>  else
>   render_evil_text
>
>  If you're not checking your files for the former, you shouldn't worry
>  about the latter, because the former is much easier and more subtle.

I sincerely hope that pdf/postscript don't allow the internal
rendering code to branch based on the current date.  That would be an
absurd security hole, and would indeed make you entirely correct.  If
you actually know that it is possible to write that in postscript, I
would very much want to see an example.

In any case, in a binary document format that isn't insane (examples
of these at least include black and white .png images of documents), a
visual check of the content is sufficient to ensure that the next
person who looks at it will see roughly the same visual content.  Git
should be (and currently is) a secure method of transferring sane
binary documents.

Geoffrey
