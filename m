From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git-upload-pack bandwidth cap over SSH?
Date: Fri, 24 Sep 2010 18:16:52 +0200
Message-ID: <vpq39szazgr.fsf@bauges.imag.fr>
References: <4C9CB9E9.8010901@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 18:17:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAxL-0002AQ-6K
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394Ab0IXQQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:16:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58846 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932158Ab0IXQQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:16:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8OGC7Hl008340
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 24 Sep 2010 18:12:09 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OzAxA-0000Md-Sa; Fri, 24 Sep 2010 18:16:52 +0200
In-Reply-To: <4C9CB9E9.8010901@workspacewhiz.com> (Joshua Jensen's message of "Fri\, 24 Sep 2010 08\:47\:05 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 24 Sep 2010 18:12:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8OGC7Hl008340
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285949530.84379@zO67I5hMWETi1Dffll1SaA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157017>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> Update: I just copied a large file via 'scp', and the downstream still
> capped at 1.55-ish megabytes per second.  So it isn't Git.

What's the CPU usage on both sides?

To benchmark SSH, you can also do things like (on Unix) :

  ssh host 'head -c 100000000 /dev/zero' | wc -c

(to make sure you're not benchmarking your hard drive)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
