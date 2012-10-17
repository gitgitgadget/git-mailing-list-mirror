From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new git-remote-hd helper
Date: Wed, 17 Oct 2012 20:33:07 +0200
Message-ID: <CAMP44s2-BCuA5v7jE8S3d-Gg+DxKf6Yte9MvTDBDr4jEkLKZ9g@mail.gmail.com>
References: <1350478721-3685-1-git-send-email-felipe.contreras@gmail.com>
	<alpine.DEB.1.00.1210171759230.3049@bonsai2>
	<CAMP44s1WY+Q7jyy4PQvwff7JSxHsnkhrPWozOLnNuNOrn7FGBA@mail.gmail.com>
	<alpine.DEB.1.00.1210171936170.3049@bonsai2>
	<CAMP44s2=hhMz35SpYXMBLcQPfVaPxY4pBWZDF7zbqVwz=tbedA@mail.gmail.com>
	<CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOYQk-0004Go-Bn
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 20:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612Ab2JQSdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 14:33:10 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45449 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab2JQSdI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 14:33:08 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7760049oag.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Mlw/wrPVV7C1y6bHtolvtU4prd5f/MrAfnM9YDQYNT4=;
        b=WLPFA8O5QFh4K3124ZedAR/RSj4IKNB2WPelZzbplL9/s0p9NB+ZorP0ZRqjz8EjsY
         rDFp7PbqraYAW+lop1WO+fWJ6fbP9IcyLbI+f8osmzhSGBUr/7RHvvaxigyr0+1wI5KS
         SqjQFbg7EuKBxDhisVF41gejnBpnJgZbSeYqaPxRx/rschAL3MyY8mrnHyCOtzU2MpMR
         5D+5QM25e4qPxDG0EF0S3QdFsPZM7Z5H4aA9mQRO+DH9mlpsE7H76yUMemUNc5sSjP1e
         tYCl/JWxoX7pQhE7WtBbt92WQMYf/kf/PcLsbi7tihHub92eWoeEzY+uQgh6adPJDxH1
         /pAQ==
Received: by 10.60.27.71 with SMTP id r7mr16259424oeg.96.1350498787368; Wed,
 17 Oct 2012 11:33:07 -0700 (PDT)
Received: by 10.60.58.137 with HTTP; Wed, 17 Oct 2012 11:33:07 -0700 (PDT)
In-Reply-To: <CAGdFq_i4c=ei4ni5bv9nNEbCfNG4sbRkqyip2voW17GhkRAKPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207935>

On Wed, Oct 17, 2012 at 8:18 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Wed, Oct 17, 2012 at 11:12 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> But fine, lets remove the tests out of the equation (150 lines), the
>> number of lines of code still exceeds 3000.
>
> I don't think it's fair to just look at LOC, git-remote-hg when it was
> just parsing was fairly simple. Most of the current code is our copy
> of the python fast-import library which is only used to support
> pushing to mercurial.

Well, as a rule of thumb more code means more places for bugs to hide.
It is also quite frankly rather difficult to navigate; very
spaghetti-like. I have the feeling I can implement the same
fast-import functionality in a much simpler way, but for now I want to
concentrate on fetching, and hopefully making it easy for people to
actually use it.

I would like to cooperate as much as possible, but as I said, I would
rewrite a lot of that code. And also, I'm not even sure which
repository contains the latest version of this code. I've seen a
couple of them that are quite different, and none which are based on a
recent version of git.

Cheers.

-- 
Felipe Contreras
