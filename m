From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Fri, 17 Feb 2012 15:19:59 +0100
Message-ID: <vpqobsx7d9s.fsf@bauges.imag.fr>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
	<7v8vk2zghl.fsf@alter.siamese.dyndns.org>
	<vpqty2px4l5.fsf@bauges.imag.fr>
	<7vmx8hvb69.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tim Haga <timhaga@ebene6.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 15:20:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyOfY-00022v-2E
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 15:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988Ab2BQOUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 09:20:09 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35629 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab2BQOUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 09:20:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1HEGWvY032139
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 17 Feb 2012 15:16:32 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RyOfI-0004bo-JZ; Fri, 17 Feb 2012 15:20:00 +0100
In-Reply-To: <7vmx8hvb69.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 17 Feb 2012 05:31:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 17 Feb 2012 15:16:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1HEGWvY032139
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1330092995.24858@PqnbFWh3a2l/lXsjrePEjA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190957>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> I agree that the next step may be to allow users of <whatever SCM
>> outside Git>, but I don't think the way to do that would be to make the
>> script generic. The script is a quick hack, and all the "clever" parts
>> of it are calls to Git.
>
> You are not suggesting me to take and carry any future request that wants
> to add any quick hack that is heavily specific to Git and not portable to
> other SCMs to the contrib/ area only because they depend on Git, are
> you?

I'm answering the remark you made:

| I have this suspicion that "this new version will help people who have
| their documents stored in Mercurial" would be much more realistic (and
| the end result being useful) than "this new version will help git users
| who do not write their documents in latex but in asciidoc".

I think the probability that a next version of git-latexdiff is to
support another SCM is 0, and I tried to explain that.

Do you think I failed to address this remark?

> Look at what we have in the contrib/ area.  I think what is common among
> them is that their primary benefit is to enrich user's Git experience.

... and many of them is to enrich the user experience using Git with
another tool (shell, text editor, foreign VCS).

Without git-latexdiff, you can run "git diff" on LaTeX documents, while
with it, you can get a better view of the diff. To me, this is "enrich
user's experience" of users running "git diff".

Git's _core_ already has some code to show diff hunks for various
languages, and I don't think anyone would want to move these out because
they only benefit people tracking files in these languages.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
