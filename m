From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 5 Dec 2010 10:18:47 -0200
Message-ID: <AANLkTinAT3kotKQTS6eS1SLigNzSp6grAU7WNRbHf3N=@mail.gmail.com>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
	<20101205021837.GA24614@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 13:18:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPDYN-0002BU-Kx
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 13:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab0LEMSt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 07:18:49 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50650 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab0LEMSs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 07:18:48 -0500
Received: by bwz15 with SMTP id 15so9744898bwz.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 04:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+jKwM6f4LoJJIWWnC+Rfz+eHGUMtXKY0u5YyI6r4r3k=;
        b=R3SAAQRjoSE9gFEa3xRFBNBA0j4JBsBNSZvQiTD8N8oaInsBqB5OtkUF79kgWMpJyy
         EdqVb8hsNaQv+BrA5W3bnDSXaCQewnwvB4BZX+32QcdwLp7zAsU766EJPK/Vr35MTi6A
         0RFxC3xKrzLXYYG0gH8lWNmQbtMcupQSBRI6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lWeEMf8Wj5aO79surwnWKOwH+fGH3AiPSEVNIAw9HDcCxkWGiwdgdI6rDGb0lEZmL5
         05yxmYLd2kkJS5gfzGCLzm07XEPlhxof7s+DHG9+M/KpWFJCA0f2olgbZmOh+t+gxvS4
         Y7k801v+7DSqL9IsPpj8fYrch0nJa4FXxNERU=
Received: by 10.204.59.81 with SMTP id k17mr4611414bkh.148.1291551527414; Sun,
 05 Dec 2010 04:18:47 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sun, 5 Dec 2010 04:18:47 -0800 (PST)
In-Reply-To: <20101205021837.GA24614@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162945>

On Sun, Dec 5, 2010 at 12:18 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Thiago Farina wrote:
>
>> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
>
> I know that the context is part of an effort to make the commit_list
> functions into something more of a self-contained API, but the
> reader does not know that. =C2=A0Perhaps you could say some words abo=
ut
> that in the change description: what's wrong with the current
> situation, what context does this change come from, and what positive
> effect would it have?
>
> Beyond that, I must say I do not think this goes far enough to seem
> useful. =C2=A0If I wondered what reduce_heads did, wouldn't
> commit_list_reduce_heads be even more confusing? (ignoring the typo)
>
> Perhaps a more natural way to proceed would be as follows:
>
> =C2=A0. first, collect the functions to be treated as a module and
> =C2=A0 list them in Documentation/technical (in this case, perhaps
> =C2=A0 api-revision-walking or a new api-commit-list)
>
What you want here? That I describe the functions in these files? Why
me? Why not the person who wrote them?

> =C2=A0. next, describe their current meaning. =C2=A0If this requires
> =C2=A0 apologizing for the name,
Apologize? For what? I don't understand what you mean here.

> that's a good hint that a name=C2=A0 change might be worthwhile
>
> =C2=A0. finally, tweak signatures (names and arguments) based on the
> =C2=A0 results from step 2 and update the documentation at the same
> =C2=A0 time.
>
I'd prefer to do just that step.

> That way, people used to the current functions would at least have
> some documentation to help them adjust. =C2=A0What do you think?
>
I think it's a good procedure for someone more familiar with this
functions to do this. Perhaps, you or Junio?
