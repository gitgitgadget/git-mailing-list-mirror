From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv2 1/3] git-sh-setup: introduce say() for quiet options
Date: Sun, 14 Jun 2009 23:15:05 -0700
Message-ID: <780e0a6b0906142315t74e64831k59e58bbc964c81f9@mail.gmail.com>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com> 
	<1245021374-8430-1-git-send-email-bebarino@gmail.com> <1245021374-8430-2-git-send-email-bebarino@gmail.com> 
	<18071eea0906141621t676a965aqc3056b481b8e8796@mail.gmail.com> 
	<7vab4ap1lf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Adam <thomas.adam22@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 08:15:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG5U1-0002GT-BR
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 08:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbZFOGPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 02:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZFOGPX
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 02:15:23 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:32802 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbZFOGPW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 02:15:22 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2428989ywb.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 23:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XImcKROfOnVvJQ/emoA4c5Z0RcxKuhNbMKGcZPOurI4=;
        b=hJyVwx0UqNvCZTjuBr7qPmWyBc6GlivRYCPfSERXGGmJoMOowToSPgA1d8z+rPM+PT
         Knc0kR8Lzyisr5iMK+Qwy8Dr0GGlbmX4LDtVssT9UE9HQ7ToJoZw0o5I3/6fwGSPudDm
         VEUv9A4FQjmnnLHaOE4gR7Vdnx/ScVHnP/r14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=H+oPUx384ZSSqwiDJIN6RXFyEnM1qo6+k+u7Y0puybRzqx4MMTpfDswblpG1KAuVef
         4UTqw196dCRqSjtFG15H3pS9EMbksGAb677M8aVEoKeZFfoN7vmtpP5mpezf7Tr6gyOl
         a+lMIvEN7OcQJhNKZ8oBOEShISv7HZGkGlmGg=
Received: by 10.100.241.8 with SMTP id o8mr8194817anh.102.1245046525106; Sun, 
	14 Jun 2009 23:15:25 -0700 (PDT)
In-Reply-To: <7vab4ap1lf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121584>

On Sun, Jun 14, 2009 at 9:23 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
>
> To make the conversion of the above hunk correct, say() must use
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf "%s" "$*"

Thanks for the background information. This hunk was in the original
series but I guess nobody noticed. I'll fixup these issues in the next
round and maybe add a test for this case.
