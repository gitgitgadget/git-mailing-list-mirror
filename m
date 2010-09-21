From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] sha1_name.c: update comment to mention :/foo syntax
Date: Tue, 21 Sep 2010 22:06:31 +0200
Message-ID: <vpq8w2ug8u0.fsf@bauges.imag.fr>
References: <7ab60e32582447ad792602ff405dcee464ef1414.1284830388.git.kirr@landau.phys.spbu.ru>
	<1285016477-22222-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v62xzug94.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 22:11:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9C2-00053j-Ik
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 22:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757314Ab0IUULv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 16:11:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:37196 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755990Ab0IUULu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 16:11:50 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8LK6awY018657
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 21 Sep 2010 22:06:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oy96l-000353-KS; Tue, 21 Sep 2010 22:06:31 +0200
In-Reply-To: <7v62xzug94.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 21 Sep 2010 11\:02\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 21 Sep 2010 22:06:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156748>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> Noticed while reviewing the patch serie about textconv and symlinks.
>> If we have comments, better have them up-to-date ;-).
>>
>>  sha1_name.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/sha1_name.c b/sha1_name.c
>> index 7b7e617..d7ab72a 100644
>> --- a/sha1_name.c
>> +++ b/sha1_name.c
>> @@ -1062,6 +1062,7 @@ int get_sha1_with_context_1(const char *name, =
unsigned char *sha1,
>>  	/* sha1:path --> object name of path in ent sha1
>>  	 * :path -> object name of path in index
>>  	 * :[0-3]:path -> object name of path in index at stage
>> +	 * :/foo -> last commit whose subject starts with foo
>
> Documenting what hasn't been is a good thing, but is it really up-to-=
date?
>
> Isn't it "a randomly chosen recent commit whose subject contains rege=
xp
> foo" these days?

I don't know.

I just tried to summarize what man git-rev-parse says:

       =B7   A colon, followed by a slash, followed by a text (e.g.  :/=
fix nasty bug):
           this names a commit whose commit message starts with the spe=
cified text.
           This name returns the youngest matching commit which is reac=
hable from any
           ref. If the commit message starts with a !, you have to repe=
at that; the
           special sequence :/!, followed by something else than !  is =
reserved for
           now.

If your description is more accurate than mine (especially about
"randomly" Vs "last" and "regexp"), then the man should be updated.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
