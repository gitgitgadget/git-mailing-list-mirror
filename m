From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Fix typo: we require Python 2.4, not 2.5
Date: Tue, 11 Dec 2007 16:01:56 +0100
Message-ID: <20071211150156.GA23609@diana.vm.bytemark.co.uk>
References: <b0943d9e0712100340p78326b4avf2b7e64008bba6d6@mail.gmail.com> <20071211142347.GA22879@diana.vm.bytemark.co.uk> <b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:02:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J26cr-0008FY-TO
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 16:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbXLKPCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 10:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbXLKPCD
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 10:02:03 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2012 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbXLKPCC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 10:02:02 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J26cO-0006Ae-00; Tue, 11 Dec 2007 15:01:56 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0712110627g70ad0aecyfeaafd8b8655fb57@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67865>

On 2007-12-11 14:27:08 +0000, Catalin Marinas wrote:

> Is the GIT version OK or just too restrictive?

The only restriction I've checked is this one:

commit 9a6bcbe26b6032c39031773da020fd7bf4015953
Author: Karl Hasselstr=F6m <kha@treskal.com>
Date:   Sat Sep 22 10:22:18 2007 +0200

    Properly remove all config for a deleted branch

    This uses "git-config --remove-section", which was first released i=
n
    git 1.5.1-rc1. I'm not sure if this is later than what we used to
    depend on; we already use "git-config --rename-section", but that's
    been in since git 1.5.0-rc0.

So I guess we should require at least 1.5.1. But I don't think
requiring 1.5.2 is that bad.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
