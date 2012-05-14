From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Mon, 14 May 2012 21:53:10 +0200
Message-ID: <CAMP44s2L=s4bd-sDcY3RWLWe9=YzLgC7UavgnE6K0akMCJSK4w@mail.gmail.com>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
	<7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
	<CAMP44s1pb+J_SAzZ66QVcWq4V=LauUQ2VmzMD8KBtnhjubkkVg@mail.gmail.com>
	<7vmx5ahbrm.fsf@alter.siamese.dyndns.org>
	<CAMP44s1h=MPT8vx6JrGjMZWJzRjndxYKoYgo+1Y_Mmv+gWXzaQ@mail.gmail.com>
	<7vaa1ah95p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 14 21:53:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU1Kk-00044e-J8
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 21:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757729Ab2ENTxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 15:53:13 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:42768 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757720Ab2ENTxM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 15:53:12 -0400
Received: by lahd3 with SMTP id d3so3615896lah.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 12:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=58FdD8PfA+/xzwBPi8jxxaq538LY5W1xyCr8OUa51g4=;
        b=PrtGpEaKf78LfISXpjF9qdL9N5Db8yxmS1xaJ9f24FpUHGdhJ/PiaTc55TIK4sghUL
         t9coZoCr/zIsTjmh/gLJx6/HIugWABa8zuaVVDLIjpKjODPosSXhjAGFl0ombGDYz/wW
         GxdsE0ZYYn36WyZL+skZoOSxlYbZHdUis3zS+aCTqHur217JIE9ksAtrRjGxuH9z7dt4
         hLYSncHAztxU/o/IvVAfs4quESHLCISpAirnNKBvjsO3hKxB2K+19nDcGTrkgYCSVxEH
         yNBaD1mvmoEmTs2s//iLaCwC3s7VPbjUFkweT8NwC+FeuOWlBf92EAAuj7srckBzcM3C
         dlHQ==
Received: by 10.112.98.70 with SMTP id eg6mr4323730lbb.13.1337025190757; Mon,
 14 May 2012 12:53:10 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Mon, 14 May 2012 12:53:10 -0700 (PDT)
In-Reply-To: <7vaa1ah95p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197805>

On Mon, May 14, 2012 at 9:09 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Here is my attempt to explain why none of them needs to be quoted:
>>> ...
>> I don't understand that.
>
> That was my attempt to give the readers some context to understand wh=
at
> comes after that. =C2=A0If the original patch author does not underst=
and it,
> perhaps it is an indication that the function is somewhat underdocume=
nted.

I mean I don't understand this "Note that none of the variable
reference in the implementation of this function needs dq around it."
I suppose you meant 'references' (as that would make it grammatically
correct AFAICS), but I still don't understand what you are trying so
say. That the way the arguments are used in the __git_complete
function makes it so double quotes are irrelevant?

If so, then yeah, I agree.

Is there something actionable?

--=20
=46elipe Contreras
