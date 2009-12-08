From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH 2/2] git-rm doc: Describe how to sync index & work tree
Date: Tue, 8 Dec 2009 07:19:03 +0100
Message-ID: <6672d0160912072219g4326bb5pde7bd02c09a9556a@mail.gmail.com>
References: <4B1D4AFE.6090708@gmail.com>
	 <7vpr6qze4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 07:19:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHtPj-0006bX-Mh
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 07:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934543AbZLHGS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 01:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbZLHGS7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 01:18:59 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:48715 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932734AbZLHGS7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 01:18:59 -0500
Received: by bwz27 with SMTP id 27so4137448bwz.21
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 22:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Sc0MLx4h6FKwmAaLrJX9IE2hJZzufuaAYBjnljYOEMo=;
        b=w+csItwvjYftaRDknK2KOG9UW4YT/ohHtgJVMtthrx6THyaperzLIQMujfEcpDKdmJ
         IlSE9mksBmLhLQYg6oYburlNKm+f6TwUSR9JYyXGPsn1lyYOlxhCjbbgfU9TFdlDFTvL
         VsBVxiptYC9/7SKExx0GeEbEgdCEFjR4jMPio=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C0nAiDGvlr4PFYXq178yarrCJ3cINCRjWSpS3lXitBkNsOJmvnGbKVqQadfrRpUp+4
         b09yvT8ZAmZoRCU3HwyMmraa0JuMQdqUOhlw++sIOkwbwCmHCRGQa9j8Wk4VhlN92nXk
         y8HxwrYt/hYOTk/4GE7AidHmfBrEdnKfTqO1U=
Received: by 10.204.162.143 with SMTP id v15mr1723977bkx.50.1260253143321; 
	Mon, 07 Dec 2009 22:19:03 -0800 (PST)
In-Reply-To: <7vpr6qze4i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134822>

2009/12/7 Junio C Hamano <gitster@pobox.com>:
> I think mentioning "add -u" in the same section as "commit -a" would =
be
> helpful, as these two are more for user's own development (as opposed=
 to
> vendor-code-drop). =C2=A0I'd perhaps squash something like this in. =C2=
=A0Please say
> "yes", "don't, it is horrible", or something in between ;-)

Yes, but...

> -automatically notice and record all removals.
> +automatically notice and record all removals. =C2=A0`git add -u`
> +can be used for a similar effect without commiting.

s/commiting/committing/

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
