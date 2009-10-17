From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Subject: Re: Introduction and Wikipedia and Git Blame
Date: Sat, 17 Oct 2009 08:50:15 +0200
Message-ID: <ee9cc730910162350p250b8afak767b0626bede34e4@mail.gmail.com>
References: <ee9cc730910160207x49feb40ej692188abb0a57473@mail.gmail.com>
	 <alpine.DEB.1.00.0910161321550.4985@pacific.mpi-cbg.de>
	 <ee9cc730910160443k7e5f718bs964923a796cf38d1@mail.gmail.com>
	 <alpine.DEB.1.00.0910161548550.4985@pacific.mpi-cbg.de>
	 <7vbpk7w9qx.fsf@alter.siamese.dyndns.org>
	 <ee9cc730910161100r71818303v343f555151db4dcc@mail.gmail.com>
	 <7v7huvuptn.fsf@alter.siamese.dyndns.org>
	 <7vpr8nt894.fsf@alter.siamese.dyndns.org>
	 <ee9cc730910161419x608f5972x705ce8088d72c94a@mail.gmail.com>
	 <7v3a5irkel.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 08:50:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mz37Z-0003nc-5M
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 08:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbZJQGuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Oct 2009 02:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZJQGuO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 02:50:14 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:55148 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbZJQGuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 02:50:12 -0400
Received: by fxm18 with SMTP id 18so3210921fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 23:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HJZ44ooUFe8iutm9XFmcnCqWK0voGFylstc9PcRKPYY=;
        b=D6b1F2zYiAOJbXJLcrj922i18+oCZNe2Yrwx9fHNCqB0AJs3uch92rLq+6jtyi4Gwa
         GCd7XptWX3r0uNhjJ7OmMet0YEoI5holWBcrT4gk18WYjKGZN0VO1KnyapjAuZARKqiA
         M48sBMnbOexoZfT2QKh26kuhGEcohSkY1CtAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RUYCe5dnF37l10gxkNeoy6GBOrV2+WUsoDkZoc9/cIB3qT3e6gfA6+N1G0/bKLC54n
         AX2Iy+vXnEFWxxK2QV6VXBEDLnYmxGD2wKXlaltbHm+F7ikXpDxTPJ10i2Mx4Y8a5v4o
         kDl8uo53dBrW1VJu+2vErotVVXYOWDaya+W1Q=
Received: by 10.204.160.85 with SMTP id m21mr2208718bkx.175.1255762215633; 
	Fri, 16 Oct 2009 23:50:15 -0700 (PDT)
In-Reply-To: <7v3a5irkel.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130544>

Thank you very much for your input and advice,
I have a lot of learn about this great tool.
I am working on learning how the existing blame tool runs now.
Will report back when I have some code.
mike

On Sat, Oct 17, 2009 at 1:25 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com> wri=
tes:
>
>> What do you think of my idea to create blames along a specific user
>> defined byte positions ?
>
> Overly complicated and not enough time for _review_. =A0If you are bl=
aming
> one-byte (or one-char) per line, wouldn't it be enough to consider th=
e
> line number in the output as byte (or char) position when reconstitut=
ing
> the original text?
>
