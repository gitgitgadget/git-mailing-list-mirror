From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor bug with help.autocorrect.
Date: Fri, 21 Aug 2015 09:10:35 -0700
Message-ID: <xmqqsi7c7hc4.fsf@gitster.dls.corp.google.com>
References: <CA+cck7Ex4UO9BAzZ1kq5jw1vYqFb+mbzNQh-RvYAvK5v2T4G0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 21 18:10:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSotu-0001u4-CU
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 18:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbbHUQKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 12:10:37 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36032 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbbHUQKh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 12:10:37 -0400
Received: by pdbmi9 with SMTP id mi9so28118737pdb.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 09:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=yqFNo1vsuZdcliiQ7fYJ3XwyFt0yXRp9w/Gl8JVnRjo=;
        b=PpPWQkrnvsD1PJj7Qp2lY6S84bY/Az2qO9hoc6SDdXwyD8CO2BBB5UYd3AcWMXY7bA
         cB3dq3SYIoNkB7Ybvx+COYpumvN2v9fsH/lC3fkdRyZQZ8EuuNP5iMOSJC7b08olfvh7
         1F9VRuxJgjgbWQvOh0PBskwhfEExZX4X5oKnGkYESVIHh4hM9HTrfy4h5t9xGNZ5Q2Pl
         E9HZD9xN5dMEmnDsKu1fI9lwjrUqBXRZKj/8+0TG/7hQ4vdUQl/Zo9/2JpQ++QXUjpja
         vg3vUbHQeNYL5HottvVWJW1J3JRh6GivN4E8utOcqj/HpXdLWDWy+GamjvWxwa1yIFAB
         C4rQ==
X-Received: by 10.70.48.40 with SMTP id i8mr18699680pdn.10.1440173436557;
        Fri, 21 Aug 2015 09:10:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id im2sm8302812pbc.34.2015.08.21.09.10.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 09:10:35 -0700 (PDT)
In-Reply-To: <CA+cck7Ex4UO9BAzZ1kq5jw1vYqFb+mbzNQh-RvYAvK5v2T4G0g@mail.gmail.com>
	(=?utf-8?Q?=22Bj=C3=B8rnar?= Snoksrud"'s message of "Wed, 19 Aug 2015
 12:35:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276307>

Bj=C3=B8rnar Snoksrud <snoksrud@gmail.com> writes:

> If you mis-type a git command starting with a non-letter, git
> internals will spit out some errors at you.
>
> $ git 5fetch
> error: invalid key: pager.5fetch
> error: invalid key: alias.5fetch
> git: '5fetch' is not a git command. See 'git --help'.
>
> Did you mean this?
>         fetch
>
> $ git \#fetch
> error: invalid key: pager.#fetch
> error: invalid key: alias.#fetch
> git: '#fetch' is not a git command. See 'git --help'.
>
> Did you mean this?
>         fetch

Thanks.  I somehow thought that we had some discussion on this
earlier, perhaps

  http://thread.gmane.org/gmane.comp.version-control.git/263416/focus=3D=
263438

Peff, do you remember what (if anything) we decided to do about
this?  I unfortunately don't X-<.
