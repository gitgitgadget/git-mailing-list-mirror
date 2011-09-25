From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Sun, 25 Sep 2011 06:24:00 -0700 (PDT)
Message-ID: <m3wrcwpxh7.fsf@localhost.localdomain>
References: <4E7C9AAD.7060209@gmail.com>
	<m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com>
	<14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
	<m362khr6kh.fsf@localhost.localdomain>
	<nbd7plmz30x2.mafpxaq9xl9r.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tactical <a5158017@nepwk.com>
X-From: git-owner@vger.kernel.org Sun Sep 25 15:24:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7ogi-0002ju-VW
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 15:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab1IYNYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 09:24:04 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39708 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab1IYNYC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 09:24:02 -0400
Received: by eya28 with SMTP id 28so3041386eya.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=c5RGTfKqKFDfRm1O4ctByUB+/0JZFfF3p++DUd7bwsE=;
        b=pP+Zs3lo/6/+sshcXGvglXH9/3QHwW4QqgOGfXmP10Z130TOY8nQc/BIZdgidkbsT3
         NiGS5qQJ/rFX8Lue3o3d1mQr9uHXG+d+nJf2kVmxGz1aQB48lYjL/Kb7EqXIoUq/yEJT
         DGw/clHqarppSqRRdib9pbm2XkN8Kn47IqoZc=
Received: by 10.14.2.94 with SMTP id 70mr1671722eee.97.1316957041139;
        Sun, 25 Sep 2011 06:24:01 -0700 (PDT)
Received: from localhost.localdomain (abvl230.neoplus.adsl.tpnet.pl. [83.8.209.230])
        by mx.google.com with ESMTPS id u14sm50322408eeh.1.2011.09.25.06.23.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Sep 2011 06:24:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8PDNS0t021745;
	Sun, 25 Sep 2011 15:23:38 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8PDNHg9021738;
	Sun, 25 Sep 2011 15:23:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <nbd7plmz30x2.mafpxaq9xl9r.dlg@40tude.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182069>

tactical <a5158017@nepwk.com> writes:
> Jakub Narebski wrote:

> > Anyway merging with local changes is an easy way to f**k up your
> > changes in unrecoverable way, IMVHO...
>=20
> Mercurial backs everything up before doing this merge, so if I do los=
e my
> local changes, I can start over with this:
>=20
>     hg resolve --unmark --all
>     hg resolve --all

Well, that's the advantage of database-like transaction based atomic
operations.

OTOH reflog allows to back out not only last operation...

--=20
Jakub Nar=EAbski
