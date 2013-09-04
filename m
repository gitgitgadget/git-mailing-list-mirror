From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Wed, 4 Sep 2013 09:13:55 +0200
Message-ID: <CAA01CsqNKMqExq1PYanotzQ-wTcf=7c5BQ_49xGu4QasXSCoeQ@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
	<b677f1ae-662f-4728-b625-189bc392c74d@email.android.com>
	<CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 09:14:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VH7Ht-0006vF-Uw
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 09:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762034Ab3IDHN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Sep 2013 03:13:57 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42141 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756366Ab3IDHN4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Sep 2013 03:13:56 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so3464408eek.5
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=DfbPFwEytoWAFv9+rFrsAMxtoslB3UTEEjR+hlrv01E=;
        b=vRxXfFYZ4y16ruBsJRYtwB5TPC6PIK+AzLs5lS/Pa9gvmpN+OAGJ2Ehpq1bNWngukM
         Uu7yBNMxpC/UmCQA4g4B4w+p/nCyXmzgLNLs15SD120IIcD2juF1FpG4cdX8Zzm2yXuX
         AbrIdU4XyOeHaff7il1jl+RiIp9bECHdCwvIP6dsv2ILMCWMVvFMVpNV75rToEqbEJCA
         h2GDEpQ0HttHhBg4iB+OSjCz7RJmXF6B1Kh71o6O0LbASe8Hd9wUCWod9WzGLtK3n8p+
         4OytDXd4Q88TlvyjD4TZhjEyyO5ydOFGoZHYFZ9IbWnYKZe2h+n7mD8n9D9IJrUR+l6/
         cOQg==
X-Received: by 10.15.74.197 with SMTP id j45mr2428822eey.40.1378278835384;
 Wed, 04 Sep 2013 00:13:55 -0700 (PDT)
Received: by 10.223.198.71 with HTTP; Wed, 4 Sep 2013 00:13:55 -0700 (PDT)
In-Reply-To: <CAM9Z-nmLQUrJk73pi_0a1_ccGMnqU_t=uOZze622_GEtWfMvQQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233811>

Just wanted to point to a Dr. Dobb's article from Monday:
http://www.drdobbs.com/tools/getting-started-with-git-the-fundamental/2=
40160261?pgno=3D2

The author does not use the use the word "index" at all. Instead he
writes in following way:

-----------------------------------------------------------------------=
----------------
Staging Changes

One of Git's best features is that it offers a staging process. You
can stage the modified files that you want to commit. Other version
control systems await your one command before your files are changed
in the repository =97 generally the remote repository for the entire
team. When you commit files in Git, files are held in a staging area.
You will later commit all the files from the staging area to the
larger repository.

So, let's say you wanted to make a change involving files A and B. You
changed file A. You then remembered something unrelated to do with
file Z and you modified that. Then you went back to your initial
change, modifying file B. Git allows you to add files A and B to
staging, while leaving file Z "unstaged." Then you can push only the
staged files to your repository. But you don't! You realize you need
to make a change to file C as well. You "add" it. Now files A,B, and C
are staged, and Z is still unstaged. You commit the staged changes
only.

[...]
-----------------------------------------------------------------------=
----------------


Sorry for not responding to your comments Drew, no time at the moment.

--=20
Piotr Krukowiecki
