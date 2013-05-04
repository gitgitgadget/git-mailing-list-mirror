From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Another use of "@"?
Date: Sat, 4 May 2013 10:26:08 +0700
Message-ID: <CACsJy8DsrY9ybLoCAo35Puc7oR41Kda9nKjBXL147qN-3xrMRA@mail.gmail.com>
References: <CACsJy8AcWV8hmbhG27dw+GdnZf8NnQEctYmowqd3sSzOOHf+xg@mail.gmail.com>
 <7vr4hozie1.fsf@alter.siamese.dyndns.org> <vpqy5bvaf6x.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat May 04 05:26:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYT7U-0003Bk-52
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 05:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029Ab3EDD0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 23:26:40 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:63054 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656Ab3EDD0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 23:26:39 -0400
Received: by mail-ob0-f172.google.com with SMTP id xk17so1945353obc.31
        for <git@vger.kernel.org>; Fri, 03 May 2013 20:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dROS4Y0B2FCukbJoldJ/00vdUAfgiBMunK0/FRZiVc0=;
        b=srIPvWX3cR5p2n9p6j6fSVyxF215b2LQFDXca6Dsk6dyC/sX1PmueB2HZMS3N4jngf
         /gSmllHKypWt9bxK5KTadZ9skMBARzGQgthyC7e+1dOs7myaco90PX135zCrHSTwhTlI
         23XzDEw2YB3tQ37PuvXKMGaj4unAkyen8W2VhWUy5hEWl9Y2cFQ8I4XUuxSfIxlJ9HQQ
         Ua7gLu/CydscIGgRU8XFrW2N58XJugkS6w2lZpN4NQzptlBZzl6S7fJtYXC8eaF4chVb
         EgUWOI1hRRQOwfUy73ZMPO7/I+KNYXYb9rmrQjjtxibJZtU6Zk4domfo/uWXPRQv7RCL
         pbcg==
X-Received: by 10.182.80.201 with SMTP id t9mr3573413obx.52.1367637998828;
 Fri, 03 May 2013 20:26:38 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Fri, 3 May 2013 20:26:08 -0700 (PDT)
In-Reply-To: <vpqy5bvaf6x.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223352>

On Sat, May 4, 2013 at 5:09 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> The A/@ could make sense, but I'm wondering whether we're taking the
> direction of implementing some kind of Brainfuck dialect in Git revision
> specifiers. I'm not sure we want to add more special characters here and
> there with subtly different meanings (@ = HEAD, @{1} = HEAD@{1}, A/@ =
> A/$(git symbolic-ref --short HEAD)).

Another subtle overloading of @ that might be desirable (althought
might be achievable another way). "git log -g"  is equal to "git log
-g HEAD" but there is no easy way (that I know of) to do "git log -g
$(git symbolic-ref HEAD)". "@" could fill the inconvenient spot here,
I think. Alias is no good because I won't be able to add extra
options.
--
Duy
