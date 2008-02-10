From: "Derek Mahar" <derek.mahar@gmail.com>
Subject: Re: git-cvsexportcommit and commit date
Date: Sun, 10 Feb 2008 11:01:03 -0500
Message-ID: <5f4b18bf0802100801t20952180u6afd1eeaf2fac17@mail.gmail.com>
References: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com>
	 <5f4b18bf0802092201i24f7de39o3fea28823621fdd1@mail.gmail.com>
	 <5f4b18bf0802092213r4bd1df2ap7d2649dd9251fbb7@mail.gmail.com>
	 <200802101415.00726.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 17:01:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOEch-0005GK-PM
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 17:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbYBJQBH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 11:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbYBJQBG
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 11:01:06 -0500
Received: from hs-out-0708.google.com ([64.233.178.240]:17064 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750826AbYBJQBF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 11:01:05 -0500
Received: by hs-out-2122.google.com with SMTP id 54so3627964hsz.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 08:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BHSWDgahH+R0jpHL/ieT15td2uZfMbXU2V/hzu7+pRE=;
        b=pHgn77e9wZDPSNtkeBDG1D5gyYM6RvypUJDDhcWhgzaNcBR6tmTXfNhcFvc9oLmKkyDWbCm6oeFfuOB0GgyOrKIIJbo6EJZYLb5Q+zmBJzpLiZqV+nd6Q0q54fTMwfZY21vcCfciEH2snzEmFaev89+BmE6nn0YGPho83Eb7WJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Al6HBfPm2/ElbPUx4neVkHMHSpSycixg4UW9YlShDuA7KNo7NZD7y7pSYHiu78OHEkR3IzEs+6DJGaxt1Hh08ByM7R3StCDqhj7VYPTWNJYMSWY0CJi951JqzoXhJHGyEngaxZ6X0f+eGWqFFt2xevpv+u5Ss+E6kLoLuIiAvkU=
Received: by 10.142.48.14 with SMTP id v14mr7901570wfv.14.1202659263427;
        Sun, 10 Feb 2008 08:01:03 -0800 (PST)
Received: by 10.142.177.13 with HTTP; Sun, 10 Feb 2008 08:01:03 -0800 (PST)
In-Reply-To: <200802101415.00726.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73362>

On Feb 10, 2008 8:15 AM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> s=F6ndagen den 10 februari 2008 skrev Derek Mahar:
> As I recall it (I'm using fromcvs, not git-cvsimport) cvs HEAD get im=
ported
> into origin which on initial import gets copied to master. So I think=
 you
> should git rebase origin

When it drops the extra commit, is there a way to ask git-rebase to
keep the textual change of the original commit, but use the commit
information from the imported CVS commit?  This way, the resulting Git
repository would match that of another user who performs an initial
git-cvsimport of the entire CVS repository.

Can fromcvs read from a remote CVS repository via pserver or does it
only parse the RCS files directly?  I have only pserver access to our
CVS repo,

Derek
