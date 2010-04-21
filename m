From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git pull behavior changed?
Date: Thu, 22 Apr 2010 00:23:16 +0200
Message-ID: <vpq8w8gjvhn.fsf@bauges.imag.fr>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
	<vpqsk6omppf.fsf@bauges.imag.fr>
	<h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 00:27:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4iNz-0000pb-EC
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 00:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab0DUW1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 18:27:06 -0400
Received: from imag.imag.fr ([129.88.30.1]:38170 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529Ab0DUW1F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 18:27:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o3LMNGVi007767
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 22 Apr 2010 00:23:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O4iKC-00040f-8p; Thu, 22 Apr 2010 00:23:16 +0200
In-Reply-To: <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com> (Aghiles's message of "Wed\, 21 Apr 2010 18\:04\:36 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 22 Apr 2010 00:23:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145472>

Aghiles <aghilesk@gmail.com> writes:

> Again, the behavior changed since I last used this. No one cares?

The behavior of Git did not change. The content of your configuration
file or the branch you are on did. The way to put the right content in
your configuration file is --track.

When you create a branch, you say what the starting point of your
branch is, and if you say --track, Git remembers it and uses it for
pull next time. The simplest is to start your branch based on
remotes/<name>/<branchname>, which is where your probably want to pull
from.

Otherwise, --set-upstream may help. But neither will help untill you
RTFM.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
