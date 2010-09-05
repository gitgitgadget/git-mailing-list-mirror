From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [demo/patch 0/3] Re: [PATCH] Documentation: document the
 string-list macros.
Date: Sun, 5 Sep 2010 20:19:15 -0300
Message-ID: <AANLkTinP1XNsVCnyL+dnn_+up1Oi6aSxiaA_JjdKDGje@mail.gmail.com>
References: <1283709077-5438-1-git-send-email-tfransosi@gmail.com>
	<20100905200323.GA14497@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 01:19:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsOUc-0006xt-Qq
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 01:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab0IEXTR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 19:19:17 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:53574 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197Ab0IEXTR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 19:19:17 -0400
Received: by qyk33 with SMTP id 33so3808780qyk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 16:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vi8H/7pri3vFBC0ggfavptL++P279wApFEZ55COLxDs=;
        b=m/3pAa9iCk2OOseW559U1kdWnc+cBs6XBC1xcfVDdE5KaL3HoivgRuNlEoMd5kZbUe
         RRqR7jaxGIfb2EyiwoFUg9QvoRZZnMpQ05Gy+DB438iVVqdg5z4t9Js02u3UlSl4Lfqx
         gg+6N2h/u8nGjLdVI6egHnWS3VWwP5RC7+Rhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h+DzG9TUNFkICnqrZMoAXHWGtglkjHjDKzsFUclGEdPv7qc9KEJsa7K8HPy/uo/BaA
         ReXXyfqJ1M380WXKKyzIsUiV0dm0N9ycZjbzBkfPMTBDv5YhS+SQ/O0qmgcoxDwijDgz
         m54doFIzNZWX8+VFQgfzr3Kd06zwZ6vWyXmBE=
Received: by 10.229.222.6 with SMTP id ie6mr2896196qcb.28.1283728755563; Sun,
 05 Sep 2010 16:19:15 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Sun, 5 Sep 2010 16:19:15 -0700 (PDT)
In-Reply-To: <20100905200323.GA14497@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155495>

On Sun, Sep 5, 2010 at 5:03 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Thiago Farina wrote:
>
>> --- a/Documentation/technical/api-string-list.txt
>> +++ b/Documentation/technical/api-string-list.txt
>> @@ -52,6 +52,18 @@ However, if you use the list to check if a certai=
n string was added
>> =C2=A0already, you should not do that (using unsorted_string_list_ha=
s_string()),
>> =C2=A0because the complexity would be quadratic again (but with a wo=
rse factor).
>>
>> +Macros
>> +------
>> +
>> +`STRING_LIST_INIT_NODUP`::
>> +
>> + =C2=A0 =C2=A0 Initialize the members and set the `strdup_strings` =
member to 0.
>> +
>> +`STRING_LIST_INIT_DUP`::
>> +
>> + =C2=A0 =C2=A0 Initialize the members and set the `strdup_strings` =
member to 1.
>
> After reading that, one might be tempted to write
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct string_list x;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0STRING_LIST_INIT_NODUP(x);
>
> , no? =C2=A0In other words, I don't find the text very clear.
>
Yeah, you are right.

> If you like working by example (like I do) then api-strbuf.txt might
> give a good indication of how this sort of thing can be helpfully
> documented.
>
I have looked into it :-)

> Maybe something in this direction?
>
> Patch #3 in particular is very rough
Oh yeah :)

> =C2=A0This is not meant for application, just to give an
> idea.
>
I like the idea. I will improve the Documentation based on or version.

Thanks.
