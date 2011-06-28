From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Submodule URL
Date: Mon, 27 Jun 2011 18:28:18 -0700
Message-ID: <BANLkTinSbV4MQhM5zCDg7WtxKyBMWEqXaw@mail.gmail.com>
References: <BANLkTikyZxiW_t27Y4bXCPBjbJd_DYbOyw@mail.gmail.com>
	<201106272258.p5RMwOxK028539@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 03:36:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbNDc-00079e-Ho
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 03:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab1F1B3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 21:29:16 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55729 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab1F1B2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2011 21:28:19 -0400
Received: by yia27 with SMTP id 27so2066062yia.19
        for <git@vger.kernel.org>; Mon, 27 Jun 2011 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6g6G12t4JkHtUNGx7oV+M/nt10KXl7TV4/q4SzHdwi0=;
        b=RvZyIUmKFnmvE8v8bTk4EUAmC3diBmfuaW1gEAdmSGIrDz2kgqFhc9PjnOqeGS7xET
         4JT+6HMT5uEBaW03ZJ9GYLGiT6OPlzc2SmFvaVatGRycDK9cLjWa7iOhji2GDb498KA4
         AUM8nTh5iuQa3dCv6s16KzEastTB+RsQQHhKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LZoOiMOgbQlgF2S75mblcJIGGSjNRnhoX+hfYEBhkdmPyG3mjdugwOUpCOfZh0XBfO
         2SW6sSkRmyUkAsaCwXM208/pSrTgvl0m94cOeWwukpsiIoDe4jWLzRO7DLo6b1YiBIPk
         1FqG+LtFEqUmRlRq8/vIxxXM7CHsKa/PX7haI=
Received: by 10.236.145.2 with SMTP id o2mr9551105yhj.141.1309224498150; Mon,
 27 Jun 2011 18:28:18 -0700 (PDT)
Received: by 10.236.202.65 with HTTP; Mon, 27 Jun 2011 18:28:18 -0700 (PDT)
In-Reply-To: <201106272258.p5RMwOxK028539@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176378>

On 27 June 2011 15:58, Seth Robertson <in-gitvger@baka.org> wrote:
> In message <BANLkTikyZxiW_t27Y4bXCPBjbJd_DYbOyw@mail.gmail.com>, Hilc=
o Wijbenga writes:
>
> =C2=A0 =C2=A0As I was creating a script to support a question about s=
ubmodules I
> =C2=A0 =C2=A0ran into something that I don't understand. I've attache=
d a simple
> =C2=A0 =C2=A0script that fails to execute properly. I don't understan=
d why.
>
> Perhaps you should consider gitslave as an alternative to
> git-submodule, depending on your development workflow it may be bette=
r
> (or worse).

=46YI, yes, somebody read the entire tutorial and learnt something. ;-)

> gitslave (http://gitslave.sf.net) is useful when you control and
> develop on the subprojects at more of less the same time as the
> superproject, and furthermore when you typically want to tag, branch,
> push, pull, etc all repositories at the same time.

:-) Perfect! That's seems to be *exactly* what I need.

How hard is it to turn an umbrella project with content and quite a
few submodules (only 1 level deep) into a gitslave repo?

> git-submodule is better when you do not control the subprojects or
> more specifically wish to fix the subproject at a specific revision
> even as the subproject changes
>
> However, more directly to your question, we see that using absolute
> pathnames (not file: URLs) works. =C2=A0See
> https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial
>
> If this works for you and file:// does not, I'd say it was a bug in
> git.

Well, it seems like a bug to me then. Still, maybe I made a mistake in
my script. I hope somebody else can chime in too.
