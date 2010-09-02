From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/25] gettextize: git-merge basic messages
Date: Thu, 2 Sep 2010 15:37:11 -0500
Message-ID: <20100902203711.GE2531@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-11-git-send-email-avarab@gmail.com>
 <20100902200940.GB2531@burratino>
 <AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:39:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGYv-0008Jk-Q7
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab0IBUjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:39:04 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49990 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111Ab0IBUjC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:39:02 -0400
Received: by wwj40 with SMTP id 40so1346787wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=pyj30dNQjf2IRk1ygWA5p2woFq90yctOsx6jzgH2VS4=;
        b=caNYsOpvKj4Y8fGZOmcWmSDyM4WKcAKLEuXw050Q0OpiBuEXEvJAD09Dr+eTN/vVSx
         pJu+wicpaNe+9NM6wHjIoSEttVcSWzw9tRUovvk+4bRVeutbqL08s1Sg8SXfzGwZ+L+W
         fShoo1cWJWAhmApfy0XAJhYtfBU+b7M7n1l5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fv5uFmssJtmmQT+8ePBqe/nWIbx4S8Ck4bIGq5mGexR2eWEtDFXp060+p5jLgK8k6b
         FNZQoXERdlVq7AuPLlXGwOsXLQBOa24zNHQxGN2SmqsUtEJKskQ8Ei/gzm5CJVsYJ5yO
         mWCrRkZyLYhZIItIPrSN6ZnPO3IhhrZmyC/r4=
Received: by 10.227.145.148 with SMTP id d20mr144576wbv.117.1283459940991;
        Thu, 02 Sep 2010 13:39:00 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m25sm751096wbc.13.2010.09.02.13.38.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 13:39:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTiksZykH4zDbdDReYYgJZk7gmZ_2g0v=9X_MP73p@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155200>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> It's on top of pu,
[...]
> But I was hoping that this would
> make it into pu and after next gets released Any Day Now most of thos=
e
> other tips in pu would be folded into next along with gettext, or at
> least the merge conflicts wouldn't be too painful.

Hmm.  That really constrains people trying to merge this series.

As SubmittingPatches explains:

 - In the exceptional case that a new feature depends on several topics
   not in 'master', start working on 'next' or 'pu' privately and send
   out patches for discussion. Before the final merge, you may have to
   wait until some of the dependent topics graduate to 'master', and
   rebase your work.

so this is fine for discussion, but for merging, having to pull in
_all_ topics from pu (or all topics from next for that matter) for
the patches to apply really is a problem.

Both next and pu get rewound from time to time.  They are not meant
to be a stable basis for patches.

Also worth mentioning is that topics in "next" are not guaranteed to
be included in the next release.  The "next" branch has content
matching the "jch" branch which I think has a better name: it is
just the version of git that Junio uses for ordinary tasks (and
hence topics in it cannot be completely broken for long).
