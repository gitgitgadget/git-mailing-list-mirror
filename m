From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: allowing aliases to override builtins to support default options
Date: Fri, 6 Mar 2009 18:51:22 -0500
Message-ID: <76718490903061551m24a95ed8r2e334ff0e6f0fcf3@mail.gmail.com>
References: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>
	 <7vhc26qls3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 00:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfjqX-0003IE-Hr
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 00:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335AbZCFXvZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 18:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754735AbZCFXvZ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 18:51:25 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:47953 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbZCFXvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 18:51:24 -0500
Received: by rv-out-0506.google.com with SMTP id g37so726283rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 15:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DFhJqEQ3qM8x86mMJZEUvItzTnvNeFVctbs2DtgajOM=;
        b=bTq8buDjQeuLZUX5rXdjj3/2P7ROnmxbwPgQOO+SIh0LV7mLavskG81SSt8Zwo3VBJ
         tMKHnlL81n+UBHrBz4NxWnYaotiOaXnf+gB5cbG6XubgT5HiFexoIQfHvzE2hX7jR+Ve
         41NGCZBZNWKlVlcHxXNthJ0MgnxGlp+Ie2o1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Im5aMdZz5Na+pdicJgnqeFmeKllYzUQ6X7izaTaxzk8rpY98fpRNckNSZTBwrtEwJA
         R45Urooj0Sj0AmC4f2mQnT+CJgLEhj/GB6rsWLdQHz0xW40c2gVTui9cqR15CDe2im6i
         nAimzKLEs2FjabByiHdacpU3rxX7Uqxpu7D44=
Received: by 10.141.196.8 with SMTP id y8mr1547482rvp.101.1236383482347; Fri, 
	06 Mar 2009 15:51:22 -0800 (PST)
In-Reply-To: <7vhc26qls3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112494>

On Fri, Mar 6, 2009 at 6:22 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Because sane shells do not expand aliases when used in a script, and =
gives
> a handy way to defeat the alias even from the command line.
>
> =C2=A0 =C2=A0$ alias ls=3D'ls -aF'
> =C2=A0 =C2=A0$ echo ls >script
> =C2=A0 =C2=A0$ chmod +x script
>
> and compare:
>
> =C2=A0 =C2=A0$ ./script
> =C2=A0 =C2=A0$ ls
> =C2=A0 =C2=A0$ /bin/ls

Understood. And if git could do the same, still no?

j.
