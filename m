From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Wed, 22 Dec 2010 21:08:37 -0200
Message-ID: <AANLkTini5cxGi2vZeDEkGWxw5BXa3ZK0jqzG+Dy2oQ73@mail.gmail.com>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
	<AANLkTin_u9FiZf-hbnhY0Dp+LifctxH8wKDL=yRrSpm+@mail.gmail.com>
	<7vvd2l4jpx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 00:08:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVXnY-0008Eo-9A
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab0LVXIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Dec 2010 18:08:39 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:61704 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689Ab0LVXIi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Dec 2010 18:08:38 -0500
Received: by bwz16 with SMTP id 16so6273690bwz.4
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DcnxkV0sbZxdhBokNPvL7wtOD6nH13f7VKyTcmPtguI=;
        b=w+ZP8RRF+scygYiS4HnYy3hWI4xmHU5fD+ZoLKIEM//9+Sbm5AJ2Km/YOGlF5eU7HY
         Kd8n3MSxvmRQfj7x84xwywa4o9qa8ehAKaL9BS5HKdsItJtrz9hiwE413+V2xSTGBoxu
         pt1clNeAJ8z/wUtuXMiydnwUT7gDBbqXZM2zE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jKeuz0w95yUq21CCLqVc9VCNSlPe/1FWe27a16ov4SMjPQ48lJimoLgIB+THUbRfFS
         vi60kzKp6b9iNjGM3fITWuaohI5idEqKk6IN63/nhS0Yk5hHTKRXyehISU6rryYgebdx
         6H+q8Sqanrqht6wr9+5qJwMXxewUMRSYwj/NY=
Received: by 10.204.64.139 with SMTP id e11mr6494361bki.97.1293059317498; Wed,
 22 Dec 2010 15:08:37 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Wed, 22 Dec 2010 15:08:37 -0800 (PST)
In-Reply-To: <7vvd2l4jpx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164099>

On Wed, Dec 22, 2010 at 6:48 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> On Tue, Dec 21, 2010 at 11:59 PM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>> * tf/commit-list-prefix (2010-11-26) 1 commit
>>> =C2=A0(merged to 'next' on 2010-12-21 at 16e1351)
>>> =C2=A0+ commit: Add commit_list prefix in two function names.
>>>
>>> This churn
>> Since you said that, can could you drop this patch? I don't mind if
>> you discard this patch since you consider it a CHURN[1].
>>
>>> already introduced an unnecessary conflict.
>> Which conflict? If you say, I could try to fix it.
>>
>>> It is not by itself a biggie, but these things tend to add up.
>>
>> How *these things* add a conflict? This is a new thing to me really.
>
> Look at output from "git show 16e1351 sha1_name.c".
>
> The damage (i.e. my time wasted to deal with the conflict resulting f=
rom
> the rename of the function) has already been done. =C2=A0There is not=
hing to
> fix.
>
> One thing you _could_ fix is to keep an eye on what are cooking (e.g.=
 the
> diff between maint and pu), and refrain from throwing "trivial clean-=
up"
That should be the pain of being the maintainer. You have to deal with
this, like I have to deal with all the critics too.

> patches that may overlap with them at the list until the dust settles=
=2E
The dust never settles in this mailing list.

> That would greatly reduce the annoyance factor.
>
> The same comment applies to your patches to reduce use of alloc_nr().=
 =C2=A0If
> absolutely nothing else is going on in the project,
Which is impossible, due to the high traffic that this project attracts=
=2E

> these are genuinely good clean-up patches, but when other patches tha=
t give us real-life benefit are in flight,
Well, I'd say to just ignore it as you have done many times before.

> just having to check if they overlap with whatever
> is cooking now is already annoying.
>
What I can do if you are the ONLY one that has commit access to this pr=
oject.
