From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/4] cat-file: add --batch-disk-sizes option
Date: Tue, 9 Jul 2013 16:02:31 +0530
Message-ID: <CALkWK0=+B2C-0jmJL-mJHAio1H-dAacdV2Sr+HXpQTwehTD-xg@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net> <20130707100949.GC19143@sigill.intra.peff.net>
 <7vtxk645vp.fsf@alter.siamese.dyndns.org> <CACsJy8A8ZO3DL8Vr=S1G-3yiJz3WaZ-7jV_eA+v6rPAWrd9NAw@mail.gmail.com>
 <CALkWK0ktNK49zBM4tD8fpNN3VMan7DegfWRtDcOEgTyEbSK9Uw@mail.gmail.com>
 <CACsJy8Dffc2WgtDyUS2g2gmDWG_rTxs389fHcj0ztm6pdJddjQ@mail.gmail.com>
 <CALkWK0k0xiNFaFmqL2t4ba2g+HSrQ8kU+W_HvnSMcMYY8VgJyg@mail.gmail.com> <CACsJy8B0E-jM+HHuhJD0fdZL2rat3ctDbSrCPo990WPnDA17RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 12:33:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwVEm-0004JF-Lj
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 12:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab3GIKdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 06:33:21 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52953 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab3GIKdM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 06:33:12 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so12633845ieb.10
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ddWQ3Ek1sq2NGaUun919BOiO8j0K8Pjrb6h/bntRVt4=;
        b=TnZbMzPgYH5DSPy6too9YksKcqkwmpOeRnMuJ3pZU/ngXb4A//CTcsiYFqewpL97Fl
         DWeswtWqJZDC7ZfEj4dj2p3yDBnEzo3rw/FgCt+wDVdXDbFSsKildvm25zVvomkDyK8V
         RAasBvRj9kZqUWIQKZuPK6DVhgP36Yk+NxNqG4MMDRzjuV9SOHhRBloCMnQpxQn00ETS
         owlblIZBVawU1ohAP8f5g1LRBe6ZK7ik9ktz27i/jUd0/hZZoXumvhQRE7n8KSQJk00o
         wYbkwqHLxPa9nScylrb10mXwB+RfTApvhGnxZNYPUgf0/c9Kr0fntuhTDUBS9k91n24c
         pPOg==
X-Received: by 10.42.76.5 with SMTP id c5mr6423598ick.91.1373365992228; Tue,
 09 Jul 2013 03:33:12 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Tue, 9 Jul 2013 03:32:31 -0700 (PDT)
In-Reply-To: <CACsJy8B0E-jM+HHuhJD0fdZL2rat3ctDbSrCPo990WPnDA17RQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229927>

Duy Nguyen wrote:
>  - We might overlook something. The best way to avoid missing is
> finish and verify it.
>  - A promise to do things later could happen really late, or never
> happens. As you are sastisfied with the functionality you have less
> motivation to clean the code. Meanwhile the maintainer takes extra
> maintenance cost.

I know.  You know what my counter-argument looks like already:

A promise to deliver a perfect series sometime in the future risks
never reaching that perfection, and stalling everyone else's work.
Even if we do manage to complete that perfect series, there is no
guarantee that we'll get sufficient reviewer-interest or traction for
merge.  You think people are more likely to look at a 50-part series
than a 15-part series?

Either way, I'm not interested in arguing: for now, I'll repost the
old 15-part series and try to get some reviews.  Start writing code,
and let's finish this thing.
