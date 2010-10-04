From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: branch versioning
Date: Mon, 04 Oct 2010 15:25:22 +0200
Message-ID: <vpqpqvqjdj1.fsf@bauges.imag.fr>
References: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 15:25:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2l2s-0003ry-AA
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 15:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615Ab0JDNZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 09:25:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41579 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684Ab0JDNZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 09:25:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o94DBnXN002628
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Oct 2010 15:11:49 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P2l2g-0007zl-KK; Mon, 04 Oct 2010 15:25:22 +0200
In-Reply-To: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Mon\, 4 Oct 2010 20\:18\:59 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 04 Oct 2010 15:11:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o94DBnXN002628
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1286802710.46065@/BYwFReQe9KsilykeQkwZw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158046>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Hi,
>
> How do you guys manage versions of a topic branch? I usually end up
> saving format-patch series somewhere or forget all old versions.
> Although I really want to keep old versions around. reflog to me   is
> polluted with every kind of branch updates. And it's local
> information. It can't be transferred to another repo (or can it?)

I don't have strong needs in branch-versionning, so usually, the
reflog is OK for me. When I need to save something, I set a tag on the
current version of the branch before continuing (that's somehow manual
versionning: the tag isn't versionned, so if I actually need history,
I'll set several tags like refs/tags/sent-to-list-as-v1
refs/tags/before-starting-rebase, ...).

But other tools like stgit, topgit & friends may help to manage that
in a cleaner way.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
