From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 14:10:22 +0600
Message-ID: <7bfdc29a0808190110nddaf57fw5bf40903f3072bff@mail.gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
	 <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
	 <48AA7BE9.4040108@sneakemail.com>
	 <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Peter_Valdemar_M=F8rch_(Lists)?=" 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:11:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVMJh-0004XH-6U
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 10:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbYHSIKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Aug 2008 04:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbYHSIKm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 04:10:42 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:57442 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbYHSIKi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Aug 2008 04:10:38 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1408969yxm.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 01:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YJEDtEu5qunDpxagdrNeJeyaqdjJV1xzYzrG/mRp8V8=;
        b=eWQxXaAz5so0ldqVPYSvGx+A0KHeIdRYis9TXXGZfTRbUmnig0Bm2pZSoSxz4/9pCy
         yvabUy4xK9gpRITc6ujEp05+V2IM2uBhCEKRk1AJE7dSwQ+5AsdBc2cwuJlf+8diMtuP
         bhxsRzgseCWKwVaw7OyGD8nEKhGQzzP8XXj3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tOTa4KXwog5gVhVcNv/DjJfIDtJHhLMFsNBOMLJgO66uRL1KqDdPoGXvMnvqok1to9
         vuj66vVEF25Qw6ZPXDaNiKpkjz07Ef9c62AcSy6XFaYnvF2AVBTpyYquYnnznWMKzn0D
         HWUi2dYwLqKePOvkQHhSqxiOU2YYJDQxQ1vvg=
Received: by 10.151.42.10 with SMTP id u10mr11370388ybj.49.1219133437667;
        Tue, 19 Aug 2008 01:10:37 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Tue, 19 Aug 2008 01:10:22 -0700 (PDT)
In-Reply-To: <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92829>

On Tue, Aug 19, 2008 at 2:01 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> "Peter Valdemar M=F8rch (Lists)"  <4ux6as402@sneakemail.com> writes:
>
>> Here, here! That is *exactly* what I was thinking when I started
>> reading this thread: "Hey, the "git diff" stuff was easy enough, it
>> was the reverting (and friends) that caused me trouble!"
>>
>> Also, in the same area, I've now understood that to undo a "git add"=
 -
>> to remove a change from the index and making it show up as a
>> difference between the working tree and the index - one can use "git
>> ... Would've been helpful to me to have a
>> sentense or paragraph about that in git-add.txt,...
>
> Wonderful.
>
> Can somebody who is relatively (but not extremely) new to git can
> volunteer to be a documentation secretary to collect these "Hear, hea=
r, it
> would have been very helpful if X were documented next to Y" stories,=
 and
> coordinate documentation updates after enough such improvement sugges=
tions
> are collected?
>
> People who lost git virginity like myself cannot do this sensibly and
> fairly.  For example, as my mind is already contaminated enough that =
I
> discarded the original "add this as Discussion item to revert" messag=
e
> after reading it once, judging it to add extra noise without much mer=
it.

I would not agree it to be a part of git-add man page, but rather it
should be a part of doc that explains basic git commands and their
flows. I feel that we need a place where git flows are explained. IMO,
gitwiki is a great place for it. I would like to volunteer to add
these pages to Wiki.

Best regards,

Imran

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
