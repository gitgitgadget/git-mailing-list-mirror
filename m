From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Efficient retrieval of commit log info
Date: Wed, 12 Dec 2007 16:34:02 +0100
Message-ID: <8aa486160712120734u7d77cc0ew7b3ab1663db1fa62@mail.gmail.com>
References: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
	 <Pine.LNX.4.64.0712121453150.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Eirik_Bj=F8rsn=F8s?=" <eirbjo@gmail.com>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 16:34:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2TbP-0004nZ-Sc
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 16:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbXLLPeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 10:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbXLLPeE
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 10:34:04 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:12065 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753905AbXLLPeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 10:34:03 -0500
Received: by rn-out-0102.google.com with SMTP id i6so24619rng.1
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 07:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ap3HCSH1wglCzTdWUhE5hwFAFbuWBnxLuwXqZtI8C1s=;
        b=L+gamx8thssBAequWMnldwN5pf6qYbe4bFL6oOpkX0XYBdxpAI0gRbvgfsuDcG85YJuluiZcU14W6ifXu39VlJpDk1QNnCWniIRy+d20v+B/aL8vFHJUlY22SWA8pCu4EzXmdYnj7/+uJS+/kUAXPUubpRI+x1jlVsP+Ie4jySg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mm//njKSHMrh4bZnqRAlZw7JdZl/nU2glyC3iA0Z2nMS2pc6plfwWmWW7bKXyguzAsn0f6dX2pjFEkcNJxPh/rJ9d2tcY7LucpzIG6+MAIuBWamwO5DukmaBUlQchyehUs4V57k8kTTDDYpZIbgk4lv53FLSLsko3w0x4554YI8=
Received: by 10.150.206.1 with SMTP id d1mr270137ybg.4.1197473642040;
        Wed, 12 Dec 2007 07:34:02 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Wed, 12 Dec 2007 07:34:02 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0712121453150.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68051>

On Dec 12, 2007 3:55 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 12 Dec 2007, Eirik Bj?rsn?s wrote:
>
[...]
> > What I would like to do is to fetch just the change log information
> > from the remote repository.
> >
[ ... ]
>
> It is not possible to get just the metadata.  Remember, svn can do it only
> since the repository is purely remote.  And git is a SCM (source code
> management system), not a CMV (commit metadata viewer).
>
> You might be able to cobble up something that works accessing gitweb, but
> it might be even more inefficient.

You could see how it is done in the git-browser:

http://repo.or.cz/w/git-browser.git

It is a gitk-like browser written in javascript. But I suspect that it
should be enabled in the web server.

Santi
