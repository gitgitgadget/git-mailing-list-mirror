From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Some ideas for StGIT
Date: Thu, 23 Aug 2007 15:09:48 +0100
Message-ID: <b0943d9e0708230709o6ae16d5dvcfeba2f344f57fa5@mail.gmail.com>
References: <1186163410.26110.55.camel@dv>
	 <b0943d9e0708060236x19674e4cjf04cec716ae6246c@mail.gmail.com>
	 <20070806095623.GA23349@diana.vm.bytemark.co.uk>
	 <1186404125.10627.30.camel@dv>
	 <20070806135204.GC23349@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pavel Roskin" <proski@gnu.org>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 16:09:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IODNi-0006TM-Hc
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 16:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758721AbXHWOJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 23 Aug 2007 10:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758709AbXHWOJv
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 10:09:51 -0400
Received: from ik-out-1112.google.com ([66.249.90.181]:7778 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758526AbXHWOJu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 10:09:50 -0400
Received: by ik-out-1112.google.com with SMTP id b32so186341ika
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 07:09:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rlRkdFlpzX7muMnGKigq+zAnO597HuKShAFbKwQNl8HGC65LBtLZU7IxUjpLHMPG4WKN8DiYVSsD6n6fBvnsp08oKy7Pd+PvDU8ka+dAAFNJN+Rn56iO5rqoPKUlBs+9lvCKjOhgYJ4dHuyuoN8Tk4Rm8FXXe1E/lkahKVe61P4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W3TV0Uy1UvwHvunrTdZOKcNKQUzrXOhRyjI8Nm16my+4E7XKAS6KLhzJ1PN1mzKd4NN7ZvOj8FtxaeWuoyrCxMfjMb+HCM6Y8G77188feGhYhgdraUEj8e842CDiKC6Sy5/xh7UKTqgL2QmoLJiyXB+wQ5dNlIv6nwUm62q0j/U=
Received: by 10.78.193.19 with SMTP id q19mr1223503huf.1187878188128;
        Thu, 23 Aug 2007 07:09:48 -0700 (PDT)
Received: by 10.78.151.11 with HTTP; Thu, 23 Aug 2007 07:09:47 -0700 (PDT)
In-Reply-To: <20070806135204.GC23349@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56501>

(cleaning up my inbox after holiday, so my replies might look random)

On 06/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-08-06 08:42:05 -0400, Pavel Roskin wrote:
> > Purely from the code standpoint, yes, it should be a separate
> > command. But it may be practical to have both in one command, since
> > I commonly need to change the description after changing the code.
>
> Sure. I don't have any objection to making
>
>   stg refresh -e
>
> be equivalent to
>
>   stg refresh && stg edit-patch-message <topmost-patch>

The only objection is the long command name - 'stg edit [<patch>]'
would be just fine. It would also be nice to do (with an additional
option), the equivalent of export - edit - import in case one wants to
also modify the diff.

> What I'm objecting to is being forced to refresh when I just want to
> edit the message. (And, to a lesser degree, having to manually push
> and pop to make the patch topmost before I can edit its message.)

Not necessarily - 'stg refresh -e -p <patch>' does the pop/push for
you and it even uses the fast-forwarding.

--=20
Catalin
