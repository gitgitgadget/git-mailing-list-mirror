From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Ensimag students projects, version 2013
Date: Mon, 15 Apr 2013 18:32:49 +0200
Message-ID: <vpqzjwzkb4e.fsf@grenoble-inp.fr>
References: <vpqobdg515m.fsf@grenoble-inp.fr>
	<CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Phil Hord <phil.hord@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 18:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URmL1-0005B4-IO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 18:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933326Ab3DOQc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 12:32:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32924 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932361Ab3DOQc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 12:32:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3FGWl6K018757
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Apr 2013 18:32:49 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1URmKn-0003ZM-Qv; Mon, 15 Apr 2013 18:32:49 +0200
In-Reply-To: <CALkWK0nFB1dzmp6yC9XS4ADmWf9tfQYtsSH0K1u0dtBWT0CRNw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 20:48:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Apr 2013 18:32:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3FGWl6K018757
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1366648374.50762@eNtiEErXNOokRD3YcIJq6w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221249>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> A few small personal itches off the top of my head:
>
> - Make git status -s show "state status" as well: this essentially
> requires writing an equivalent of wt_status_print_state() for use in
> wt_shortstatus_print().

Do you mean, showing it in a natural language form, or machine-parsable?

If the later, there was a patch series doing essentially this:

  http://thread.gmane.org/gmane.comp.version-control.git/209240

It doesn't seem to have been merged. Phil, what happened to it?

> - Make the -s and -b switches in git status configuration variables.
> I currently have status aliased to status -sb, and this is less than
> ideal.
>
> - Make the -3 and -c switches in git am configuration variables.  I
> have an alias.

Seems reasonable. Should be good technical warm-ups if people agree this
is a good idea.

> - Create an advice.ui (like color.ui) to turn off all advice.  I don't
> need advice.

I tend to agree with you, but the idea has explicitly been rejected in
the past. The problem with an option like this is that it would also
disable the advices that may be added in the future. By letting people
disable the advices one by one, people see new advices as they arrive.
You may think of it like "do not show this message again" tickboxes in
some graphical user interfaces.

Too controversial area for newcommers I guess ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
