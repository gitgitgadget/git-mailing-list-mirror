From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Thu, 13 Nov 2014 12:49:19 +0100
Message-ID: <20141113114919.GA2737@paksenarrion.iveqy.com>
References: <20141113111444.GA15503@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:43:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xosnl-00033O-MN
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbaKMLm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2014 06:42:57 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:56707 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552AbaKMLmz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:42:55 -0500
Received: by mail-lb0-f179.google.com with SMTP id l4so10986149lbv.10
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 03:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BxdKxBsdFjgLH2MmhJQZcq74bCXyN7jCcoLHyeeF1vE=;
        b=wk/HV1Oof7UhA3sClKu1hnsIPWcYF7xQKZkMuGH3G7zvPpe8Jb86Pjobi3m1prCBuR
         F+k294vIKtM7BMbYSRKDwErcPR7XO85DAvS3zv7MvL70wkitiAYDH4cxVyVFFH3rmA5T
         yIc8RVFw5bVwSzvMkDtOGi9Lo7t8sQCA3W/gPy4iM/SH2K/Xed7vBvamyQFVyMNlRLRj
         34v+S/HyyKrWCnhFYvdTjZfoVGA3zn6wy6RbaV8I0ZjAgAN1nTGYKVCDE+Zs3eTMlUMQ
         FU+EjItz7o0ZHxBD8H4M2iv5Ck1nAcVIV472kLIuVETEeFQaIC7G1/uRFM7MMKulZMJd
         xojw==
X-Received: by 10.112.166.101 with SMTP id zf5mr2018631lbb.42.1415878974041;
        Thu, 13 Nov 2014 03:42:54 -0800 (PST)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id p2sm7397305lah.48.2014.11.13.03.42.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2014 03:42:53 -0800 (PST)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Xostr-0005f7-IN; Thu, 13 Nov 2014 12:49:19 +0100
Content-Disposition: inline
In-Reply-To: <20141113111444.GA15503@aepfle.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 12:14:44PM +0100, Olaf Hering wrote:
>=20
> How can I reduce the disk usage for multiple copies of the same repo?

You can use --local och --shared. As you say --shared can be dangerous.
If you don't understand the man page enough to know how you should
manage your clones you should probably not use it.

--local seems to be what you're looking for.

However as a side note I'm curious about what your use case is. Why do
you need this many repos?

Your setup looks familiar to me for a subversion user switching to git
and trying to use git as subversion. The common usecase is not to have
multiple worktrees but to do a checkout to the worktree you need to wor=
k
on. This is possible with git since it's very fast and I recommend you
to try to use one worktree.

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
