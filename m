From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 5 Dec 2010 15:29:51 -0200
Message-ID: <AANLkTikL4BWtzNgx1+MBYxRRdfL=Gu71KPjaiKXprvnb@mail.gmail.com>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
	<20101205021837.GA24614@burratino>
	<AANLkTinAT3kotKQTS6eS1SLigNzSp6grAU7WNRbHf3N=@mail.gmail.com>
	<20101205170919.GA7913@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 18:30:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPIPR-0004Rn-Fx
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 18:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756328Ab0LER37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 12:29:59 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35866 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756508Ab0LER3x convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 12:29:53 -0500
Received: by bwz15 with SMTP id 15so9894826bwz.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 09:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Mmkr3qT6x1DB5glwuvfqM3dOFyrAJ64CjjYYC64gnPE=;
        b=JaJcAMpfe0XtT+OBEHmWeUsOOjB6NF1nJ1MpLiB+lcqeCAQobbRwwZT0wUzJRmoILD
         H6WuJKQCSfTsXm2Kz1BvN4ChRK4+wWdjYnOmqnOFmGv7qdLg7/Q8RYmnvkWFKWxHYDlx
         sFmAjQwagdVvaQ2F+hbsa7EiaDqpraObaFgro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XQ+NydrjVPeCut9DngdRqDxzIFhpYSVL719W3G07wFa7fGGvMH4Torlridho+3+INo
         76XFGR8hnpIQYUEZ4Mtsc8DLgsgyTfabNHoW7aGSr/YOmSXacTta12GWif9IwgmgJkZc
         WJrFJCKerkdLmmnIEZ6Mfa9lEmTKzc1/SWGyo=
Received: by 10.204.61.81 with SMTP id s17mr4838545bkh.121.1291570191736; Sun,
 05 Dec 2010 09:29:51 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sun, 5 Dec 2010 09:29:51 -0800 (PST)
In-Reply-To: <20101205170919.GA7913@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162953>

On Sun, Dec 5, 2010 at 3:09 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> =C2=A0- "At my office there is a style guide indicating that each fun=
ction
> =C2=A0 should live in a module with some other functions and be named=
 to
> =C2=A0 indicate so (like perf, with its sched__* etc functions). =C2=A0=
The idea
> =C2=A0 is that code with a simple high-level structure tends to be ea=
sier
> =C2=A0 to understand and we need to understand the code we use. =C2=A0=
Can we
> =C2=A0 start changing the code to fit this style guide, so there is l=
ess
> =C2=A0 resistance to using it at my office?"
>
=46or me that is a good reason and I think it matches with what I had i=
n
mind but didn't write. Thanks for pointing it out.
