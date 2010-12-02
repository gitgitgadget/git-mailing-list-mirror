From: demerphq <demerphq@gmail.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 2 Dec 2010 19:32:21 +0100
Message-ID: <AANLkTin40H-tEUScW3tuVkWkpP0gexsqM_hxBitmdZHW@mail.gmail.com>
References: <20101202114003.GA26070@raven.wolf.lan>
	<AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
	<7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
	<AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
	<7v4oawrqb0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 19:32:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODxF-0002yZ-09
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 19:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757292Ab0LBScX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 13:32:23 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44388 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab0LBScW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 13:32:22 -0500
Received: by qwb7 with SMTP id 7so8672903qwb.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 10:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mdLCXz0dYDIGOmTknTJmsqQYA7HILNRJlCpDFH1SZgg=;
        b=pcqH49913yxJQ4tJNQuf5nId1sXu83S5KXM95g2WtTaRTGpZKSLN/PRjpKQXMdTEhD
         aGdu2Xk8kBT8Bw4WqGPuz6ZerCCXmztIY0ry1uG1uYgpW9OzhYF93qCdfIFjjtXHnQxY
         AJibER7oKa1frpXJ9qlXIDcCn/C9io1xfbMjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lWqocWM4Cv46OtH/OQFHr1Eh7pQFZpRldGj1rVUGW3vxL9YPS5B/5g3RNPLT6zJq8k
         Ha9uZQDVv04VMDotcHzvjQ/j0ECIWwCgqSFdfq3901bDA2Wr4GMac97ScUDGFGEgLA5w
         T6Togn8QfQqAT2XTJ3yNp9R86wD+dU9tnqG0E=
Received: by 10.229.251.204 with SMTP id mt12mr306151qcb.182.1291314741791;
 Thu, 02 Dec 2010 10:32:21 -0800 (PST)
Received: by 10.229.192.193 with HTTP; Thu, 2 Dec 2010 10:32:21 -0800 (PST)
In-Reply-To: <7v4oawrqb0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162727>

On 2 December 2010 19:18, Junio C Hamano <gitster@pobox.com> wrote:
> demerphq <demerphq@gmail.com> writes:
>
>> On 2 December 2010 18:46, Junio C Hamano <gitster@pobox.com> wrote:
>>> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> On Thu, Dec 2, 2010 at 12:40, Josef Wolf <jw@raven.inka.de> wrote:
>>>>> I am trying to use perl's Git.pm module, but for some reason, it =
keeps
>>>>> bailing out:
>>>>
>>>> Why are you using it? It's for internal use only.
>>>
>>> That is not a valid question nor answer, I am afraid.
>>
>> So you are saying that it is for more than internal use?
>
> No.
>
> Imagine you were adding a new function to git-svn.perl and wanted to =
know
> why your addition that looked somewhat similar to what Josef sent did=
 not
> work as you expected.
>
> We should be able to answer such a question, don't you think? =A0Peop=
le
> often seem to badmouth this list as git develper's list that is unfri=
endly
> to end users. =A0I don't think that is true, but even if that were tr=
ue (or
> especially if that were true), shouldn't we be try to be friendly at =
least
> to a potential developer who tries to learn and use Git.pm module?

Certainly. My question purely had to do with whether it is for
internal use or not.

The reason I asked is that I don't think it is for external use, and
wanted to make sure you agree.

cheers,
Yves





--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
