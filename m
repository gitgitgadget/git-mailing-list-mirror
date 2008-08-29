From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Fri, 29 Aug 2008 17:12:58 +0300
Message-ID: <94a0d4530808290712s2044dd03pb93cb4a829dc56b0@mail.gmail.com>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
	 <1219907659.7107.230.camel@pmac.infradead.org>
	 <7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
	 <1219912327.7107.245.camel@pmac.infradead.org>
	 <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com>
	 <20080828115408.GA30834@hera.kernel.org>
	 <94a0d4530808280615i2befb89cm7d6153bfceb11b19@mail.gmail.com>
	 <94a0d4530808280634k1c23fe10q8934875c83d4a2f5@mail.gmail.com>
	 <alpine.LFD.1.10.0808280936300.3300@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Al Viro" <viro@hera.kernel.org>,
	"Matthew Wilcox" <matthew@wil.cx>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	users@kernel.org, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"David Woodhouse" <dwmw2@infradead.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 16:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ4jk-0002rA-AD
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 16:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662AbYH2OM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 10:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757650AbYH2OM7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 10:12:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:45735 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbYH2OM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 10:12:58 -0400
Received: by rv-out-0506.google.com with SMTP id k40so898933rvb.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Mi+ELf2QzQlEtuBQoktWzoK7u5dm7WGW2qioqrVuLko=;
        b=uSgytfQISD4GR6paEmGqQedAk9QpnL29pgekFhP/JWe9GbI1UVYk6fG7/x2XJQJwMJ
         uLAthrkAzZ5uyw7Zbtt5gg2njoK9SJ6x9eiZq0RaQmb1kgxEesWkm8y8sfOcZj0zr2ZF
         Z+Ehz1YQqo9by6vnS17UUbtGnhZbkbBfQMEd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ipsUZVkvJOjog+NM8EVHZH2I0p4ST7HGiCxpADYp1aPOF6OObTfRgPwfufNYYMHBl4
         owaKN1CpBnOySr2ldUSB6S9AVOIHYVV34bgOeRYaV+a/k4ZS/Pe/vOp96MhiUK9j8ue4
         1fKkl5sm/BiIQSznuvYgrvkSqhQ+UmYmcjq1I=
Received: by 10.140.132.8 with SMTP id f8mr1508995rvd.206.1220019178207;
        Fri, 29 Aug 2008 07:12:58 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Fri, 29 Aug 2008 07:12:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0808280936300.3300@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94262>

On Thu, Aug 28, 2008 at 7:37 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 28 Aug 2008, Felipe Contreras wrote:
>>
>> If the git-foo was supposed to be deprecated in 1.6.0
>
> Itw as deprecated over a _year_ ago.
>
>> When it becomes truly obsolete, then people can rely on git exec-dir,
>> which will be disabled by default.
>
> It _is_ obsolete, but there's a trivial compatibility thing.
>
> Are you happy now? How hard is it to really understand?

It only takes one word; obsolete. I haven't heard that git-foo is
obsolete until now, all I heard is that it was deprecated. Maybe I
should have paid more attention but that's not the point.

What other projects do is make very visible when something is
deprecated, like a big, annoying, unbearable warning. Next time you
deprecated a command it might be a good idea to add the warning each
time the command is used, and obsolete it later on.

Also, if it's a big change like this git- stuff, then do a major version bump.

If you had marked 1.6 as 2.0, and added warnings when you deprecated
the git-foo stuff then the users would have no excuse. It would have
been obvious and this huge thread would have been avoided.

Personally I'm subscribed to the mailing and I read the release notes
of 1.6, but I didn't register that change. I install my git stuff to
/opt/git, so when I was using git-foo I was using the old commands
that come from Fedora. It wasn't until I read this thread that I
noticed.

Don't expect users to be a aware of what's happening on the project,
many wouldn't even notice that there was a minor version bump. Julio,
I guess that recommendation goes for you.

Best regards.

-- 
Felipe Contreras
