From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: git-svn tags and branches
Date: Wed, 29 Aug 2007 23:27:07 +0200
Message-ID: <cb7bb73a0708291427k7b3a5de8y61b5562f45c73069@mail.gmail.com>
References: <faulrb$483$1@sea.gmane.org> <46D4A664.4070007@vilain.net>
	 <cb7bb73a0708281620v41383ed8w728af0112d2a6360@mail.gmail.com>
	 <46D4ECE2.9020806@vilain.net>
	 <cb7bb73a0708290141y159d6bbfj2bac23af5e86bb15@mail.gmail.com>
	 <7v4piisolb.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0708290353iba0bdefl81a4a4e158be2fbf@mail.gmail.com>
	 <7vhcmip05g.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0708291402r3e9dfdeeh85bcc47ef9eba782@mail.gmail.com>
	 <7vy7fu9h9n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 23:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQV4G-0006FF-Ni
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 23:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbXH2V1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 17:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756910AbXH2V1K
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 17:27:10 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:30694 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbXH2V1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 17:27:08 -0400
Received: by py-out-1112.google.com with SMTP id u77so2461720pyb
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 14:27:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OWlpDmB4aNEs1gvxy5WZ2kR3bdshhTpdtNRwE1jUyHl+1+9RzAnZBfWO+X7J4nm69mXbiTP+jRaGxN03n6jpbK17oEmG9vseum8WpMVkHpzCX+MLLeXhlClX8Nv7XUsp9D452109jVzrHc7mziV3WG9aAm8rBGRZTtfwQIWx8jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m9KPKeXR9VDOBAOHVovD2CTvaVX+/U60Sif32GaGlVkHfOK6NwNbJaQ9iP6qbCzBHioOc8gX7MTd2r8ux75xpZKsQliSyXK0a2/zCUbYl7+/KJiRUOefDJP9X3ue7gcSoVYkQRgvDtfX56rYwd6DCmYy+8vdFD1QJho07vrN5dQ=
Received: by 10.35.70.17 with SMTP id x17mr1270498pyk.1188422827548;
        Wed, 29 Aug 2007 14:27:07 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Wed, 29 Aug 2007 14:27:07 -0700 (PDT)
In-Reply-To: <7vy7fu9h9n.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56986>

On 8/29/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>
> > On 8/29/07, Junio C Hamano <gitster@pobox.com> wrote:
> >> As I said in the part you quoted, if you have branch foo and tag
> >> foo, and if you are interested in talking about the tag 'foo',
> >> you say "tag/foo".  When you want to talk about the branch, you
> >> say "heads/foo".  Replace "foo" with "name" and I think you get
> >> your answer.
> >
> > The problem here is that you can have THREE things: the tag foo, the
> > branch foo, and the 'branch' under the tag foo, which is not the
> > branch foo.
>
> What do you mean?  "refs/tags/foo", "refs/heads/foo" and ...?
>
> You cannot have "refs/tags/foo/bar" if you have "refs/tags/foo".
>


-- 
Giuseppe "Oblomov" Bilotta
