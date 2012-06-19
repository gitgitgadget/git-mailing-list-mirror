From: jaseem abid <jaseemabid@gmail.com>
Subject: Re: 'git branch' when origin branch with same name exists
Date: Tue, 19 Jun 2012 20:48:57 +0530
Message-ID: <CAH-tXsAoRj2oE76Mrv4jGCKDbzOihPZJF+0OTEpB1Ojf7CDv8A@mail.gmail.com>
References: <4FE091FB.7020202@desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ryan Lortie <desrt@desrt.ca>
X-From: git-owner@vger.kernel.org Tue Jun 19 17:19:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh0Dc-0003X1-Fn
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 17:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280Ab2FSPTk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 11:19:40 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60921 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab2FSPTj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2012 11:19:39 -0400
Received: by wgbdr13 with SMTP id dr13so6925445wgb.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fVF4sPrb1mtr2TynVijOrIyn1sncYp0LqYyTQlvFkO0=;
        b=FTsLIegx+vEvSYjFOF2vEXoFomwgc056bRlTLCuo1C+RQEF9DJUVN30Juib0y0XoFC
         z1AP/IupH9nLiQ68RVZgj11JfmLzfF5q0EntDEY0SqZEM6hk19Oo3uLKZLrK2C9y4niN
         gxerRjS53EcvazSCaoycNbzb2EruiN4QCF3owOAQWllDBRuVrTqNLebFzEPbqkmweUbv
         IjC+uY5ej/VkRVuNajwF32OG6E5WdTyiW3l8++14+fQDCamHx03bGGWgJLKhG3aVRWcI
         4QgWtYj3dmbbfLkakPIJHboKHWBC9Q0np5/5ME5l774eV9jmwzbxNlMd9GFNTq/SP8PF
         wAVg==
Received: by 10.180.83.197 with SMTP id s5mr4313016wiy.9.1340119177784; Tue,
 19 Jun 2012 08:19:37 -0700 (PDT)
Received: by 10.227.37.22 with HTTP; Tue, 19 Jun 2012 08:18:57 -0700 (PDT)
In-Reply-To: <4FE091FB.7020202@desrt.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200206>

On Tue, Jun 19, 2012 at 8:21 PM, Ryan Lortie <desrt@desrt.ca> wrote:
> hi,
>
> After helping someone on IRC who got themselves into a bit of a probl=
em, I
> have a feature request for git.
>
> In this case, the user wanted to checkout a branch of a module. =C2=A0=
They did:
>
> =C2=A0git clone git://git.gnome.org/gtk+
> =C2=A0cd gtk+
> =C2=A0git branch gtk-3-4
>
> Obviously this is a user error, but it's a pretty innocent one, and p=
uts the
> user in a bad state. =C2=A0When they figure they should have typed "g=
it checkout
> gtk-3-4" it is already too late -- they will be taken onto their
> locally-created copy of the master branch.
>
> So feature request: 'git branch' should not allow creating a local br=
anch
> that has the same name as a branch that already exists on 'origin' (o=
r any
> remote?) without some sort of --force flag. =C2=A0It could instead he=
lpfully say:
>
> =C2=A0"""
>
> =C2=A0 =C2=A0The branch you are trying to create already exists on th=
e origin.
> =C2=A0 =C2=A0Are you sure you don't want to checkout this branch usin=
g
> =C2=A0 =C2=A0'git checkout gtk-3-4'
>
> =C2=A0"""
>
> or something like that.
>
> Thoughts?

Dont know much about this but to me it looks like a good feature.

--=20
Jaseem Abid
http://jaseemabid.github.com
