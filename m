From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Getting started contributing.
Date: Mon, 04 Feb 2013 14:37:46 +0100
Message-ID: <vpq4nhsmc7p.fsf@grenoble-inp.fr>
References: <1359872508519-7576834.post@n2.nabble.com>
	<7vhaltalre.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: adamfraser <adamfraser0@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 14:38:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2MFf-0001sI-5D
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 14:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab3BDNh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 08:37:57 -0500
Received: from mx2.imag.fr ([129.88.30.17]:39851 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350Ab3BDNh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 08:37:56 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r14DbjIP009934
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 4 Feb 2013 14:37:45 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U2MF1-0004RP-7s; Mon, 04 Feb 2013 14:37:47 +0100
In-Reply-To: <7vhaltalre.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 02 Feb 2013 23:40:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Feb 2013 14:37:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r14DbjIP009934
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360589870.50215@nvuVaoIJuPuuS09XHSBK9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215383>

Junio C Hamano <gitster@pobox.com> writes:

> adamfraser <adamfraser0@gmail.com> writes:
>
>> I would like to start contributing to git and am looking for a small project
>> idea to get started with. On the  Small Project Ideas wiki
>> <https://git.wiki.kernel.org/index.php/SmallProjectsIdeas>   site there is a
>> suggestion for adding a 'git rebase --status' command that sounds like it
>> would be good for someone who has little knowledge of the code base.
>
> I think the two patches Duy just posted tonight overlap with that
> topic, and I suspect it would give the end users a better experience
> to put the information in "git status" output rather than a separate
> "git rebase" subcommand.

(I'm the one who wrote the idea on the wiki)

"git status" already shows a lot of valuable information about rebase,
but my idea was that there's still room for a much more verbose command
(hence too verbose to appear in the output of "git branch" or "git
status"), saying eg.

* Which patch is being applied (we can imagine giving just the subject
  line by default, but showing the complete patch with an additional
  --patch option). I often miss that when trying to understand the
  origin of a conflict. I can manually look at file
  .git/rebase-merge/patch (I seem to remember a patch that shows the
  path to this file when rebase stops, but I can't find it anymore), but
  a nice porcelain would be nice.

* What's still on the todo-list

Also, perhaps this could gather the advices "(run git rebase <something>
to <do something>)" currently in the output of "git status", and "git
status may just say "(run git rebase --status for more information)"
instead of 2 or 3 lines of advices.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
