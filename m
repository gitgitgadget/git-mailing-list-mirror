From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Sun, 13 Jul 2008 18:21:05 -0400
Message-ID: <32541b130807131521w79cbf23m5934678e68312798@mail.gmail.com>
References: <20080710170735.4c5b237a@linux360.ro>
	 <7vskudr11m.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131432j78e5100dyea20893268321466@mail.gmail.com>
	 <7vbq11qxfb.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131444s5e9ea0d6v9610dd5871467fc9@mail.gmail.com>
	 <7vvdz9o2wu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eduard - Gabriel Munteanu" <eduard.munteanu@linux360.ro>,
	ryan@michonline.com, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 00:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9xJ-0005LE-BD
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 00:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbYGMWVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 18:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754121AbYGMWVI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 18:21:08 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:12733 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbYGMWVG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 18:21:06 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2280659ywe.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ov1UIJn/vVfS+1Wcts3YdKelr2wbBLm3rJdJ7+ZZQHI=;
        b=qoXvbHjjYvHCTvJppNuHPTg0QLOfda9Hs1x7jd4verrVeSznzY66Pzr09FAaBwIfHl
         QR1vvLm9MMLSMmtPDY999KvZR6nREN5MhgBjRbjuMXOMMy6fC1pb76dzJqgT6dge4Soz
         ge1Wg/8NpGdiZLFRorqC/+f57xAwgIOSDdCNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eSM6djiRuzw6BJ6SMgJhlYo4m1ZpeOfKsx1sExzWbUutnFCoEkSxDMWZc52iqDYveu
         9dSS7MD+I9BzFjw9C+gjtg9tGr4onN38TAdi5tO58RnmeOTe7Ah31uVVWIfoSDBlcahI
         cvbYttQMEpnrQqqPf1gzTODZkIxRB4QAkDPR4=
Received: by 10.151.11.19 with SMTP id o19mr11732892ybi.107.1215987665153;
        Sun, 13 Jul 2008 15:21:05 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Sun, 13 Jul 2008 15:21:05 -0700 (PDT)
In-Reply-To: <7vvdz9o2wu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88353>

On 7/13/08, Junio C Hamano <gitster@pobox.com> wrote:
> Heh, so by that definition Gnus is not modern enough; neither is webmail
> interface at gmail.
>
>  From which has originally zero level of >
>  >From which has one
>  >>From which has two
>  >>>From which has three
>
>  I am reasonably sure the above will be sent with one, one, two and three
>  gt before "From".  Is your mailer modern enough?

I read this message at gmail, and got zero, one, two, and three
dashes, respectively.  For the sake of interest, I then connected to
gmail using IMAP from mutt, and the message was still intact.  Then I
saved it to an mbox file using mutt, and it used Content-Length
instead of From munging, so it wasn't a very good experiment :)

If you're not actually delivering your mail using mbox format (as
opposed to imap, webmail, etc), it would be quite insulting for "From
" to be munged at all, so I'm happy at least that I didn't experience
that in my tests.  On the other hand I'm surprised that gmail should
have corrupted it for you; gmail should be able to completely forget
about the concept of "From " munging since they don't use mbox
internally.  (And it's the MDA's job to munge it, not the MTA, so the
lines should never be munged while in transit *to* gmail unless the
mailer app is extremely buggy.)

Have fun,

Avery
