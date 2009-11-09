From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH RFC] builtin-push: add --delete as syntactic sugar for 
	:foo
Date: Mon, 9 Nov 2009 18:20:09 +0100
Message-ID: <fabb9a1e0911090920y70ca37a6h85cb38e97976bb59@mail.gmail.com>
References: <20091109130935.2bea7771@perceptron> <7v8wefy6pi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 18:20:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7Xuu-00079C-CO
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 18:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755071AbZKIRUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 12:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754799AbZKIRUZ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 12:20:25 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48659 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbZKIRUY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Nov 2009 12:20:24 -0500
Received: by bwz27 with SMTP id 27so3691565bwz.21
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 09:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WS9aJTG7iIMwAvLhXB3XLW53dkJntku3wIz7ck1pRdg=;
        b=S+vQHRX2lwR3EIcsqpYcy1anTw0S/rl+5SjMM5KddUOwHCIuHroYquGyYY7K5v3uRq
         OhHiLphFCNgMXOlfsE7lMZA/7hHNMfnIOJVqwEF62nLDC6uY8UAxvWkqBOoLrOG8EB4r
         9O7K1JaJQujO6mhByJ0HW4j4V+YdAdjpVFBck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mR7j7KNe/gietZYwT52N7JCpgnfop9nccaWrlfMVWaDW3fJ6BEQsZTh0P0VKT+C9QQ
         OmJYPYcZkH30SwyfDU++thJIZ5+2NooEHPLeZoC0UH1Xe36RbgmWG0i/45hj0gKeIvo+
         daLy9vf8k6txCvYSb5KUpyWVPAVwgAGKuEBPA=
Received: by 10.216.90.11 with SMTP id d11mr907650wef.187.1257787229124; Mon, 
	09 Nov 2009 09:20:29 -0800 (PST)
In-Reply-To: <7v8wefy6pi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132498>

Heya,

On Mon, Nov 9, 2009 at 17:59, Junio C Hamano <gitster@pobox.com> wrote:
> Jan Kr=FCger <jk@jk.gs> writes:
>> Specifically, --delete will prepend a colon to all colon-less refspe=
cs
>> given on the command line.
>
> Will it barf and error out if there is any colon-ful one? =A0I think =
it
> should. =A0I was about to write "I guess it could be argued both ways=
", but
> after thinking about it for 5 seconds I do not see a sane way to expl=
ain a
> command line "push origin --delete one two:three".

Did we not have this discussion not 3 months ago and decided it was a b=
ad idea?

  http://thread.gmane.org/gmane.comp.version-control.git/125894

--=20
Cheers,

Sverre Rabbelier
