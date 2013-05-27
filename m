From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: contrib/git-normal-to-bare.sh
Date: Mon, 27 May 2013 11:02:09 +0200
Message-ID: <vpqr4gs23u6.fsf@anie.imag.fr>
References: <CAOsGNSSFx7VEOmz4qTt9nz=SXzQCZH7PdZ+gnYVqLhmRmRcT-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Mon May 27 11:02:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgtJx-0006Ec-B9
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 11:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab3E0JCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 05:02:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53773 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab3E0JCU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 05:02:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4R928aA030354
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 27 May 2013 11:02:09 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UgtJh-0001zW-RS; Mon, 27 May 2013 11:02:09 +0200
In-Reply-To: <CAOsGNSSFx7VEOmz4qTt9nz=SXzQCZH7PdZ+gnYVqLhmRmRcT-A@mail.gmail.com>
	(Zenaan Harkness's message of "Mon, 27 May 2013 14:00:46 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 27 May 2013 11:02:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4R928aA030354
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1370250132.81643@RTshgXnRjK+mLwgGaFyRgQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225580>

Zenaan Harkness <zen@freedbms.net> writes:

>    rm -rf $repo

The user would appreciate if you check that there are no uncommited
changes and no untracked files (at least no untracked and not ignored
files) before running this.

Also, it's "$repo", not just $repo, or you'll get surprising behavior if
$repo contain spaces.

The safe way would actually be stg like:

  rm -fr -- "$repo"

in case $repo starts with a dash.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
