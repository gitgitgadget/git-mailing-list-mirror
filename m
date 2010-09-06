From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [Patch v3] string-list: Document STRING_LIST_INIT_* macros.
Date: Sun, 5 Sep 2010 21:38:01 -0300
Message-ID: <AANLkTikivCxU8Si-p1u4H6GtQfrdQdrHcBpr0Smkf5Rq@mail.gmail.com>
References: <1283731991-15080-1-git-send-email-tfransosi@gmail.com>
	<20100906002249.GB18060@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 02:38:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsPir-00057A-MW
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 02:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab0IFAiE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 20:38:04 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59054 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0IFAiD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 20:38:03 -0400
Received: by qwh6 with SMTP id 6so3424524qwh.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MC8IJ3miEvuP7JninOm33qVHXmM/MlxgkXdTREtEV7s=;
        b=Nwrk2qYRBbfWaTXWraXoOgtJ6NoG0UBqiINDtYwEphPgDSXZRfkF6qMB6dXU+yZ/nd
         6stYDztuc3hERQcvZDhdUiDZC/Okqx9Bg4nllvxw2bR8rs1zgNfYJAxHSGI//hauCLOE
         Mp1d1TW8G+oTyI/pEzGBJzSLKOKl1jLIelV2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S9VzOuLQWW2RrG9+gXHLFUphQjFC6Wq/p2AR1+ljmy8ry6aNt+KmZEdPB1tjfdZtcU
         P9DpSxnrFi/YTRpJtKIQksyoU3nPfyywTfNCqpLQ6AP2KRR26ZjEZSeIHBnkql8Ogolk
         9bWfk3IeVJTKMQK/oTneccHkT7L4+zl4mfCSg=
Received: by 10.224.80.133 with SMTP id t5mr1110177qak.341.1283733481830; Sun,
 05 Sep 2010 17:38:01 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Sun, 5 Sep 2010 17:38:01 -0700 (PDT)
In-Reply-To: <20100906002249.GB18060@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155509>

On Sun, Sep 5, 2010 at 9:22 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
>> @@ -34,10 +39,9 @@ member (you need this if you add things later) an=
d you should set the
>> =C2=A0Example:
>>
>> =C2=A0----
>> -struct string_list list;
>> +struct string_list list =3D STRING_LIST_DUP;
>> =C2=A0int i;
>>
>> -memset(&list, 0, sizeof(struct string_list));
>> =C2=A0string_list_append(&list, "foo");
>> =C2=A0string_list_append(&list, "bar");
>> =C2=A0for (i =3D 0; i < list.nr; i++)
>
> Probably worth copying and pasting this code to another file and
> trying it to make sure it works for the final draft.

I already done in the test-string-list.c patch I sent. :-)
