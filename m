From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Mon, 17 May 2010 19:14:37 +0200
Message-ID: <AANLkTimBSc35cnmRgDMDhQKtXC2PchcrSGHxMBcBMtuG@mail.gmail.com>
References: <20100516172738.5043.94039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin.marinas@gmail.com,
	davidk@lysator.liu.se
To: =?UTF-8?Q?Gustav_H=C3=A5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 19:46:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE4OU-0007tp-Id
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 19:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab0EQRpV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 May 2010 13:45:21 -0400
Received: from mail1.space2u.com ([62.20.1.135]:61485 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab0EQRpU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 13:45:20 -0400
X-Greylist: delayed 1840 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2010 13:45:20 EDT
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.4/8.14.3) with ESMTP id o4HHEKn5011605
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Mon, 17 May 2010 19:14:20 +0200
Received: by ey-out-2122.google.com with SMTP id d26so434613eyd.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 10:14:37 -0700 (PDT)
Received: by 10.102.237.35 with SMTP id k35mr3704903muh.72.1274116477266; Mon, 
	17 May 2010 10:14:37 -0700 (PDT)
Received: by 10.103.198.19 with HTTP; Mon, 17 May 2010 10:14:37 -0700 (PDT)
In-Reply-To: <20100516172738.5043.94039.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147247>

2010/5/16 Gustav H=C3=A5llberg <gustav@gmail.com>:
> I would like to have something similar to this patch, which allows fo=
r
> setting the (git) tree of a particular patch. I would like to use it
> (from the Emacs mode) to make it easier to split an old patch into tw=
o
> (or more).
>
> It might be that this is too "powerful" (read: unsafe), and maybe a
> better (safer) command would use whatever is currently in the index
> rather than a SHA1.

I think this is a reasonable idea. (Note that for unapplied
patches---or any patch that we can pop---the notion of setting the
bottom tree makes sense too. pick can currently create a patch from a
given commit; it might be reasonable to teach it (or stg new) to take
two trees instead.)

--=20
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
