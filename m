From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] GIT_INDEX environment variable ignored?
Date: Thu, 08 Oct 2015 09:28:47 +0200
Message-ID: <vpqy4fd2500.fsf@grenoble-inp.fr>
References: <3316005380861448B5340D39CF27A7242F2375BE@us-voo-mb04.internal.sungard.corp>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "McAuley\, Ben" <Ben.McAuley@sungard.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 09:29:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk5dT-0003Uu-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 09:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbbJHH3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 03:29:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38466 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbbJHH3B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 03:29:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t987Skfx027934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 09:28:46 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t987Slrf027703;
	Thu, 8 Oct 2015 09:28:47 +0200
In-Reply-To: <3316005380861448B5340D39CF27A7242F2375BE@us-voo-mb04.internal.sungard.corp>
	(Ben McAuley's message of "Thu, 8 Oct 2015 04:48:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Oct 2015 09:28:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t987Skfx027934
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444894130.19692@vKH4NAZFaDG5lXBABbthgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279218>

"McAuley, Ben" <Ben.McAuley@sungard.com> writes:

> However when I run the same command again, this time using the 
> GIT_INDEX env variable to provide the index I previously saved on master,
> I don't see file2 like I'd expect...

The variable name is GIT_INDEX_FILE (read 'man git' for details) ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
