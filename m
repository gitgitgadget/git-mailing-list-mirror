From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Unmodified submodules shows up as dirty with 1.6.6.443.gd7346
Date: Mon, 18 Jan 2010 08:02:26 -0800
Message-ID: <8c9a061001180802t5ec0d389j2cae9f1771130c36@mail.gmail.com>
References: <4B547EA6.5070203@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Mon Jan 18 17:02:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWu42-0005nv-Sy
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 17:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab0ARQCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2010 11:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754260Ab0ARQCr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 11:02:47 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:57483 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab0ARQCq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Jan 2010 11:02:46 -0500
Received: by pxi12 with SMTP id 12so3545115pxi.33
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 08:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wawiTfDlzP2G71HVHswUdACEdlx5m/IRyJtz27lBg5s=;
        b=fdUU7DsYKpg2nNhmgGL0AjndYm7gk0AL5OwAqi+ABuIrj/NK0Xfwgu+57TmPLAZqb6
         xHaEKgkq3B+bNPPn9VX7O5GdUE8SMXAuK61v810WTUVG0256KCwT1+C4vEcwnwQtEHXt
         UEDigcNirNY0TboRQaOyXhLRR92XUtAFrCC9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nYiEBGIusKZdatSqGrY7NAkZRD9B1Lq8VuPCH2S8UNAmuLAlj/OYfvTbpuzGWZFiXF
         /DWBrvEMkFSYE4a5PgDbONjl27/QoXtzv7fttVCmkmaVWMffGzJOw4XeQ58MbA1e+XUW
         pRdJEhPAUF19JJ/pdD44spi7u0Fa2+kCMMX6E=
Received: by 10.140.180.7 with SMTP id c7mr4462927rvf.168.1263830566060; Mon, 
	18 Jan 2010 08:02:46 -0800 (PST)
In-Reply-To: <4B547EA6.5070203@isy.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137388>

On Mon, Jan 18, 2010 at 07:30, Gustaf Hendeby <hendeby@isy.liu.se> wrot=
e:
> Hi!
>
> I have been using submodules for a while, and been quite happy with
> them. =C2=A0Just updating to the latest next (1.6.6.443.gd7346), a st=
range
> problem has occurred. =C2=A0All my submodules (which are in fact unmo=
dified)
> show as modified and dirty
>
> diff --git a/extern/utils b/extern/utils
> --- a/extern/utils
> +++ b/extern/utils
> @@ -1 +1 @@
> -Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1
> +Subproject commit 6bad20e1419f1ca61bd5a6eef9b5937122e006f1-dirty
>
>
> Anyone have an idea what is going on here? =C2=A0(Related to the rece=
nt topic
> by Jens Lehmann? cc:ed) =C2=A0Unfortunately, I don't have the time to=
 dig
> into this right now, but I'll try to do it later tonight if the probl=
em
> remains.
>
> /Gustaf
>

Do you have any untracked files in the submodule?  git status is
working as I would expect with the same version (1.6.6.443.gd7346).

If there is no output from git status in the submodule, then git
status in the superproject shows the submodule as being clean.
However, if there is _any_ output from git status (untracked files,
modified files, deleted files, new files), then the superproject shows
the submodule as being dirty.

-Jacob
