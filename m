From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 01/15] README-sparse-clone: Add a basic writeup of my
 ideas for sparse clones
Date: Mon, 6 Sep 2010 13:14:16 +1000
Message-ID: <AANLkTimtOH65n_XNdCHPmUS77Xxk5MAuQDqbh401wgmb@mail.gmail.com>
References: <1283645647-1891-1-git-send-email-newren@gmail.com>
	<1283645647-1891-2-git-send-email-newren@gmail.com>
	<AANLkTikx89M+JcOcabU3TazGB=k8x39QLbVe7sH7Vvaa@mail.gmail.com>
	<AANLkTikxCwSOBVREuRc7sShJahKR5FXWdaW79f_K36bU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 05:14:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsSA6-0007wR-JS
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 05:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183Ab0IFDOS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 23:14:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37119 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048Ab0IFDOR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 23:14:17 -0400
Received: by wyf22 with SMTP id 22so2449206wyf.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 20:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W0d23k5MXpbEfI6BYGKSTiBGaLktz8ZQOHGqCO4z8zg=;
        b=o/L3rJg34ikvGublcRQ9E86ivW+QUcqWFNmXH3yhSoPLpxnCEEri2mxftJZBY9oD3y
         vX1y3PQKNWFq8UjnwYuSTGISMP9SZ8p9S8KGjOb2hdUYzCaaBXz5xHXCI2gKd1o2uF0T
         jRM7SNcKZ3rRNGynszmpnXymboO+QihCVj96I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WbGN776r1Br185Zb9jBMWK1lbdrIWiVowdiJ6MdWKjwP+hR+Xa7wTjAfnNBh5OMWx+
         C7FqLZ+Hq/XhjMmOsBLNVR9SGkG0eW/QhZbVfo/NMV3cPjkmB+xAPgNnYpD1RZubkZZv
         6fMu/3iLfb3BCTLJANOJsGECV4I9L+nO8K7z8=
Received: by 10.216.155.7 with SMTP id i7mr2197600wek.59.1283742856351; Sun,
 05 Sep 2010 20:14:16 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Sun, 5 Sep 2010 20:14:16 -0700 (PDT)
In-Reply-To: <AANLkTikxCwSOBVREuRc7sShJahKR5FXWdaW79f_K36bU@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155517>

On Sun, Sep 5, 2010 at 1:13 PM, Elijah Newren <newren@gmail.com> wrote:
>> Just an observation. When I ran pack-objects with irrelevant commits
>> removed (i.e. try_to_simplify_commit) on Documentation/, I got a 6MB
>> pack. When I ran it without commit simplification, I got 16MB pack.
>> That's 10MB larger.
>
> Hmm. =C2=A0I get 22MB pack for a full clone of git.git and 13 MB for =
a
> sparse clone with Documentation/; that's including all commits too. =C2=
=A0I
> wonder why our numbers differ by 3 MB. =C2=A0Weird.

Hmm.. just got a fresh alt-git.git from repo.or.cz and did
narrow/sparse clone from that. "git clone" reported 16.27MB for both
narrow/sparse version.
--=20
Duy
