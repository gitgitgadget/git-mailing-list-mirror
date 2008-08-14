From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: Why doesn't git-apply remove empty file
Date: Thu, 14 Aug 2008 21:42:22 +0200
Message-ID: <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com>
	 <7vod3xpxq2.fsf@gitster.siamese.dyndns.org>
	 <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com>
	 <48A357BA.8060003@lsrfire.ath.cx>
	 <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 21:43:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTijY-0004GP-5a
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 21:43:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbYHNTmY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 15:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbYHNTmY
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 15:42:24 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:28777 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbYHNTmX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 15:42:23 -0400
Received: by rv-out-0506.google.com with SMTP id k40so563030rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 12:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=UeOCK9m6IhYroPEsNJlh1Ye9Tu0in8eEboAehgt9+1g=;
        b=FAJKOCfTIKWm8ntTL6NQXJ/9h/KscMGffwGsgde/b1/naO4V0w0xwXx5xw9d84+psm
         gnN8816mpLuHkJ2gBmTISogXVrAQEGSOiaVKXhyx3FmBeRkCZTR0o0lSA+R8BugGtXkS
         d4wTZRxKG51IoqF83EpGAoXh2N2/GMjqw/lxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jcvC/aByGV5ahnYg/V8jNNL7JBOXPioSuOX45BXpzDXSkOOKKHL+290hJI8J+SMeSl
         ukF61LOUkVtcRAuGkp3zywRiCEteGxOqblDsYz/aKzpNyQL0KoCMvj3M35sqGCHMu+Rc
         D5Rouj2b6ucd1grgOyWLhnN+Za8r3lW8VGLMw=
Received: by 10.141.176.4 with SMTP id d4mr981251rvp.14.1218742942742;
        Thu, 14 Aug 2008 12:42:22 -0700 (PDT)
Received: by 10.140.170.16 with HTTP; Thu, 14 Aug 2008 12:42:22 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92390>

On Thu, Aug 14, 2008 at 1:09 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> and no, git never did that file date thing, so git acts differently from
> GNU patch in this thing (as in so many others, for that matter).
>

Well patch(1) is so used out there that makes git-apply often do the
wrong thing for such corner cases when applying a patch made by
patch(1).

Maybe git-apply would be more friendly regarding patch(1) if it has an
option to emulate GNU patch for some situations. Or if this means
adding too many quirks in git-apply code, maybe give the possibity for
git-am to use patch(1) instead of git-apply.

-- 
Francis
