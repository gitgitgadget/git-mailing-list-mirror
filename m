From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Fri, 5 Oct 2012 00:09:39 +0200
Message-ID: <CAB9Jk9CiDNNBM9V-VvwCK6q-N0JNwEbf4vJj0ffT82iLnrUwog@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
	<vpqvcer4xvo.fsf@grenoble-inp.fr>
	<CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
	<A75F75C4DE3C47C7AF43D39355C873F7@PhilipOakley>
	<CAB9Jk9C4Y2LSzZW5Nkz=4f===8_gk4uAG4EKDxT17kUHu4VX1A@mail.gmail.com>
	<20C3105FC8D94F749FAEB7444325B34A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 01:03:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtkT-0005yD-12
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112Ab2JDWJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 18:09:42 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40337 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab2JDWJk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 18:09:40 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2177403iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 15:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kilV0rx0LRbCGfWBCCpVYAt17VQk3sREl0URSg/J0S4=;
        b=Ou+mQK396I9lU8DiOqy6Kqs1v1QV4Qcv17nYLzQWU9ZVRf3O+EzWr5mUjuP/XkpTCS
         +rg5aeVrunHUS6uoIpbvrReaSx28xw/mjZB29wwaWFSChFdwxFAr6DGhr+Cg8IlLXcyI
         yE76/h80DXnKwu7uFmFsxFE3YOh+G4Oo5XwICdQ/PvJSJeo1HXIJ1TIcax7fZzfDOipY
         fzyJ9qIK/GvXL/LI5PBkhtv5f+5BqgEmG0xa1cQgsRiUSLF3vC0Xecq+WbAqEo7eSRro
         HhTI5QdekZ4DRkXWko29LPXzRowpL9yQ/FK3JIXTOxEqIdZaLjamtV2AJtLyTz7DhjAy
         ZoCQ==
Received: by 10.43.48.129 with SMTP id uw1mr5589749icb.10.1349388580061; Thu,
 04 Oct 2012 15:09:40 -0700 (PDT)
Received: by 10.43.131.136 with HTTP; Thu, 4 Oct 2012 15:09:39 -0700 (PDT)
In-Reply-To: <20C3105FC8D94F749FAEB7444325B34A@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207042>

Hi Philip,

> This has the developers having a full copy/history of the integrators
> relevant branches, so that when the pull of the developers branch occurs
> there is a proper link to the integrators history.

True.
>
> There are other ways to create a branch which has all the developers feature
> history removed, rather tha using an --orphan, which removes the integrators
> history as well.

The topic branches are populated only by the developers. The integrators merge
all the topic branches into branches dedicated to the integration. In
case of need,
the developers can pull these (with all the integrators' history).

>
> The disconnection of the D' source branch makes it sound like you have a
> second SCM system that you have to put stuff into, which is independent of
> the development teams git repos. I have this [hassle] at my $dayjob -one
> almost has to hide git from the powers-that-be.

Well, there is another way to see this: think to a distributed SCM in
which there are some parts of the contents that are shared and some
that are not.
The technique to use disconnected branches is only a way of implementing this.
If, say, git push had an option to filter out the binaries there would
be no need for disconnected branches.

>
> A reasonable solution. You can also create a sentinel (--root) commit for
> any time that you need to create the source branch, just so it (the real
> source code commit) has a different parent when on source branch to that on
> the binaries branch.

Do you mean I could create an empty root commit to be used as parent for the
real source commit? Or that there is some --root option to be used?

-Angelo
