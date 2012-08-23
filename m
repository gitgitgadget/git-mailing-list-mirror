From: David Aguilar <davvid@gmail.com>
Subject: Re: Git to use XDG Base Directory Standard
Date: Wed, 22 Aug 2012 19:57:16 -0700
Message-ID: <CAJDDKr6Jh0c9W1coQLOqrQKW-X7CCF9t_Nr2pW-7ivh0Ae9xrw@mail.gmail.com>
References: <50355044.7040201@gmx.net>
	<871uiy8uuw.fsf@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lanoxx <lanoxx@gmx.net>, git@vger.kernel.org
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Aug 23 04:57:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Nbw-0001pO-TD
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 04:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756695Ab2HWC5S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Aug 2012 22:57:18 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39597 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab2HWC5R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2012 22:57:17 -0400
Received: by vcbfk26 with SMTP id fk26so327841vcb.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 19:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Pce3LtMcrb+w7HsyTECrrMb1Qh67oXtcsIi1DkaTIlA=;
        b=BkeUILYaYG6sJtWmIK9U4A+1vsj763+f2VV+KofxiHWJgbv8NFKwSYD2O0Hpz9s9wl
         deB/U80GTQorQb7p3XFlMl4OoHIpAhQ5B/P65Mh7stO+XdI+g2Jl5mDyRBM9p+WlO9Ng
         +ed8TVc2XasXNzlJsXqjYVGQd+xyPCooLp2g4ZdX2LFfYw0R6fjidrWhDjAVRmuEqhkj
         /Nd+uUqC7I1khyuu8iSNsnJUH8fad+FwfkMGhVAm9ZadUjjC6zT3WucN5IOyz/a2LKNw
         Cf7d9LcGv49ivLdkbHiiJ+vKg7DgQLhF3gi2cg6Fhi9dltzb/4/aW/R2Ibc8aeWuJv2x
         x9pA==
Received: by 10.58.221.66 with SMTP id qc2mr20286600vec.30.1345690636530; Wed,
 22 Aug 2012 19:57:16 -0700 (PDT)
Received: by 10.58.173.104 with HTTP; Wed, 22 Aug 2012 19:57:16 -0700 (PDT)
In-Reply-To: <871uiy8uuw.fsf@centaur.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204108>

On Wed, Aug 22, 2012 at 2:44 PM, Carlos Mart=C3=ADn Nieto <cmn@elego.de=
> wrote:
> Lanoxx <lanoxx@gmx.net> writes:
>
>> Hi,
>>
>> Git and Gitk are currently using the ~/.gitconfig and ~/.gitk files =
in
>> the $HOME directory. It would be nice to use the XDG Base Directory
>> standard for the location instead, see [1] and [2]. Are there any
>> plans regarding this standard?
>
> Git does this starting at 1.7.12. See the release notes, e.g. at
> https://github.com/git/git/blob/master/Documentation/RelNotes/1.7.12.=
txt#L18-23
>
>    cmn

I do not recall whether gitk learned about it (I don't think so).

Like all big sweeping changes, these were done in a
backwards-compatible way that will allow users to switch over when
they are ready.  If you are interested in attacking this from the gitk
angle then you will want to follow a similar strategy.
--=20
David
