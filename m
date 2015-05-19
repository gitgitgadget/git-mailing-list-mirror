From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Ensimag students contributing to git
Date: Tue, 19 May 2015 17:10:55 +0200
Message-ID: <CAP8UFD2hCScvEZxxFCc4XWLJuHM-SyqZ_x4sdmwXj8WVHrW4tQ@mail.gmail.com>
References: <722582475.919095.1431991277969.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<388720318.919104.1431991388837.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	galanalr@ensimag.grenoble-inp.fr, lespiner@ensimag.grenoble-inp.fr,
	pagesg@ensimag.grenoble-inp.fr,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 19 17:11:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YujAg-0001N4-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 17:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756427AbbESPK6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2015 11:10:58 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37529 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419AbbESPK5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2015 11:10:57 -0400
Received: by wibt6 with SMTP id t6so26590674wib.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=nL7o64oNFF338wMaSUfk08LK72NWfNjZ9gu2FzR0jJI=;
        b=Ius6224Pc7X6seuk9ifTwSMj83bGlJcDAFStbKZRC2uVlw0APymkffRwx3S/67xKhU
         Q7qZXSZsjZwDPa4g3fmOFcVIDxoJiun8pgTyg8tdUDFrZ99BEbrSpe2p0rxaT+uYnU/Z
         +UBeSrcnsLBjNZsQiCy0Vn8+Tk8bGGkN2BuE3KXWiGaEjCTwUVWAaFgGL72b4vf/BE4F
         D2cp59+BbfkEiJupkzyvepzMrA30LcoZi+5tYAvIgUirLtOAXirsWcDsIjmuinhmcEpY
         SJIOSxZibXb0n4FsdYR/rNz63lyXeNM5cwAVEbh+Sfq/EnXTP6IVHxs8N5aBnEqQjdL9
         7z3g==
X-Received: by 10.194.95.132 with SMTP id dk4mr56878820wjb.88.1432048255778;
 Tue, 19 May 2015 08:10:55 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Tue, 19 May 2015 08:10:55 -0700 (PDT)
In-Reply-To: <388720318.919104.1431991388837.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269360>

Hi,

On Tue, May 19, 2015 at 1:23 AM, Antoine Delaite
<antoine.delaite@ensimag.grenoble-inp.fr> wrote:
>
> We planned to work on =C2=AB git pull =E2=80=93setupstream =C2=BB for=
 the first days if nobody
> is currently working on it and then we thought of finishing the work =
of elder
> contributors from the ensimag on : =C2=AB git bisect fix/unfixed =C2=BB=
=2E

Last Autumn I started to work a bit on =C2=AB git bisect fix/unfixed =C2=
=BB (or
more accurately =C2=AB git bisect old/new =C2=BB) by applying and rewor=
king a
bit what your Ensimag elders had done. It is not much but maybe it can
help you a bit.

It is on this branch on my github repo:

https://github.com/chriscool/git/commits/boldnew1

There are only 3 original patches on this branch. The first one is
what your elders did and the other 2 are some small cleanups on top.

You will need to rebase and rework this, but it is a start.

Best,
Christian.
