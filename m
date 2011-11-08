From: Emily Ren <lingyan.ren@gmail.com>
Subject: Re: how to merge sub directory or file?
Date: Tue, 8 Nov 2011 15:08:00 +0800
Message-ID: <CAP_m3yKehN1-KtMCVxKdu2ca59GzYE0w2X2=UhH2X9PgzYiMAg@mail.gmail.com>
References: <20111107172652.0faade61@ashu.dyn.rarus.ru>
	<8B3D19E0-2181-4E9C-943F-CA26A399E0D9@gmail.com>
	<20111107193708.6cf2ae81.kostix@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 08:08:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNfmy-0006s4-J9
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 08:08:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab1KHHID convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 02:08:03 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36723 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab1KHHIA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 02:08:00 -0500
Received: by iage36 with SMTP id e36so225628iag.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 23:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0/voPrJR42x0oPuqlPmk6PjBP4Muxhzrl10fn9ulark=;
        b=ivX8P0Av7TYYcl5ce/opfjRRdk6Thxc956CvsAADqZTyYcX87VJaw0cKTL2OPmlkPf
         cYAb7ZX8UPghN8rtTdj5o3blkZmJn8LHYJHCIZIU+wMzPctfJfxGG03ua4EzVniIeCoX
         PV5K8CHsvG0uozkJSUeGbHPzbyo+C0TbnD0dE=
Received: by 10.42.202.17 with SMTP id fc17mr51136899icb.15.1320736080042;
 Mon, 07 Nov 2011 23:08:00 -0800 (PST)
Received: by 10.43.43.195 with HTTP; Mon, 7 Nov 2011 23:08:00 -0800 (PST)
In-Reply-To: <20111107193708.6cf2ae81.kostix@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185076>

Hi Kon,

Thank you !=A0 I tried that method, it failed on read-tree because
B/dir3 already exists, Cannot bind.

$ git read-tree --prefix=3Ddir3 -u A:dir3
error: Entry 'dir3/file1' overlaps with 'dir3/file1'.=A0 Cannot bind.

And my case is that not all A's sub direcotries are in B.
=46or example, in A's dir3, there are file1, dir4 and dir5. But in B's
dir3, only file1 and dir4 exist, there's no dir5. How to handle this
case ?

Thanks,
Emily

On Mon, Nov 7, 2011 at 11:37 PM, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
>
> On Mon, 7 Nov 2011 22:54:18 +0800
> Emily <lingyan.ren@gmail.com> wrote:
>
> > I have two git projects A and B, content of B is subset of A. For
> > example, Project =A0A and B's tree are as below:
> [...]
> > When there's new changes in project A, how can I merge them to
> > project B without changing B's directory structure?
> >
> > Your help will be highly appreciated.
> Subtree merging maybe?
> See http://progit.org/book/ch6-7.html
