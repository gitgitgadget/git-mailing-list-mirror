From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 28 Nov 2012 01:10:34 +0100
Message-ID: <CAMP44s10krOPD73dL0Ancie=kussk89jK7V5adR3hw=a73CVWw@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
	<CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
	<50B1F684.5020805@alum.mit.edu>
	<CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
	<20121127143510.GA15831@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: =?UTF-8?B?TWFnbnVzIELDpGNr?= <baeck@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 01:10:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdVEp-0001r5-5v
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 01:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab2K1AKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 19:10:35 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45151 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab2K1AKf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 19:10:35 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so11519381obb.19
        for <git@vger.kernel.org>; Tue, 27 Nov 2012 16:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Y32w2DF27lAdl7YLN8sNrpQ0bdjDKvv5pdZS5RlOMg8=;
        b=HXf4kUFHEhOjDbEbVoqFHkAzt9VIytB6/lnifEIGnu3FinuDgfEbCzzuahf2BQA93S
         jwucfYt4yGL5VwGOM0laKTi/cIg6uRLe6FcjudkBxLGbO9cHZMIp1YdRqWsUlnWwak4e
         M+IQWOP4BLiw9FkjLdrnHktPDOKyLnU5qqG4UcJd+8rkWk6S9uFlfjz8vwWuYeOwxKB1
         ZWQd6iivWOx16jQ8IrpYb42HNWq0MIpmsQUlzL4IoROpFA/Z5EN5uL/iVKD/M4+3igeE
         c5DSR5yG59Ts3/XlWoMagRwGGyHGhNi9ScLGw7oeyS1uaVVyOexPp+1Db+3rRZ4XPRr8
         W7Cw==
Received: by 10.182.17.72 with SMTP id m8mr1349282obd.55.1354061434517; Tue,
 27 Nov 2012 16:10:34 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Tue, 27 Nov 2012 16:10:34 -0800 (PST)
In-Reply-To: <20121127143510.GA15831@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210636>

On Tue, Nov 27, 2012 at 3:35 PM, Magnus B=C3=A4ck <baeck@google.com> wr=
ote:
> On Sunday, November 25, 2012 at 06:40 EST,
>      Felipe Contreras <felipe.contreras@gmail.com> wrote:
>
>> On Sun, Nov 25, 2012 at 11:44 AM, Michael Haggerty
>> <mhagger@alum.mit.edu> wrote:
>
> [...]
>
>> > On the contrary, there is *constant* traffic on the mailing list
>> > about incompatibilities between different shell implementations (s=
h,
>> > dash, bash, etc), not to mention those in other utilities (sed,
>> > grep, etc) that one is forced to work with in shell scripts.
>> > Compatibility is a *huge* pain when developing shell code for git.
>> > The fact that users typically don't encounter such problems is due
>> > to the hard work of POSIX lawyers on the mailing list correcting t=
he
>> > compatibility errors of mortal programmers.
>>
>> *Theoretical* incompatibilities on probably obscure systems. *I* hav=
e
>> never seen such compatibility issues *in practice*.
>
> While "constant traffic" probably overstates the issue, these are not
> theoretical problems. I recall at least three cases in the last year
> or so where Git has seen breakage with Solaris or Mac OS X because
> of sed or tr incompatibilities, and I don't even read this list that
> thoroughly.

Most of the *constant* traffic is about *theoretical*
incompatibilities, how much of that are real incompatibilities, it's
not known. _Some_ of the traffic is about real incompatibilities,
sure, but you could count only three cases *in a year*. It's not a
huge amount. And then, how man this year?

Also, I would like references to those incompatibilities.

Cheers.

--=20
=46elipe Contreras
