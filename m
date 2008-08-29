From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Fri, 29 Aug 2008 09:01:48 +0200
Message-ID: <e5bfff550808290001r168c7edfre926f1bc735f3ad0@mail.gmail.com>
References: <20080808211318.GA4396@efreet.light.src>
	 <20080817195839.GB4542@efreet.light.src>
	 <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com>
	 <20080818180048.GA15520@efreet.light.src>
	 <e5bfff550808190753t4f99ddb6q83886dbca27dbf03@mail.gmail.com>
	 <20080827201819.GD15520@efreet.light.src>
	 <e5bfff550808280429h63496f9byfa4454af7adb0e86@mail.gmail.com>
	 <20080828153118.GA13169@diana.vm.bytemark.co.uk>
	 <e5bfff550808281154h67392297y3a08d4ed8aea408f@mail.gmail.com>
	 <20080828220124.GF15520@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Karl_Hasselstr=C3=B6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Aug 29 09:03:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYy0V-0008Qc-8i
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 09:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYH2HBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 03:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbYH2HBt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 03:01:49 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:6924 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbYH2HBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 03:01:48 -0400
Received: by rv-out-0506.google.com with SMTP id k40so749689rvb.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 00:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WvVVfxqcp83Bok43ssIxIVAdR2LSPmTPdsoc6xJU5fg=;
        b=sb4WgS+3RqiTlJz+Yh8WZp0SmHZzuvzaHtX9471ehtX7atJhycjuL5+mRUaW8S3qdU
         hNiwz6iDhMSsN06eZ3K6s8E0J2jxfxu8hYGPnUPBQjKx1psSO9Nb+H8G8QZEsV0EIGzT
         h+ZJVg6SLJpPdUkMlgyQO4S3VsXYkeYGfo7hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U6zNPywArnjnMC8cl8N4gpwgGMclNv0AvX5HVjoPR8mIVWHkIKAz5HOWcbSQfTqbsM
         fjcVi7cIQ5ekeDU9uPhx0sIu3o9IahjEgbErvI6/rBDKdTxL35udQMlfN0boAHYQ700q
         Gd0HDGSH7owkX9uRuuyDojI47wOdKz0NzZuuA=
Received: by 10.114.184.7 with SMTP id h7mr2365135waf.9.1219993308277;
        Fri, 29 Aug 2008 00:01:48 -0700 (PDT)
Received: by 10.115.110.15 with HTTP; Fri, 29 Aug 2008 00:01:48 -0700 (PDT)
In-Reply-To: <20080828220124.GF15520@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 29, 2008 at 12:01 AM, Jan Hudec <bulb@ucw.cz> wrote:
>
> So, now there is a test infrastructure plus test case to reproduce this
> switching between stgit and non-stgit branch in
> git://repo.or.cz/qgit4/bulb.git (http://repo.or.cz/r/qgit4/bulb.git) with
> whoping 9 commits. Should I send out a patch series, or do you prefer just
> pulling?
>

I prefer to pull.

> Now in my opinion the code could use some refactoring rather than just fixing
> the bugs (my long term intent is to add features like topgit support,
> push/pull/merge and other things git-gui can do and such). I'd start with
> the Git initialization sequence. I'll write tests for the new code, but as
> I expect it to have significantly different interface from the old one, I'll
> not try to write tests for the current one.
>

We have following possibilities:

- Pull the code directly in qgit master as soon as there are some new
commits in your branch

- Pull the code in public qgit repo but under a different branch,
let's call' it "next" ;-)

- Waiting for your code has stabilized a bit (testing infrastructure
is very young and for what I have seen from revision history code is
still very 'fluid'), then pull the branch in qgit master directly.


These are my two cents:

Option one could be a little bit misleading for people pulling from
qgit repo to get current qgit sources + just fixes.

Option two is doable but is an additional step with an additional
maintainer burden, probably the current number of contributors to qgit
is not enough to justify such a complex development model.

Perhaps option three it seems the more balanced, also looking at
projects git related and with similar size of qgit, as example StGit
itself. When let's say Karl has ready a block of patches he sends them
all as a series and are applied to StGit master branch.

The only modification I would suggest is that I can pull from you repo
directly instead of asking you to send patches to the git list.

I leave up to you when to ask for a pull request, I only ask you to
consider that qgit public repo is pulled also by people not interested
in the latest development, and they only want a stable qgit, so please
ask for a pull when you think stuff is stable enough.

Comments?

Marco
