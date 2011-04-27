From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 21:42:57 +1000
Message-ID: <BANLkTim=ARYu=E-Lgu8dA+FpVQUY+q-yeA@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<BANLkTimqVs+Bg+zz7xu1Fb=a_dJ65WOvQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 13:43:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF398-0000Ko-Ej
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 13:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758628Ab1D0Lm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 07:42:59 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63974 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758669Ab1D0Lm6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 07:42:58 -0400
Received: by vxi39 with SMTP id 39so1217734vxi.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XAnhMgpZ7QfwsuZEpz3WXt8JDxhxzE/pl4PhfitGEok=;
        b=LoQoN0yCyUxNc2Xham2/S2VfavQxU8nSetYEfiFMRpUJZ3A/qzZLAHYLObPFIde0uh
         88CpadAtRI62/OQcn6wBOZr/Z2S50wOJsCCnTclZ+SlvVDEWSeVlKtDtjE+r7jT57hbh
         RAt7sqK0m90aVxjzWedIhSnayLu3Qlhm6bLsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VUAtKAQ/5lrXtwIpKP30Vc5c+LCIafefIO2QJuf1pGMzJrEQdXo7gDv1oN3yw8xo+b
         vjqgFnv5c35HwZbKpPAKhpQMT7M3OgUz4F26T83afi9wDqg1cfAudR/vuzX6qPUxqqgf
         wJ/Cg5PCILNTy7W796pP5aM8r4YDum+HQvJ6g=
Received: by 10.52.113.38 with SMTP id iv6mr2931581vdb.199.1303904577473; Wed,
 27 Apr 2011 04:42:57 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Wed, 27 Apr 2011 04:42:57 -0700 (PDT)
In-Reply-To: <BANLkTimqVs+Bg+zz7xu1Fb=a_dJ65WOvQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172223>

>
> We already have a plugin system, you can drop "git-work" in your
> $PATH, what you're talking about is a packaging system, and solving
> that problem in a user facing application like Git is IMNSHO a
> terrible idea.
>
> Instead you could just make gitwork available somewhere and then
> install it as:
>
>  =C2=A0 =C2=A0sudo aptitude install git-work
>
> Or whatever incarnation of that your distro or OS provides.
>
> Having our own "gpm" system would mean having to solve all these
> issues of distribution, cross-platform & arch compatibility that real
> packaging systems already deal with.
>
> If you *really* wanted to go through with this I'd suggest just using
> some existing package manager like apt, aliasing it to "gpm", then
> configure it to download packages from your own custom repository, an=
d
> install them in ~/ somewhere.
>
> You'd still be re-inventing the wheel, but at least minimally so.
>


No. As I explained in the posts
 that you chose not to read, such concerns would be dealt with by real
package managers.

One you have read those posts, let me know if you still have concerns,
humble or otherwise.

jon.
