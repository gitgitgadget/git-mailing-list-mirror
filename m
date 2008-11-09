From: Deskin Miller <deskinm@umich.edu>
Subject: Re: force a merge conflict
Date: Sun, 9 Nov 2008 13:39:17 -0500
Message-ID: <20081109183917.GA18415@euler>
References: <81bfc67a0811090709s483506c1h6f9cb0f96216ef22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 19:40:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzFDF-0001Jb-Sj
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 19:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565AbYKISj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 13:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755534AbYKISj1
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 13:39:27 -0500
Received: from mail-gx0-f11.google.com ([209.85.217.11]:41503 "EHLO
	mail-gx0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755514AbYKISj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 13:39:26 -0500
Received: by gxk4 with SMTP id 4so1649159gxk.13
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 10:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=8ANevJjsdPN+fO9kzPZUaytGjPRkBQxF56Nu/aAbRFI=;
        b=MBEASrt0f1pvFFZeO8MdcCOEUiGZpomEd81BcGlQLgm8E+BFo5C8GR2b7HAMGk1p93
         sbaKQs9KO/sMt00p2xV97+q44K/wy16md23UN2PZLA14pfs4hi3pRc0pScRfaTrOaMdS
         ClwQUfFDEKRH4MU61oMaI2KfHpzOa6thjf//w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=vglPA/kRjvLoaPINlSuOhvNv0RWNArWBKAde2hKsmmDMDMIerO05XB3m3lYZ8It/b9
         MK8/Evaxo9leAuU9No0ibx8vZESDVa2TNDQ5N93TNpdI6LU13wT9zEjHC06W7N7Lke2t
         OnldZGtgnX1wCftz7d298JhPFGxRshx0ohoCA=
Received: by 10.65.84.15 with SMTP id m15mr6061343qbl.54.1226255964491;
        Sun, 09 Nov 2008 10:39:24 -0800 (PST)
Received: from euler (adsl-71-156-15-164.dsl.sfldmi.sbcglobal.net [71.156.15.164])
        by mx.google.com with ESMTPS id p31sm10049675qbp.18.2008.11.09.10.39.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Nov 2008 10:39:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <81bfc67a0811090709s483506c1h6f9cb0f96216ef22@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100460>

On Sun, Nov 09, 2008 at 10:09:49AM -0500, Caleb Cushing wrote:
> is there any way to force a merge conflict?

I'm not sure a 'conflict' is what you want, based on what you say below;
rather, it seems you simply want to force a 'merge commit', i.e. a commit with
multiple parents.

> in this case I have a dev branch and fork branch the fork is a copy of
> dev except I committed one of the files from the fork. I need to merge
> this file back into dev, but git thinks it's a fast forward, because
> it really is for git, in reality it isn't, both files have newer
> history than their common ancestry.

git merge --no-ff ?

Hope that helps,
Deskin Miller
