From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Tutorial: Importing patches
Date: Tue, 28 Oct 2008 22:09:52 +0000
Message-ID: <b0943d9e0810281509r109ee2dby51ee13a250700012@mail.gmail.com>
References: <20081028204223.9539.89315.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 23:11:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuwmJ-0000cE-7j
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 23:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbYJ1WJy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2008 18:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752842AbYJ1WJy
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 18:09:54 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:22973 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbYJ1WJx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Oct 2008 18:09:53 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2946763rvb.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SfokzzKx+s8veTo/sZ2ZL/rftj6cUbb25GEiPldNqh0=;
        b=xR5lCCMmh8HZqsUoWReqlYZGs9gmdAagu0h0zjWtLsOsd39E312n9SrGjxxxavaYW9
         ZDMDizVu5c0XJTH9ug770eZHO80TY/azgJYtLkwAomRS+CsUabUz5eOiJIjdCK/R8cZd
         eKXqBH7lwRyMo8iBWQ/pPqwKQz3zi6qwcUKE8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EDp0VpF9Nw5HL+cydbSVy1wt2nOPaOiBT9QTRp4nzvzw4U2innfWDW7j9xxQdho8qL
         EdE0wcbm1RPt8YsxPfSt5DCm5VmoW7ynzS7/IacxK45oqjThwzd0pHnUpPNfxczkEeyH
         /s+5MgnHkYvU3G6Jv74lwpNCFmg+Sr1IKOonk=
Received: by 10.140.201.8 with SMTP id y8mr4445955rvf.148.1225231792261;
        Tue, 28 Oct 2008 15:09:52 -0700 (PDT)
Received: by 10.140.199.1 with HTTP; Tue, 28 Oct 2008 15:09:52 -0700 (PDT)
In-Reply-To: <20081028204223.9539.89315.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99327>

Hi Karl,

Thanks for the patch.

2008/10/28 Karl Hasselstr=F6m <kha@treskal.com>:
> +Importing a patch from an e-mail is simple too:
> +
> +  $ stg import --mail my-mail
> +
> +The e-mail should be in standard Git mail format (which is what e.g.
> +stglink:mail[] produces) -- that is, with the patch in-line in the
> +mail, not attached. The authorship info is taken from the mail
> +headers, and the commit message is read from the 'Subject:' line and
> +the mail body.

It actually supports importing diffs from attachments as well as long
as they are text/plain (the description is expected in the mail body).
Anyway, I think we don't have to mention this in the tutorial as most
people would use the Git mail format anyway.

--=20
Catalin
