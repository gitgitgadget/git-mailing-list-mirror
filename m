From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: How to split a big commit
Date: Mon, 4 Apr 2011 21:25:38 +0700
Message-ID: <BANLkTinpiR2sHS35uqD+uLnTKVtimhT7eg@mail.gmail.com>
References: <BANLkTikFXzut7fY5Tr0u-abu5Q0rMUOCmA@mail.gmail.com> <20110404130016.GA16975@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 16:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6kjo-0007bw-Q1
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 16:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471Ab1DDO0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 10:26:32 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:55564 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429Ab1DDO0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 10:26:31 -0400
Received: by pxi2 with SMTP id 2so1990851pxi.10
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ioafDeA+G+It24k9cJhQ+NY3J0V02rEE28swpfxZCHU=;
        b=iOlnVjNjQRRR8+3w/WPOTq+kOUKNHYP0LQ19tnvu0jlgVkEkgIn2dznZHn2PLPPA5Q
         JVfrWY57dDzDsDrgb6eufAS8nHrkb2yhYZ9QN5qO2+JU5qwUkhSDevF9A7OQmUsBtKuh
         cNHMdyhw5XdDBLByZrl0BWs98LXtS/qu/PnWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CU9VUz0FsxvWkhYvroCCgyrrctkEeoIHkFLByy9anyimjqpIxd7/B77u+bEg2+d0f0
         MAQ1srdiKVOTnA4JMbAopYeV8mIm3ilkOiBAumsK3Gc20gVu8tJyi3vpQbeDeNlJSDMy
         jyJK8FO1KH2a8ldLfJrseGsBwX2hNCjjbsUpE=
Received: by 10.142.76.16 with SMTP id y16mr6470577wfa.157.1301927168124; Mon,
 04 Apr 2011 07:26:08 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Mon, 4 Apr 2011 07:25:38 -0700 (PDT)
In-Reply-To: <20110404130016.GA16975@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170812>

On Mon, Apr 4, 2011 at 8:00 PM, Ramkumar Ramachandra <artagnon@gmail.co=
m> wrote:
> To split a big commit, I simply reverse-diff-apply the changes that I
> don't want in the big commit, and I stage all changes. =C2=A0Then, I =
again
> reverse-diff-apply all the staged changes, and keep that in the
> unstaged portion.

Won't work for me. The reverse part would be way larger than the to-com=
mit part.

> ...
> I can afford to do this kind of jugglery very easily because I use
> Magit with Emacs. =C2=A0After highlighting the relevant portions,
> reverse-diff-apply is one keystroke :)

Hmm.. interesting. Never got around to actually use magit. I may have
a good reason now.

> But yes, you're probably right-
> there should be an easier way to do this. =C2=A0Maybe a 'git split' t=
hat
> allows you to interactively select the portions of an existing commit
> that you'd like to exclude from the commit and turn into a new commit=
?

Hmm..yeah something like grep for chunks, then automatically splitting
those chunks out would be nice.

I have another use for such a tool too. When .po files are
automatically updated by intltool (gnome translation helper tool),
comment lines are all changed because they contain source line and
those line likely change. With this tool I can filter out comment-only
changes.

Thanks for the idea.
--=20
Duy
