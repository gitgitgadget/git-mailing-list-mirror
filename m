From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: mention "git pull" in error message for non-fast forwards
Date: Thu, 05 Aug 2010 15:14:03 +0200
Message-ID: <vpqiq3pp5gk.fsf@bauges.imag.fr>
References: <1280756564-3932-1-git-send-email-Matthieu.Moy@imag.fr>
	<20100802191211.GA2180@burratino>
	<7vfwywk6lr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 15:14:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh0Hb-0007Il-4n
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 15:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760315Ab0HENOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 09:14:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59157 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760187Ab0HENOp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 09:14:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o75DBrVR013388
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 15:11:53 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oh0Gp-0001hi-Pk; Thu, 05 Aug 2010 15:14:03 +0200
In-Reply-To: <7vfwywk6lr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 02 Aug 2010 15\:11\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Aug 2010 15:11:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o75DBrVR013388
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281618716.16462@ba2lCfp6d47357X0zbkqmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152658>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> This reminds me: sometimes people blindly =E2=80=9Cgit pull=E2=80=9D=
 a rebased history
>> just to avoid a non-fast-forward push, and it irks me to no end.  So=
 if
>> I were running the world, the output would be:
>>
>>  error: rejected non-fast-forward push to '<url>'
>>  hint: To prevent you from losing history, non-fast-forward updates =
are
>>  hint: rejected by default.
>>  hint: See the 'Note about fast-forwards' section of 'git push --hel=
p'
>>  hint: for details.
>
> I actually like that ;-)
>
> Since we are discussing the "advice" part of the output, I don't thin=
k it
> is so bad to add the three-bullet list below to it, either, though.

The error message is one that a normal user can see relatively
regularly, as soon as he shares a bare-repository with co-workers, so
I think it should remain short. That's why I took great care to remain
within 3 lines in my patch.

Perhaps the manpage can be improved, but that's a separate topic. My
one-line patch would make a great improvement for beginners, without
harming advanced users, who still get the pointer to the doc.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
