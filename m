From: "Robert Newson" <robert.newson@gmail.com>
Subject: Re: Perl warning in git-svn (git v1.5.3-rc7-16-ge340d7d)
Date: Fri, 31 Aug 2007 17:18:26 +0100
Message-ID: <46aeb24f0708310918u29fa5d17r9878658e68702fca@mail.gmail.com>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com>
	 <7vveav21uv.fsf@gitster.siamese.dyndns.org>
	 <20070831152153.GA30745@muzzle>
	 <7vfy1z1y9u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 18:19:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR9D3-0000nH-R1
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 18:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbXHaQSb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 12:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbXHaQSa
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 12:18:30 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:57234 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965537AbXHaQS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 12:18:29 -0400
Received: by nz-out-0506.google.com with SMTP id s18so648881nze
        for <git@vger.kernel.org>; Fri, 31 Aug 2007 09:18:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b+oNxi5qwKwsAcaVZPrjiwOhPViLLaZZEuU7Y9KNf7fK8YYK/GNouWXP3NKo+vGAZKWlpePFgCb0atTZcrkHSfPMhVkIzuYbAwkKF6snzLVFy7dPu5DgBk4LSfmLrrfux1sFBiDCfFiSMhveDlZfdirg0UyKz51zPyAeh9/aIJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rzf8Z4AIGbVy9+RTpnMVRYLkdkODe7TG4+wPC3tmqXXUfkExm9umY+XjT63Y67R+VqoKcDKcE4XvY3gqCdL9ggqO6FOVcOx6t8ZngqckcmLBVySXdn0r13708A79SH2bdKBqQ/z+BekqkvD4NbXBqkFdFdGo/Akf+ZMmrkmlwmQ=
Received: by 10.115.95.1 with SMTP id x1mr856722wal.1188577106928;
        Fri, 31 Aug 2007 09:18:26 -0700 (PDT)
Received: by 10.115.19.3 with HTTP; Fri, 31 Aug 2007 09:18:26 -0700 (PDT)
In-Reply-To: <7vfy1z1y9u.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57181>

I have these settings in ~/.gitconfig;

[color]
        branch = true
        diff = true
        pager = true
        status = true

not a problem in 1.5.2.4.

On 8/31/07, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
>
> > This could be a sign of a bigger problem.
> >
> > Does git-log read .git/config and that could potentially change
> > its default output format?  A quick scan of the docs say "no".
>
> "diff.color = always" could break it I would imagine...
>
