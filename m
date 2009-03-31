From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] send-email: add tests for refactored prompting
Date: Tue, 31 Mar 2009 09:58:12 -0400
Message-ID: <76718490903310658w2dffdfa4y4f40e0757cac8034@mail.gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	 <1238290751-57461-2-git-send-email-jaysoffian@gmail.com>
	 <20090331103303.GD3307@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 31 15:59:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoeVI-0003QD-8e
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 15:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754907AbZCaN6P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 09:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754883AbZCaN6P
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 09:58:15 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:37486 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbZCaN6O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 09:58:14 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2441074ywb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1kTZbt7rux9rJWegqH0yO2cjLyADJZgkD9R2YOTqe7E=;
        b=eXdwkt+sB6eIAqjOTdNvv+VFcpK95jLoM+8qUajsBqLFn76ituy9ghmcxi3wU8XeZn
         t1KTeAJzgJ1ZiT/8SkNsncAWS82wOqLqx/xAB+aXu65QzAd2o12Wwm05ewsQ0I295svo
         9nuUxPsnkWS7CwUUSbILLmDP/ZlqJ6yxAXn9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VcekCUZM31uNfFLX6SfBnzW8/6lbUZ86CZ7eOXRWDTHf+mGKAqpoiW4+pRUMpJJVmB
         a26ghyO/1FyAkmbDmy7qgRo79no9mAvBt3a1SXqHGqClB2oIstj7zqCjbfCZLd6j9mx6
         q4qD2Vibk/Hb0HwAvIyK7aukJX5/Dtwtsz9Jc=
Received: by 10.150.225.17 with SMTP id x17mr12623632ybg.193.1238507892412; 
	Tue, 31 Mar 2009 06:58:12 -0700 (PDT)
In-Reply-To: <20090331103303.GD3307@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115260>

2009/3/31 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
>> + =C2=A0 =C2=A0 GIT_SEND_EMAIL_NOTTY=3D1 \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git send-=
email \
>> [...]
>> + =C2=A0 =C2=A0 yes "bogus" | GIT_SEND_EMAIL_NOTTY=3D1 \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail git send-=
email \
>
> These two cause interactive prompts for me.

Hmpfh. I think the only way that's possible is if GIT_SEND_EMAIL_NOTTY
isn't being set by the shell. But I'm not sure why that's unique to
these tests.

Thanks for the report.

j.
