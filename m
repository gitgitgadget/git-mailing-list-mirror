From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Mon, 17 Jun 2013 19:20:54 +0200
Message-ID: <vpq61xc1wnd.fsf@anie.imag.fr>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com>
	<7vli69iff2.fsf@alter.siamese.dyndns.org>
	<vpqip1d803r.fsf@anie.imag.fr>
	<7B6316FB423B45559A4698FD35D519FC@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Jun 17 19:21:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uod75-0003Ls-WE
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 19:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab3FQRVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 13:21:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35567 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563Ab3FQRVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 13:21:01 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5HHKq4r024976
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Jun 2013 19:20:52 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uod6s-00010w-F0; Mon, 17 Jun 2013 19:20:54 +0200
In-Reply-To: <7B6316FB423B45559A4698FD35D519FC@PhilipOakley> (Philip Oakley's
	message of "Mon, 17 Jun 2013 18:09:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 17 Jun 2013 19:20:52 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228088>

"Philip Oakley" <philipoakley@iee.org> writes:

>> +       Note that `--force` applies to all the refs that are pushed,
>> +       hence using `git push --all --force`, or `git push --force`
>> +       with `push.default` set to `matching` may override refs other
>> +       than the current branch (including local refs that are
>> +       strictly behind their remote counterpart). To force a push to
>> +       only one branch, use `git push <remote> +<branch>` instead of
>> +       `--force`.
>
> It would be useful to include a real example "e.g. `git push origin
> +master`", or a link to specifying a refspec "see <refspec>... above",
> such that the "+" doesn't get lost in the general text, as push is one
> of the first few commands a new user is likely to be looking up (and
> misunderstanding ;-), so let's make the + obvious

Yes, why not. I'll point to the <refspec> section for detail, and just
give an example here.

> I did notice that the <refspec>... section doesn't actually associate
> the "+" with the force action - Am I misunderstanding this?

It says:

  By having the optional leading `+`, you can tell Git to update the
  <dst> ref even if it is not allowed by default (e.g., it is not a
  fast-forward.)"

I think it's OK.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
