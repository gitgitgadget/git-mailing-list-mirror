From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Fri, 3 Sep 2010 12:51:42 -0500
Message-ID: <20100903175142.GA2341@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-11-git-send-email-avarab@gmail.com>
 <20100902200940.GB2531@burratino>
 <AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
 <20100902203711.GE2531@burratino>
 <AANLkTi=ZQAjA9SN1A3WDr-L2rFA6v-XH0mZAkhuUgdAg@mail.gmail.com>
 <20100902211339.GA2801@burratino>
 <AANLkTinvvZ9eVxQXafYBDfSe8ay11mFz4s1=mDozbs14@mail.gmail.com>
 <20100902230410.GA4850@burratino>
 <AANLkTimBbSz5TF5CBa0us5oLQ-t=S9HNdBSVifUUSiqt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 19:53:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OraST-0004Ln-8e
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 19:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398Ab0ICRxl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 13:53:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41543 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752998Ab0ICRxk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 13:53:40 -0400
Received: by wyf22 with SMTP id 22so104907wyf.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Uj2eCPzhmptlZwXkxyFBjUyvJ6+8rdoHNcIIOSO+FJw=;
        b=hSSFfa6+yJLgUwZPh36fmNkgPk35IEcAFD90KT0JqnjyVL65iwP7iaXhFSsFLKXFsd
         AOlE5L5JPHIqhme2EfFvHYnbYB1CxObN4ejk+RsInEqlzMF4/Jaa6xd0zVFniIe0isw4
         bcr+GdlL15BIN3JHQBstwg1KrP888YCfBW4mU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hsHUwbV34ZNiu5qTB5R5gvsCYGF7ZOyF5HMNbWhgES/rstbBt+QHwN5SC2DoziXU4q
         O3L1ySyI0tJsoWwjeWZvRdKeglqIxmzkfzfpJYQaRbH0uT4IlhorKA9+dtSexoVNj8Zo
         si1YRBcYRaPneS7T4TirvnUzsKKZfA+irjX6s=
Received: by 10.216.164.66 with SMTP id b44mr175820wel.81.1283536419612;
        Fri, 03 Sep 2010 10:53:39 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id o15sm1405614wer.15.2010.09.03.10.53.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 10:53:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimBbSz5TF5CBa0us5oLQ-t=S9HNdBSVifUUSiqt@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155255>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Those issues might be a bit hard, but I still can't really see how
> managing these files outside of git.git would make things easier.

The translationproject.org thing was a red herring.  As you noticed,
the relevant thing is "outside of git.git".

So imagine there is a git-translations.git project, perhaps.  My
only point was that versioning of translations and versioning of
code can beneficially (in my opinion) be decoupled: with time,
the translations for even _old_ versions of git improve, too.

> maybe we should just use
> msgmerge with --no-location.

That would partially alleviate my concerns, and I think we might be
able to get the --add-location output back in actual checkouts with
a "smudge" filter.

But still there is noise from reordering messages, adding them and
removing them, and so on.  It just never seemed like a great fit for
the usual version control model to me.

> But I'd like to coordinate things on this mailing list
[...]
> without some external service being mandatory.

No objection here. :)

Of course, what is convenient for translators and maintainers (i.e.,
not me) takes precedence anyway; I am just throwing out ideas.

Thanks for your thoughtfulness.
