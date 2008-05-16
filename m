From: "Alf Mikula" <amikula@gmail.com>
Subject: Re: Migrating a git repository to subversion
Date: Fri, 16 May 2008 10:45:35 -0700
Message-ID: <42dc968d0805161045g1b128360ha45e8bdf9ced6fe6@mail.gmail.com>
References: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com>
	 <alpine.LFD.1.10.0805151952260.2941@woody.linux-foundation.org>
	 <46a038f90805152053n43add2cbj8383c475772c3681@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 19:46:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx40y-0001Pb-PP
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 19:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426AbYEPRpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2008 13:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbYEPRpj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 13:45:39 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:39509 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928AbYEPRph convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2008 13:45:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so840548fkq.5
        for <git@vger.kernel.org>; Fri, 16 May 2008 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NPomxUrmZwIqL316u3j+dGwr9AN2VfAD3TkgE6XIpnY=;
        b=ctqX450G+TYtN+v/t4KSpMaUrgv+gGkqN+j9hv3J8CiPDLy84e0+mj0cW/CUn9hEYYoMwGr1iYPqjMRJkNf+0xbw77/hBFEvEkRkzdWRjHds29/6mrIBiai/bEATWullj36ZwMizAZH5YanlRc5itRVbQ7rjyj6Mjjzl3o635m0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jUqjEsgsDBnk5D9AEPn50d6fNHnrJHXEUNPstStYpJc/fk4/J0qXd/vJv75SSwuvJYaCrCh4gcGoIWlpGQwGS8A+RJQIVdD8StdR8VGHEpI8HAU37xnvP/Ut4G2eHDqrxLmW0fS8LbQyzJAaHELh3qu70wMls+Q2DdmyGt6Tw+A=
Received: by 10.125.115.18 with SMTP id s18mr2831781mkm.139.1210959935851;
        Fri, 16 May 2008 10:45:35 -0700 (PDT)
Received: by 10.86.81.19 with HTTP; Fri, 16 May 2008 10:45:35 -0700 (PDT)
In-Reply-To: <46a038f90805152053n43add2cbj8383c475772c3681@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82310>

> The git svn rebase trick described earlier does almost exactly what A=
lf wants.

You're absolutely right.  With the rebase, I have my history (which so
far is linear) in the SVN repository, and I can continue using git
locally and pushing my commits back to Subversion.  I also want to try
Bj=F6rn's suggestions about merging SVN branches.  While Subversion
fixed the most annoying problems in CVS, I think it got a lot of
branching, merging, and tagging wrong.  Maybe using git to handle
merging will make a nice band-aid.

Anyway, thanks to all for the suggestions!

-Alf
