From: demerphq <demerphq@gmail.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 2 Dec 2010 19:10:06 +0100
Message-ID: <AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
References: <20101202114003.GA26070@raven.wolf.lan>
	<AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
	<7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 19:10:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODbj-0008Mf-Hm
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 19:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757679Ab0LBSKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 13:10:09 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45988 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757073Ab0LBSKH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 13:10:07 -0500
Received: by vws16 with SMTP id 16so1215282vws.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 10:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2V97IE2XlnZBJGZHoPKJPtp5i0sYR1h/EdKYnCKhrLI=;
        b=iPo0NdvPCzpqVH96vamp2tb16gMZGEiDQ7i8M/R4WYTTYkBIiVNI+rLfSZT6hSy0CA
         kFqhPS5dlJFgLlGsnw5U/E7I1OzFLSx8ORyAqyhY9yXDeLt0H+EM8R9ntaNpxCGg0OjU
         6nzYlGs5vMMB+uNtJhS8mvJxLeRIxl4PtPs1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CHf/qsTE6mjowN6k3K23VxQv3BfCgzpksEv404gvnac3vyXcQNTR5SCCwh9BIQahiB
         +tLgP6t1HwBk4AdM9+iVk0jkBeVun9WG65ligiDXuorUewd1L5eBnAtujJIcI4Kw/9Wf
         x4VUn44SQmkselwpPvYs0IPKrGduiiwl0fzaw=
Received: by 10.229.183.135 with SMTP id cg7mr262097qcb.296.1291313406449;
 Thu, 02 Dec 2010 10:10:06 -0800 (PST)
Received: by 10.229.192.193 with HTTP; Thu, 2 Dec 2010 10:10:06 -0800 (PST)
In-Reply-To: <7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162723>

On 2 December 2010 18:46, Junio C Hamano <gitster@pobox.com> wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Dec 2, 2010 at 12:40, Josef Wolf <jw@raven.inka.de> wrote:
>>> I am trying to use perl's Git.pm module, but for some reason, it ke=
eps
>>> bailing out:
>>
>> Why are you using it? It's for internal use only.
>
> That is not a valid question nor answer, I am afraid.

So you are saying that it is for more than internal use?

Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
