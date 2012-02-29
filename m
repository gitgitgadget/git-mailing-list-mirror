From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: Building GIT on older systems.
Date: Wed, 29 Feb 2012 15:35:24 -0500
Message-ID: <CAPBPrnvFv4-r0m7-A5q5Lt7V5Ym2hEJaiNONBcUC=cxs6WuPxg@mail.gmail.com>
References: <CAFqtsHfrk89qHexg8VwMZnKwgWDqbseJNNKFSUkwDtVKX_t=5g@mail.gmail.com>
	<CAFqtsHd=b=Ey8j1zTCC4-fut7rno3daQ2Q3HMs3k2SHFvE4dSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Schumacher <schumact@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 21:35:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2qFH-0007u7-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 21:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab2B2Uf0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 15:35:26 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41989 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab2B2UfZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 15:35:25 -0500
Received: by vbbff1 with SMTP id ff1so3073941vbb.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 12:35:24 -0800 (PST)
Received-SPF: pass (google.com: domain of computerdruid@gmail.com designates 10.52.22.166 as permitted sender) client-ip=10.52.22.166;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of computerdruid@gmail.com designates 10.52.22.166 as permitted sender) smtp.mail=computerdruid@gmail.com; dkim=pass header.i=computerdruid@gmail.com
Received: from mr.google.com ([10.52.22.166])
        by 10.52.22.166 with SMTP id e6mr2674565vdf.5.1330547724760 (num_hops = 1);
        Wed, 29 Feb 2012 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=18VXBAXDRffDVclzz3IFdBksvMtjAHewddmgShfiAXY=;
        b=erEkZYaL6bPx6R4dESHgayb35sZxH6lrpmMIe/S0VhrVO5NPoV7EgqD5XbumxXQfY7
         igkw2oWWjSJrrx/QS1kKL26FlMJCKqmVPG2lFY+TXcZl8m6jnUyLGE1N25a/eHuMNQEX
         PjOoNEAEZtZIzBMcWUNOIiO8xMYllRMpuOUbo=
Received: by 10.52.22.166 with SMTP id e6mr2292561vdf.5.1330547724716; Wed, 29
 Feb 2012 12:35:24 -0800 (PST)
Received: by 10.220.188.138 with HTTP; Wed, 29 Feb 2012 12:35:24 -0800 (PST)
In-Reply-To: <CAFqtsHd=b=Ey8j1zTCC4-fut7rno3daQ2Q3HMs3k2SHFvE4dSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191853>

On Wed, Feb 29, 2012 at 3:22 PM, Tim Schumacher <schumact@gmail.com> wr=
ote:
> [snip]
> A couple questions I have so far:
> (1)=C2=A0 how can I make make output the actual command it is executi=
ng so
> I can try to debug things more quickly?

Try running "make V=3D1".

I'm not knowledgeable enough about the makefile or the perl
requirements of git to help with the other problems, though, so
someone else will have to step up for that.

Good luck!
