From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: Merging tags does not fast-forward with git 1.7.9
Date: Thu, 9 Feb 2012 17:18:38 +0100
Message-ID: <20120209161838.GA30761@glitch>
References: <20120209095415.GA19230@glitch>
 <1328803601.3416.0.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Feb 09 17:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvWhs-00037e-R9
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 17:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776Ab2BIQSn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 11:18:43 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49435 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2BIQSn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 11:18:43 -0500
Received: by eekc14 with SMTP id c14so639778eek.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 08:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nsgS6+Idu6bT/JcrDxaCY3bkCKHrRtNkgczZZu3hHcg=;
        b=rbq0tJPpc8QEJjqXMO5kx8ljekKzmxPG3nZBOfMeRIH3CASjOlG7B/C1ktnQ81DzrG
         Sqv9mMwQWwDtR3DvglWhoxWKzququINv6aD00oMQRc6OgalDb6GaDv/WxJ7p04Vtd8WH
         BZi2x0eIVfKOHrKIVyCuZpRIUUtcnJjGz1LSk=
Received: by 10.213.22.2 with SMTP id l2mr3616787ebb.97.1328804321691;
        Thu, 09 Feb 2012 08:18:41 -0800 (PST)
Received: from glitch (178-85-163-250.dynamic.upc.nl. [178.85.163.250])
        by mx.google.com with ESMTPS id o49sm11246939eei.0.2012.02.09.08.18.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Feb 2012 08:18:40 -0800 (PST)
Received: by glitch (Postfix, from userid 1000)
	id B7728BA0800; Thu,  9 Feb 2012 17:18:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1328803601.3416.0.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190296>

On Thu, Feb 09, 2012 at 05:06:41PM +0100, Carlos Mart=EDn Nieto wrote:
> On Thu, 2012-02-09 at 10:54 +0100, Domenico Andreoli wrote:
> > Hi,
> >=20
> >   with the recent changes in tag merging (I updated git to 1.7.9),
> > my usual "git merge v3.X-rcY" command does not fast-forward any mor=
e.
> > Of course the initial head is something like "v3.X-rcZ" without any
> > change so that it should (and usually did) fast-forward to the new =
head.
> >=20
> > The editor is instead fired off and I have to fill the details of a
> > merge commit, diverging from mainline as soon as I save and exit.
> >=20
> > Is there any simple and clear explanation for this? Thank you.
> >=20
> > cheers,
> > Domenico
> >=20
> > ps: I admit I didn't follow the details about tag signatures so pro=
bably
> > I missed something that I shouldn't.
>=20
> This was discussed recently
>=20
> http://thread.gmane.org/gmane.comp.version-control.git/189825

The command I was looking for is:

  $ git merge --ff-only v3.X-rcY^0

thanks,
Domenico
