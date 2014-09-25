From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git 1.9.0 - build on Solaris 8 -> no git-remote-http ?
Date: Thu, 25 Sep 2014 14:18:21 +0200
Message-ID: <vpqzjdnq4fm.fsf@anie.imag.fr>
References: <938AB08865DF82448B10C2CD60FD0AA1012349C5EC@EEL.pcs.sopres.be>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Sebastien Toulmonde <Sebastien.Toulmonde@bisnode.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 14:18:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XX80J-00050k-Er
	for gcvg-git-2@plane.gmane.org; Thu, 25 Sep 2014 14:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbaIYMSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2014 08:18:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42229 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbaIYMS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2014 08:18:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s8PCIKko015484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Sep 2014 14:18:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s8PCILe4031311;
	Thu, 25 Sep 2014 14:18:21 +0200
In-Reply-To: <938AB08865DF82448B10C2CD60FD0AA1012349C5EC@EEL.pcs.sopres.be>
	(Sebastien Toulmonde's message of "Thu, 25 Sep 2014 09:00:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Sep 2014 14:18:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s8PCIKko015484
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1412252302.30793@uegYoZFhLn1/OIxhtp9ztQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257476>

Sebastien Toulmonde <Sebastien.Toulmonde@bisnode.com> writes:

> Hello all,
>
> I'm trying to build Git from source for our end-users. Our platform
> range from Solaris 8 to 10 (we're migrating to 11 this year).
> Meanwhile, I'm trying to build Git from source, as there is no package
> for Solaris 8/10 (opencsw can't be used in our environment). I've been
> able to build it successfully, using Sun Studio and gmake 3.84. But
> unfortunately, the build process does not compile/link any
> git-remote-*
> programs... Which leads me to an unusable git for use in remote
> architecture (which is what we use).

These git-remote-* have more dependencies than the core git executable.
Probably you lack libcurl (lib or header files) or something like this?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
