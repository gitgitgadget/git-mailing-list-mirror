From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3] merge-file: add option to specify the marker size
Date: Mon, 1 Mar 2010 10:18:25 +0100
Message-ID: <36ca99e91003010118m77b26675j63ed983fcb702ace@mail.gmail.com>
References: <972adf380be481b5e8d031481586e9c34da2cbb7.1267385538.git.bert.wesarg@googlemail.com>
	 <7viq9h3yql.fsf@alter.siamese.dyndns.org>
	 <36ca99e91002282315m6c3caf1el61755c0d96d21cf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 10:18:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nm1lo-0007bk-CU
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 10:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138Ab0CAJS1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Mar 2010 04:18:27 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:64963 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab0CAJS0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Mar 2010 04:18:26 -0500
Received: by fxm19 with SMTP id 19so476223fxm.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 01:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i8Agpk+vrqlUWpo/GQzR/MScZLbSbDBbdRXdQXLFWuk=;
        b=fKpb0hnMIDNc2Mwc2M+xNydtO1M/DxjXf055eG0jhzccv25RxVlVPorqbEYJSRorv1
         9mxYVNZg/MHkYsXUzDEq9MhUh9FOebNg9mbB9NkzIZsDDOfLtIpzwFd0Yhha0V06W+R4
         CcQ50CsTrSZ8DKww+3fl7nMArl6v+1UcE4GOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fu4Lmhre0Bo7iEw1dxWrEj169EmmtXtsjQmWdsubsUniBWiwzcM6d9qvLG8GObvjth
         UmRS2Sa41mn7Ui2ry4WuIqrYHChIUJewD0x0TyqNd6dAvKUGjuD96UZZckU5m8YMyE4n
         qIgpR0svDkCefJ28/9s7OWC5LQiFRBRYZraPY=
Received: by 10.223.5.92 with SMTP id 28mr4686504fau.26.1267435105316; Mon, 01 
	Mar 2010 01:18:25 -0800 (PST)
In-Reply-To: <36ca99e91002282315m6c3caf1el61755c0d96d21cf2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141310>

[ Sorry again, I removed the list again ]

On Mon, Mar 1, 2010 at 08:15, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> On Sun, Feb 28, 2010 at 21:13, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>>
>>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>>
>>> ---
>>>
>>> This can probably improved in a way, that the marker size will be t=
aken
>>> from attributes. This could be done by an explicit --marker-size-by=
-path
>>> option or an option which names one of the three input files as a g=
it
>>> path.
>>
>> You don't want any option that is specifically about "marker size". =
=C2=A0An
>> option to specify the path to take attributes for would be the right=
 way
>> to go. =C2=A0You might want to see "hash-object --path" for an inspi=
ration.
>>
> So you suggest that it is only possible to set the conflict marker
> size for merges inside a git directory? I don't think this is a good
> idea, for a tool which is designed to work also outside of a git
> directory.
>
> In any case, if we add a --path option, merge-file should use ll_merg=
e
> in this case, right?
>
> Bert
