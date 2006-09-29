From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH 0/5] fetch & co: misc output cleanup
Date: Fri, 29 Sep 2006 22:48:17 +0200
Message-ID: <8aa486160609291348m411932aqfd1049c96ed624df@mail.gmail.com>
References: <87r6xu1rci.fsf@gmail.com> <451D6BDB.50900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 29 22:49:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTPHU-0007R9-N1
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 22:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422818AbWI2UsT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Sep 2006 16:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422824AbWI2UsT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 16:48:19 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:43497 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422818AbWI2UsS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 16:48:18 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1054952wxc
        for <git@vger.kernel.org>; Fri, 29 Sep 2006 13:48:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TN4G+4oPeH4xS+TfZ/OrARI9Vkgq81c1bLXbBGZMTKVwg8eM+b1ov1bp8RAPaoJ/F2alxGzkBN2qEXRVodN+zhFLNsRrBNYDQbJjRg6AGFkfbFDdq0TvLAkaRMbYMFF9ge94mjbY8+T6bk18u+DegwlgBS9/Pb6ER2m3cQIrZlA=
Received: by 10.70.11.5 with SMTP id 5mr3242814wxk;
        Fri, 29 Sep 2006 13:48:17 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Fri, 29 Sep 2006 13:48:17 -0700 (PDT)
To: git <git@vger.kernel.org>
In-Reply-To: <451D6BDB.50900@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28129>

2006/9/29, A Large Angry SCM <gitzilla@gmail.com>:
> Santi B=E9jar wrote:
> > this patchset includes:
> >
> >       fetch: Reset remote refs list each time fetch_main is called
> >       fetch & co: Use "hash1..hash2" instead of "from hash1 to hash=
2"
> >       fetch & co: Use short sha1 in the output
> >       fetch: Add output for the not fast forward case
> >       fetch: Clean output
>
> Please do not make short ID output the default. That is, unless you c=
an
> somehow guarantee that the short ID reported today will _always_ be
> unambiguous even with future additions to the repository.
>

There is not such guarantee. But the fetch output is to be use
immediately in git-log, etc. If you want these "guarantees" you must
know that you have to keep the long version.

By the way, is there a way to show all the commits,tags,... that
abbreviate to a short hash? This way instead of just saying "bad
revision" we could show the list of possible revisions.

Also, git-log & co also output abbreviated hashes by default. So why
not for git-fetch?

Santi
