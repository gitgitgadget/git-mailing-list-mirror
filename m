From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] MSVC: fix build warnings
Date: Mon, 5 Oct 2009 16:38:03 +1100
Message-ID: <d2e97e800910042238t3ba02d59ud4e7f5b3b2b11183@mail.gmail.com>
References: <d2e97e800910021440q46bd46c4y8a5af987620ffc5c@mail.gmail.com> 
	<7v7hvd4flb.fsf@alter.siamese.dyndns.org> <d2e97e800910021628t13bba313he119ba59babdecee@mail.gmail.com> 
	<7v7hvak1ec.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 07:41:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MugKN-0007KA-TU
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 07:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbZJEFjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Oct 2009 01:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbZJEFjA
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 01:39:00 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:51065 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZJEFi7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2009 01:38:59 -0400
Received: by yxe37 with SMTP id 37so2735608yxe.33
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Mp55IK9dYYo9GeLNRBra7XhC7IK0i5P8wwrZximbfoA=;
        b=Y45Mjzzf+hzy2hn55R4RJ/Z9pmHLyIY2mNfbMtAQ3dlGDnLLYqVAlhD+K3pG2AKZzO
         HF59wqbgevUeh7MLP0Z7Azz6Ubk9kJNmOzMl7roHB20EiJNRopPiv5eXdWSZCtn8zyaL
         6UR06Xt1wmEdH999Go2UQtBo2c9zits/YUiDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=B/BKjTFqeUjZuBTMNBixepfUPlO4Ol0UVfOnHb/G9nMutMjUgGRNL+ZO8qeYIFctUd
         Hkc3GFQ61gL5MWEv0J++Rw8EXU5jDD33MtlBFyIb089DX7ixHnIb7b+B/tkfHm5lsJXc
         sjuAYFvBgydPOj2QnmVpZzPkh+kRAap39mIQA=
Received: by 10.100.78.16 with SMTP id a16mr4615763anb.180.1254721103064; Sun, 
	04 Oct 2009 22:38:23 -0700 (PDT)
In-Reply-To: <7v7hvak1ec.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129529>

2009/10/5 Junio C Hamano <gitster@pobox.com>:
> Michael Wookey <michaelwookey@gmail.com> writes:
>
>> I can't build with -Werror on Ubuntu 9.04 (gcc 4.3.3) because of the=
 following:
>>
>> =C2=A0 http://article.gmane.org/gmane.comp.version-control.git/12747=
7
>
> I think that has been fixed already while I was away ;-)

I still get the warning with the current git.git:master (dbc1b1f7) and
git.git:next (8ea19b84). Would you consider taking the original patch
to fix the build warning? Perhaps I should resend the patch as a
"partial revert" of eb3a9dd which introduced this warning as described
here:

  http://article.gmane.org/gmane.comp.version-control.git/127519

What do you think?
