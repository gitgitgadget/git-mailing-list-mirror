From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: most commonly used git commands?
Date: Thu, 28 Jun 2007 14:17:32 +1200
Message-ID: <46a038f90706271917j7abb4bddu21debafe3461c695@mail.gmail.com>
References: <20070625064017.GA2839@mellanox.co.il>
	 <7vlke833wr.fsf@assigned-by-dhcp.pobox.com>
	 <20070625071752.GB15343@mellanox.co.il>
	 <7vodj41nm6.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 04:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3jZf-0001CY-Um
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 04:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761195AbXF1CRe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 22:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761350AbXF1CRe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 22:17:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:24157 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761007AbXF1CRd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 22:17:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so372155wxd
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 19:17:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WBTgT+g88xmZg+f325xw+Mg7VxtGpjDCT2Gk06D6H1Uy3pHmRLUhaF79TuJWrQY1lRuvg7S5/O8CYVUnK6vnfrca0bNOvidIKfOcOtD9x5KKqZmAkRwiSUglqnq8GPb1xkpdDwm2lSA62CxMp3TK8ZnRSpEbVuKPZp7madTT2mY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JgBOFhjIQJYwma03tdfN/Cjm41rKMSxZ8mR2/EW6p3ZUn32n11UV90UHaXc0qigEkNuE+LIo11Afj1cSyv14Q7pkKjPuCL7paRFMMz9Gu4Z8oaxu39v9gn7PwEpYGw59QTiAFr3NqUsuuDR4MVoajp9apvjnOWeI5UKCDHdtxNg=
Received: by 10.90.75.10 with SMTP id x10mr1280074aga.1182997052542;
        Wed, 27 Jun 2007 19:17:32 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Wed, 27 Jun 2007 19:17:32 -0700 (PDT)
In-Reply-To: <7vodj41nm6.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51072>

On 6/25/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Michael S. Tsirkin" <mst@dev.mellanox.co.il> writes:
>
> >> Quoting Junio C Hamano <gitster@pobox.com>:
> >> Perhaps they are most commonly used by the person who came up
> >> with that list first ;-)?
> >>
> >> I think "add" deserves to be there, I am not sure "apply" is.
> >
> > git add is supposed to be rare, no?
> > That's why git commit lists file additions/removals ...
>
> No.  You are talking in terms of pre-1.5 git.  The semantics of
> "git add" has been clarified since then --- it adds contents,
> and is not about telling git that there are new files it did not
> know so far.

In other words - git-add is also a (semantically good) alias for
git-update-index.

So you "add" files to the next commit. Whether they are "new" to git
or just changed it doesn't matter that much in that situation. And
git-commit will look at those files that have been "added".

Makes things a whole lot easier to explain. I didn't understand it
initially, now I'm completely sold on the concept.


m
