From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: WISH: Extending git commit --amend
Date: Fri, 29 May 2009 10:10:09 +0200
Message-ID: <vpqprds2uu6.fsf@bauges.imag.fr>
References: <e5bfff550905282348gf29aa16o6eec88423bb5ce23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 10:13:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9xDC-0006u2-66
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 10:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731AbZE2INB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 04:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755013AbZE2IM7
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 04:12:59 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:58419 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174AbZE2IM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 04:12:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n4T8AG4W007311;
	Fri, 29 May 2009 10:10:16 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1M9xAO-0006a8-3d; Fri, 29 May 2009 10:10:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1M9xAH-0002Ou-1N; Fri, 29 May 2009 10:10:09 +0200
In-Reply-To: <e5bfff550905282348gf29aa16o6eec88423bb5ce23@mail.gmail.com> (Marco Costalba's message of "Fri\, 29 May 2009 08\:48\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 29 May 2009 10:10:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120258>

Marco Costalba <mcostalba@gmail.com> writes:

> Would be possible to extend git commit --amend so to automate the
> above sequence ? Or does perhaps exists a better sequence to change
> (actually simulate the change of) log message of an inner revision?

git rebase -i E^

Then, change a "pick" with a "edit" wherever you want.

(Perhaps the doc of commit --amend could say "to amend a previous
commit, you may want to look at the 'edit' command of 'git rebase
-i'"?)

-- 
Matthieu
