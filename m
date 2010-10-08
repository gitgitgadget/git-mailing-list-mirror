From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH 0/6] Unify argument and option notation in the docs
Date: Fri, 08 Oct 2010 22:15:57 +0200
Message-ID: <8739sgtp8i.fsf@gmail.com>
References: <87fwwhszsf.fsf@gmail.com>
	<1286559080-27257-1-git-send-email-stepnem@gmail.com>
	<7v1v80wjuw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 22:17:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4JNP-0001Mw-Hi
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 22:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758120Ab0JHURF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 16:17:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60765 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754970Ab0JHURE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 16:17:04 -0400
Received: by fxm14 with SMTP id 14so720430fxm.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 13:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=UwR64+LtizmueqrnvJR8rHJBIHyx6LYitb8T/kzZjRI=;
        b=v2Hgqh0RzqeC0I8jiDyraXuRp7Dmipzzcuh+ROy+2HpdW7ZkeUK4iimmQ9xlZk3sT0
         MKGNbGRaS9KDlxFIBuUBtg2wKDnqqrs/KYqSlEXu764CDP+g0DU0DbpYDWIB5cxbEkE8
         4dEtgxBqHgZWHtiEP4LbY+OOKZXu9FyAHhW6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=VAMrxOypZfnGck07jVD+evGtw7z+GznZ/ygu9ptWZvPqKz8vkBTZsihj8gT78HELBV
         4w/9cZFtTwaW36eJRlAVkH4dMmKqpD/sdS+PGa8HqpfWNC4/uRlHMqWWWHiaEsJFC1c0
         ENqyeAciZ3NT8WJmNBQxwNYCSKC1rL5VXDR3g=
Received: by 10.223.104.70 with SMTP id n6mr3818941fao.53.1286569022510;
        Fri, 08 Oct 2010 13:17:02 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id j14sm1800863faa.23.2010.10.08.13.16.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 13:16:59 -0700 (PDT)
In-Reply-To: <7v1v80wjuw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 08 Oct 2010 12:43:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158535>

Junio C Hamano <gitster@pobox.com> writes:

> I had to fix up the whitespace damage in the rerolled 2/6 but otherwi=
se
> looked good.

Yeah, sorry for that. Obviously the tabs got replaced by spaces when I
copy-pasted the hunk and I didn't notice.

> Thanks, both.  It might make sense to outline the rules applied somew=
here in
> CodingGuidelines to help people who add to our documents.  Something =
along
> the lines of...
>
>  - A placeholder is spelled inside angle brackets, e.g. <file>, <obje=
ct>.
>
>  - Choosing one from many is written with possible choices separated =
with
>    a vertical bar and the whole thing enclosed in parentheses, e.g.
>    answer=3D(yes|no|true|false)
>
>  - Repetition of zero or more times of X is spelled as [(X)...], e.g.
>    [(-p <parent>)...]

:-) I was actually considering just that, so I'm glad you mention it.

I can try to compile an initial version of such a document, based on th=
e
commit message of the original single-patch version
(<http://article.gmane.org/gmane.comp.version-control.git/158467>) and
including some more cases/examples.

Where do you think would be the most appropriate place for it?
Just add a section to CodingGuidelines, or a separate
Documentation/WritingGuidelines or something?

=C5=A0t=C4=9Bp=C3=A1n
