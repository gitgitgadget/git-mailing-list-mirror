From: Cory Sharp <cory.sharp@gmail.com>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Wed, 13 May 2009 23:34:24 -0700
Message-ID: <bb9d69200905132334m7a4e3a4akde3529abeab5a09@mail.gmail.com>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
	 <bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>
	 <7v4ovo1iap.fsf@alter.siamese.dyndns.org>
	 <bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com>
	 <7veiusz45w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 08:35:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4UWX-0000Fv-0v
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935AbZENGeZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 02:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbZENGeY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:34:24 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:6843 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZENGeY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 02:34:24 -0400
Received: by qw-out-2122.google.com with SMTP id 5so881688qwd.37
        for <git@vger.kernel.org>; Wed, 13 May 2009 23:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CyfFWawiRlki05YJKc5Nvyt76OJfBveYTlb+ZVHF0Z0=;
        b=KPDC6IhGg1Eeh7H6Rja+nLvJq7La2Tys4VNj7wnmJEHRqFCJRbZKJHD7hgobklY59n
         S6P0kb+MW5nD3Su8Dvm1KRbZPHB3CMgen4gDzRGJr6Swnoi0C5osFru3Hh8MMWWKn7ln
         9GlI+zLwrgHsT1vy5IWy4R52AOoPLcKBwd4R4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JnLJV9eAr+y2KDmQfLNOUf5S8pr51HjwSmUH+s7WIPLbiFULSSYjBh5PvnVc+DqCCq
         PpgW3XPMdKk0vXF0WhZnJJpXK9MhI/7e8/VXWiCHskpGAyr3pk8XA9Xs3lyoX2uaGJ25
         Er0YAuLNK+bfd5z36Z6LxrzvVKdYvVNdAmObU=
Received: by 10.229.96.9 with SMTP id f9mr1310126qcn.78.1242282864463; Wed, 13 
	May 2009 23:34:24 -0700 (PDT)
In-Reply-To: <7veiusz45w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119149>

On Wed, May 13, 2009 at 9:42 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> What's your point?

I am asking for help and understanding.

> WIth --squash, the tree and the index state becomes the same as if a =
real
> merge happened. =A0But the merge history is discarded with --squash. =
=A0It is
> a simulation of a merge in CVS and SVN (before they added "merge trac=
king").
>
> If you want support for repeated merges by merge tracking, you do not=
 want
> todiscard the merge history by using --squash.

Why doesn't --squash do merge tracking?  The help didn't indicate that
it doesn't, and I don't understand why it shouldn't -- since I *could*
track the previous merge point manually and do "git diff --binary
PREV_MERGE..NEXT_MERGE | git apply -" to do the merge myself.

But since that's me manually performing merge tracking, why doesn't
"merge --squash" track like just "merge" does?  If I didn't want
tracking, I would expect to use some other command than "git merge
[options]".

Thanks for your help,
Cory
