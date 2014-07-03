From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Fri, 4 Jul 2014 00:19:41 +0200
Message-ID: <CAA787rm6Q_r-kec+37YF28hBL0Z6nfgtvgfvhvTYGycbajUEiA@mail.gmail.com>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:19:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2pM2-0004RP-Ka
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 00:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbaGCWTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2014 18:19:43 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:40409 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbaGCWTm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2014 18:19:42 -0400
Received: by mail-la0-f50.google.com with SMTP id pv20so628740lab.9
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=S5j3X1tda0aOtHQjLtospJFsihQ9Pq+kM7Fw4IZzl7E=;
        b=Cs/EU6T+RuH65msovomcOzzni2bTxG8XDsSrnVy5AnnyahDp6XlrfP+it4D/9QPBbv
         R3UQKpQM2KBkc5n7vSyXDElfLnb0bXKps+h4j2ekZ/I/t4x6R0BbMWx52vje9z2C4cTP
         KdsQJ85zU/HySgzsSzJEUDt+RIZqVGlVP1No/YWE/W3wBOrRvnveGaDxDoTF42AEoWGc
         dqc4OhXIDPugj9qGH6dXZ2ODk8NoebMvmLnAJwYMkID/a3MyMmMGFRLgtig+r/N2ygwC
         KRarvdgYeuyUm18ZG6JGD728Erx9B9AkjlUa8szmzQctRu149bRmtuD804YdhJFydoVs
         2Okw==
X-Received: by 10.152.180.168 with SMTP id dp8mr5391760lac.11.1404425981086;
 Thu, 03 Jul 2014 15:19:41 -0700 (PDT)
Received: by 10.112.142.7 with HTTP; Thu, 3 Jul 2014 15:19:41 -0700 (PDT)
In-Reply-To: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
X-Google-Sender-Auth: GFsjrty0maSfqE85K1kq9iv-daI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252883>

On 3 July 2014 23:55, =C3=98yvind A. Holm <sunny@sunbase.org> wrote:
> When compiling newest master (v2.0.1-472-g6f92e5f) on Debian 7.5
> (64-bit), t5150-request-pull.sh fails when compiling with
>
> $ make configure
> $ ./configure --prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f9=
2e5f
> $ make prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f92e5f
> $ make
> $ cd t
> $ ./t5150-request-pull.sh

That's a copy+paste error, ignore the second make. :-P

Cheers,
=C3=98yvind
