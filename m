From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Fri, 31 Jul 2009 15:38:37 +0000
Message-ID: <94a0d4530907310838nbca0037u1a192dc07a379e66@mail.gmail.com>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7vljm84htf.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com>
	 <20090729174000.6117@nanako3.lavabit.com>
	 <94a0d4530907301727h171a2581ybee2a5b2d77e7c05@mail.gmail.com>
	 <7v3a8d65kv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 17:38:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWuBz-0004oO-9U
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 17:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbZGaPii convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Jul 2009 11:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZGaPii
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 11:38:38 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:50978 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbZGaPih convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 11:38:37 -0400
Received: by fg-out-1718.google.com with SMTP id e21so628680fga.17
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kma4T9oOj5MlBX48TIes1YXRpXZ863Fkg9vqn+OmHQU=;
        b=ikH5zbHmdmoojtuVj3puAWDvL8gOGI8ZQv1ZO1YiInV/+7XukoPr+U4pWXWJeMFQP7
         lzmpqP6f+jQ1TbucA/nyhScx07EDSr7Pzi01pN3L3QSdH+9SYTnrmSdLB16Yexn7HoEW
         dF99/79XmfqJ5isUSv5hlKcmy9jEa4JVzCd2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BBNHzB9WNFUprseAgI801xGVj8PTcUCd2Tz5wD9zudae0JoxCk8FNQGIH0xaYcrcM2
         EZFJKKxAcWrGgDQ2+/znv8XwtA700Db9kGAth14b49HX913eTHYaYAaFqAL6njncwa40
         E7gn/Ft0dMzm+TlhVEvnZ/su0a23aKJXcRGF4=
Received: by 10.86.68.6 with SMTP id q6mr798577fga.20.1249054717316; Fri, 31 
	Jul 2009 08:38:37 -0700 (PDT)
In-Reply-To: <7v3a8d65kv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124569>

On Fri, Jul 31, 2009 at 12:48 AM, Junio C Hamano<gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Google:
>> ignore space change: 17,300,000
>> ignore white space: 181,000,000
>
> But that is not relevant either. =C2=A0"ignore white space" is a supe=
rset of
> "ignore space change", iow the latter has more specific meaning than =
the
> former. =C2=A0It is not surprising to see that search engines find la=
rger
> number of references to more general terms than more specific ones.

The fact remains the same: white space is a much more used term, and
IMHO the only one that really matters.

--=20
=46elipe Contreras
