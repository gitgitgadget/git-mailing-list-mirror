From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 21:16:54 +0700
Message-ID: <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
References: <5509836D.2020304@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 15:17:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYEmo-0007ti-Jy
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 15:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934044AbbCROR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 10:17:26 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35475 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932958AbbCRORZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 10:17:25 -0400
Received: by igcau2 with SMTP id au2so63801864igc.0
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SNkZsySD4nFrU+YSAbWflJbDKFGscM44FxRJXhNbTog=;
        b=ozFprdzmZ1kYO89XZkaDhtK8gsK6fLzKnHOlfSxfFCT87qd0P58CaB0yr8wzEI5XIk
         cFZMYkTGjK17QnHFzTvpxDbqgyY+8AJqUDP9OE8Nf0IJTYf6cr8Ys2HZdgfE8ovJXIZJ
         iHqgZfOqBgiRZz24dIbebVXLJnnlccmzP6qhDULJWo0ikqRs2lZMqEoJCThfBScIZhLS
         dHgYAWLuWZREWf77tac01/qAodOE8pZgZgTtY0gjxB1rKrR1+PCFWlrtJ1X+yVpTfTKq
         BJv+j8uxat6pP1UT3M2DPdgZkiz7pBdIxfdOdXLW68+f6pv6hTSW6kW+oOUtvZ6zeFQd
         X1ZQ==
X-Received: by 10.42.87.131 with SMTP id y3mr40439165icl.45.1426688244764;
 Wed, 18 Mar 2015 07:17:24 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Wed, 18 Mar 2015 07:16:54 -0700 (PDT)
In-Reply-To: <5509836D.2020304@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265731>

On Wed, Mar 18, 2015 at 8:53 PM, =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=
=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=D0=B2
<dilyan.palauzov@aegee.org> wrote:
> Hello,
>
> I have a local folder with the git-repository (so that its .git/confi=
g
> contains ([remote "origin"]\n    url =3D git://github.com/git/git.git=
\nfetch =3D
> +refs/heads/*:refs/remotes/origin/* )
>
> I do there "git pull".
>
> Usually the output is
>   Already up to date
>
> but since today it prints
>   Auto packing the repository in background for optimum performance.
>   See "git help gc" for manual housekeeping.
>   Already up-to-date.
>
> and starts in the background a "git gc --auto" process.  This is all =
fine,
> however, when the "git gc" process finishes, and I do again "git pull=
" I get
> the same message, as above (git gc is again started).

So if you do "git gc --auto" now, does it exit immediately or go
through the garbage collection process again (it'll print something)?
What does "git count-objects -v" show?
--=20
Duy
