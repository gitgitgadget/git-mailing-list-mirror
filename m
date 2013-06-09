From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Sun, 09 Jun 2013 13:01:48 +0200
Message-ID: <vpq38srtun7.fsf@anie.imag.fr>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
	<20130609060807.GA8906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	celestin.matte@ensimag.fr
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 13:02:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UldNy-0006cM-0t
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 13:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377Ab3FILCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 07:02:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33693 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab3FILCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 07:02:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r59B1l5n012287
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 9 Jun 2013 13:01:47 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UldNc-0001zs-W9; Sun, 09 Jun 2013 13:01:49 +0200
In-Reply-To: <20130609060807.GA8906@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 9 Jun 2013 02:08:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 09 Jun 2013 13:01:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59B1l5n012287
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371380511.81319@/eCccq9hOiQ3d3yH1iLeDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226952>

Jeff King <peff@peff.net> writes:

>> 1- Find the remote name of the current branch's upstream and check if it's a
>> wiki one with its url (ie: mediawiki://)
>> 2- Parse the content of the local file (given as argument) using the distant
>> wiki's API.
>
> Makes sense.
>
>> 3- Retrieve the current page on the distant mediawiki.
>> 4- Merge those those contents.
>
> I'm not sure what these steps are for. You are trying to preview not
> just your local version, but pulling in any changes that have happened
> upstream since the work you built on top of?

Same question here. I'd expect "git mw preview" in a mediawiki workflow
to do what "pdflatex foo && evince foo.pdf" do in a latex workflow: see
in rendered form what I've been doing.

In a latex flow, if I want to see how my local changes merge with the
remote ones, I do "git merge && pdflatex", and I'd do the same with "git
mw".

> I also wonder if it would be useful to be able to specify not only files
> in the filesystem, but also arbitrary blobs. So in 4b above, you could
> "git mw preview origin:page.mw" to see the rendered version of what
> upstream has done.

Next step could even be "git mw diff $from $to", using the wiki to
render the diff. Not a priority, but could be funny.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
