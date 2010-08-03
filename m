From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Tue, 03 Aug 2010 11:16:43 +0200
Message-ID: <vpqzkx45a4k.fsf@bauges.imag.fr>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<4C52E6E1.20101@xiplink.com> <vpqd3u53sd2.fsf@bauges.imag.fr>
	<AANLkTikMW=ueQXfjpXk8G2FLRN55j1aJsnNz2w19BmkH@mail.gmail.com>
	<AANLkTi=uPHiS2S2hR4=0oBC=s3SyEP_qo3+n8FNHkFEV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kris Shannon <kris@shannon.id.au>
X-From: git-owner@vger.kernel.org Tue Aug 03 11:20:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgDfz-0005UI-Hz
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 11:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab0HCJUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 05:20:42 -0400
Received: from imag.imag.fr ([129.88.30.1]:44271 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125Ab0HCJUl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 05:20:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o739Gh9W025439
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 3 Aug 2010 11:16:43 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OgDc3-0008BF-Ds; Tue, 03 Aug 2010 11:16:43 +0200
In-Reply-To: <AANLkTi=uPHiS2S2hR4=0oBC=s3SyEP_qo3+n8FNHkFEV@mail.gmail.com> (Kris Shannon's message of "Tue\, 3 Aug 2010 18\:47\:12 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 03 Aug 2010 11:16:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152494>

Kris Shannon <kris@shannon.id.au> writes:

> On 31 July 2010 23:56, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.co=
m> wrote:
>> On Fri, Jul 30, 2010 at 15:24, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> > Marc Branchaud <marcnarc@xiplink.com> writes:
>> >
>> >>> The name of the command may be subject to discussions. I've chos=
en
>> >>> "run", but maybe "shell" would be OK too. In both cases, it does=
n't
>> >>> allow the one-letter version since both "r" and "s" are already =
used.
>> >>
>> >> "exec" with one-letter "x"?
>> >
>> > Thanks, that sounds good, yes. Any other thought?
>>
>> I like "exec".
> or (t)est.

testing is one possibility, but you may want to do other things, like

pick <commit> ...
exec perl -pi -e 's/foo/bar/g' file.c; git add file.c; git commit --ame=
nd

or whatever. "exec" is definitely the best proposal.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
