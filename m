From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Document ls-files -t as obsolete.
Date: Wed, 14 Apr 2010 16:55:51 +0200
Message-ID: <vpq4oje2idk.fsf@bauges.imag.fr>
References: <1271252704-21739-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vaat6qesd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 16:56:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2413-0006SH-18
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 16:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab0DNO4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 10:56:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52916 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755685Ab0DNO4W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 10:56:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o3EEow6U009624
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Apr 2010 16:50:58 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1O240O-0005FJ-3f; Wed, 14 Apr 2010 16:55:52 +0200
In-Reply-To: <7vaat6qesd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 14 Apr 2010 07\:39\:30 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 14 Apr 2010 16:50:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o3EEow6U009624
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1271861459.92862@54MNrPUgg5v+rz5ayfd2UA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144881>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The behavior of "git ls-files -t" is very misleading (see
>> http://thread.gmane.org/gmane.comp.version-control.git/126516 and
>> http://thread.gmane.org/gmane.comp.version-control.git/144394/focus=144397
>> for examples of mislead users) and badly documented, hence we point the
>> users to superior alternatives.
>
> I am no entirely happy with this patch.
>
> If all your scripted Porcelain wants to see is "what are the paths I might
> want to run 'git add' on?", you do not want to run diff twice (which is
> what "status" does); you would say "ls-files -t -m -o --exclude-standard",
> instead. The alternative is not even superiour in this case.
>
> Having said that, I personally don't think of any other combination of
> flags with which "ls-files -t" is useful.
>
> If there are parts of the documentation that are misleading, perhaps that
> is what your patch should be fixing instead, no?

After having tried to understand how "git ls-files -t" was supposed to
work
( http://thread.gmane.org/gmane.comp.version-control.git/126516/focus=126520 ),
I admit that I have no idea how to document such weird behavior.

If power users want to use "git ls-files -t", let them do (I'm not
saying the feature should be removed), but I don't see a point trying
to help people to use it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
