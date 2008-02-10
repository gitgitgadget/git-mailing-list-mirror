From: "Derek Mahar" <derek.mahar@gmail.com>
Subject: Re: git-cvsexportcommit and commit date
Date: Sun, 10 Feb 2008 01:01:42 -0500
Message-ID: <5f4b18bf0802092201i24f7de39o3fea28823621fdd1@mail.gmail.com>
References: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com>
	 <47AA0FD8.1050801@catalyst.net.nz>
	 <loom.20080210T033717-237@post.gmane.org>
	 <200802100645.32743.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 07:02:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO5Gr-0008DT-PU
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 07:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbYBJGBo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 01:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYBJGBn
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 01:01:43 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:8261 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbYBJGBn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 01:01:43 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1406807wah.23
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 22:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kQ6r5sRTo6SYwNBaGrwB6145gkXsPZUWtCwCut7KAHE=;
        b=sO0u2/AjfP+ulTfuaLdpspdyzhZTXFuWaydqP/DOeLH98k5o0k+33NdvWKqOPqTrPHyU2w0PQBx5NVe23FcZiZ4p3EuXRKYDk2xja/Os19MUyskWDQInBa2NRAYMsVmB9A6U9mUePPEgl2URtrRmZasR80rxo0BtwZisWjUxgmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fF3Hj4MZXBjl33QEw4ZvKeqmIMol6GSS0ID47JsiWWyCLh7q0QPY+XMwDsGkzbREJPx6OBusF3BDMzjzEnoXltkruc/K2UaJRr3EgR2yzuIrGram7/Z4MKdoJurkv2Y6afDTQhzfBIARgZIgDYWxBgeY+Y+Gq27omdN+ffZehSM=
Received: by 10.142.171.6 with SMTP id t6mr7649222wfe.150.1202623302248;
        Sat, 09 Feb 2008 22:01:42 -0800 (PST)
Received: by 10.142.177.13 with HTTP; Sat, 9 Feb 2008 22:01:42 -0800 (PST)
In-Reply-To: <200802100645.32743.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73318>

On Feb 10, 2008 12:45 AM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> s=F6ndagen den 10 februari 2008 skrev Derek Mahar:
> > How do you get git-cvsimport to avoid the "duplicate" commit that i=
t creates
> > when it imports a commit that you "landed" in CVS with git-cvsexpor=
tcommit?
>
> git rebase will drop those "empty" commits by default and you'll end =
up with the
> cvs-imported version.

How do I perform this rebase if the empty commit is on the same
branch, say the master branch, as the original CVS landed commit?  I
attempted such a git-rebase using 1.5.4, but, iirc, git-rebase
responded that the branch was already up-to-date.

Derek
