From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 07/10] gitweb: remotes view for a single remote
Date: Mon, 25 Oct 2010 20:18:18 +0200
Message-ID: <AANLkTi=LiE3=fKdxeQU8HsKLia1ur2k2CDtqDhALj234@mail.gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1287917136-26103-8-git-send-email-giuseppe.bilotta@gmail.com> <201010251712.30362.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 20:18:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PARd9-0000lZ-4J
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 20:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324Ab0JYSSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Oct 2010 14:18:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48898 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542Ab0JYSSk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Oct 2010 14:18:40 -0400
Received: by ywk9 with SMTP id 9so2317089ywk.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 11:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=I4JBORLm4mjaybSSBmgD1pip7OLk1YJCw740dhnPAwI=;
        b=eJZFcrZ1VlSXDsi4Cp4LazxxEWmCWgdHkJghVHLh9y6HfCiM3TFju2sLpJAqOEY8F6
         odNNG/4d6whDOcJ74OHv+ZHHx3pB+itZbuYJERrheqz90BZ5n5ZvqemyW05do9/lJ+Y6
         RJkOP10GORiOOVk3lf4XOzbmkC0IaVser2do4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qM0VkvG434kqL2DAfpSjApC1OekmFeUvyomcByIZwUOsQyZrvTV3GnvT2lAYphi7R1
         V1aVa4gS2/TEX8LCKauZDN3FtOjX1Ikg/7dcCGTocFNwXxyNWt/WBjH/1+IXY5+vlrQQ
         Bky+vPLskISClxYls+czW3YHogX6/l6n2HIt4=
Received: by 10.42.214.135 with SMTP id ha7mr5371966icb.275.1288030719938;
 Mon, 25 Oct 2010 11:18:39 -0700 (PDT)
Received: by 10.231.149.141 with HTTP; Mon, 25 Oct 2010 11:18:18 -0700 (PDT)
In-Reply-To: <201010251712.30362.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159965>

2010/10/25 Jakub Narebski <jnareb@gmail.com>:
> On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:
>
>> When 'remotes' view is passed the 'hash' parameter, interpret it as =
the
>> name of a remote and limit the view the the heads of that remote.
>
> I don't quite like (ab)using 'hash' parameter like that, but because
> it allows us to use e.g. 'project.git/remotes/origin' path_info
> without writing special code for that, I am all right with this hack.

We could rename the 'hash' parameter to be more descriptive of the
fact that it includes this nature, but I really think it's not worth
it.

>> In single-remote view we let the user switch easily to the default
>> remotes view by specifying an -action_extra for the page header and =
by
>> enabling the 'remotes' link in the reference navigation submenu.
>
> Nice!
>
>> + =A0 =A0 if (defined $remote) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 # only display the heads in a given remote
>
> It also strips uninteresting '<remote>/' prefix, isn't it?
> It would be nice, though not necessary, to have this in comment.

Good idea.
--=20
Giuseppe "Oblomov" Bilotta
