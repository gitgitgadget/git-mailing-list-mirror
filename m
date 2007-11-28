From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 10:13:13 -0500
Message-ID: <9e4733910711280713n6b439866m55bea4824efd959@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	 <20071128092234.GA12977@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:13:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxObW-0002YC-2G
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704AbXK1PNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 10:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756643AbXK1PNP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:13:15 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:35882 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756627AbXK1PNO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 10:13:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1765386wah
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 07:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=V2AawclQMgxdR35GonSMQ4NUfwLm7RjzQnfT2BWQ984=;
        b=gH0TW9j0WbyvUBuObuRDYXFNeDTDihB9SUmzbP2qyXKJdH/6qSZmkLKjhQNbeMC/t8AP1FkVQZ3jPc7n7y7TBnE7eqyxDYji83UykAaOFXrts4HEk7K48VWr1ZPTi70E4LIxb1KrJLbLE1fBZYu8pC4pV2ME9yXTvANrGnWXBkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cYxQtCcMChUPUVvW/Aqb3ivoQoembUF9HbKs9QD9r9LNVVf4h3SvAyA8CWkqLo951MCAsh/sfYGtLknOYCVfoDPOmnxIniFhDWbz2EsDxvGzeqCB3vo6ZIAOY80J8qkk4xDOEx7HhsTJPAyCh/osSo+m8zh0EL+NHgygP7XJLOQ=
Received: by 10.114.127.1 with SMTP id z1mr518516wac.1196262793447;
        Wed, 28 Nov 2007 07:13:13 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 07:13:13 -0800 (PST)
In-Reply-To: <20071128092234.GA12977@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66354>

On 11/28/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-11-27 20:33:27 -0500, Jon Smirl wrote:
>
> > Let's take my recent problem as an example. I typed 'git rebase
> > linus/master' instead of 'stg rebase linus/master'. Then I typed
> > 'stg repair'. The repair failed and left me in a mess. Both of thes=
e
> > are easy to rollback except for the fact that stg has stored a bunc=
h
> > of state in .git/*.
> >
> > After doing the commands I located my last commit before the rebase
> > and edited master back to it. But my system was still messed up
> > since moving master got me out of sync with the state stg stored in
> > .git/*. The 'stg repair' command had changed the stored state.
>
> How exactly did repair mess up? Did it crash, produce a broken result=
,
> an unreasonable but technically valid result, or just not the result
> you wanted?

all my patches applied
git rebase
cursing.... I immediately knew what I had done
update stg and install it
stg repair
four of my 15 patches tried to apply, I received messages that there
were all empty
most stg commands won't work, they complain that the commit references
in the stg .git/* state are not correct.

I then proceed to manually attempt repair.


>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
