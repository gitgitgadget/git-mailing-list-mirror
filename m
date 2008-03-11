From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Additional fast forward strategies.
Date: Mon, 10 Mar 2008 23:34:27 -0700
Message-ID: <7v8x0pepl8.fsf@gitster.siamese.dyndns.org>
References: <402c10cd0803102004x7892f01cledfef6f277fba26a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 07:35:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYy57-0001Ml-4S
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 07:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756803AbYCKGef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 02:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753082AbYCKGef
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 02:34:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbYCKGee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 02:34:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E6282AC5;
	Tue, 11 Mar 2008 02:34:33 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3DB772AC4; Tue, 11 Mar 2008 02:34:30 -0400 (EDT)
In-Reply-To: <402c10cd0803102004x7892f01cledfef6f277fba26a@mail.gmail.com>
 (Sverre Hvammen Johansen's message of "Mon, 10 Mar 2008 19:04:38 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76800>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

>>From 779142c6b22f032c877f550733e1bccc99aca761 Mon Sep 17 00:00:00 2001
> From: Sverre Hvammen Johansen <hvammen@gmail.com>
> Date: Sun, 9 Mar 2008 21:16:03 -0800
> Subject: [PATCH] Additional fast forward strategies.

Ditto..

> New fast forward strategies, common, fork, path, and same
> is introduced.  These new fast forward strategies allows
> additional work flows.

Is it sufficient to say "allows additional work flows" here?  I only see
what they do, and do not see why these are needed/useful anywhere in the
proposed commit log message nor documentation. 

You need to illustrate the motivation after the above three-line paragraph
and before the description of what each of them does below.  "Suppose your
history looks like this, and you and your group's workflow is like this.
Then you would want to only allow these but want to forbid those for such
and such reasons."  Then list what the "FF options" do.  After that, you
can conclude "By using these FF options this way, you can achieve that
control like this..."

Then people might be convinced that "these allow additional work flows".
What you wrote is insufficient, I am afraid.  At least to me.

> +	if test $fast_forward = same
> +	then
> +		for b in "$@"

'in "$@"' is always redundant after "for X".

More seriously, why is the user forced to give more than one "same" thing
to begin with?  The user can give a single thing and be done with it.
