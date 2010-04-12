From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Manually edit the commit a submodule is pointing to?
Date: Mon, 12 Apr 2010 07:47:18 -0700
Message-ID: <20100412144718.GC6313@spearce.org>
References: <i2jc115fd3c1004120731g950c127fn44603df222de8273@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 16:47:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1KvC-0003VX-Mo
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 16:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab0DLOrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 10:47:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:35536 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0DLOrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 10:47:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1535911fgg.1
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 07:47:23 -0700 (PDT)
Received: by 10.223.144.79 with SMTP id y15mr541210fau.22.1271083643466;
        Mon, 12 Apr 2010 07:47:23 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id z10sm8602534fka.31.2010.04.12.07.47.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 07:47:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i2jc115fd3c1004120731g950c127fn44603df222de8273@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144737>

Tim Visher <tim.visher@gmail.com> wrote:
> I recently began to use submodules to manage large packages that I
> depend on from my .emacs file and I've run into an issue where I made
> a change locally and didn't push out to the master repo.  I'm now not
> at that box and I'm trying to checkout the repo fresh.
>=20
> The problem is that the master repo doesn't have the commit specified=
=E2=80=A6
> Where?  So I can't edit the submodule commit and then readd it becaus=
e
> I don't have the submodule to edit since I can't check it out.  Is it
> possible to just manually munge the commit that the submodule is
> pointing to?

Yup:

  git update-index --cacheinfo 160000 commit path

--=20
Shawn.
