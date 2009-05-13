From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: rebase edit handling
Date: Wed, 13 May 2009 19:52:07 +1000
Message-ID: <fcaeb9bf0905130252t2a55b742j425d121eb06b9193@mail.gmail.com>
References: <fcaeb9bf0905122351y3a1235e8s5cc9b83c225ca9c6@mail.gmail.com> 
	<589ffd8942fd21b6f727163f78592381@mail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Wed May 13 11:52:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4B8h-0001OW-Sp
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 11:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757877AbZEMJw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 05:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757541AbZEMJw1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 05:52:27 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:8834 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807AbZEMJw0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 05:52:26 -0400
Received: by an-out-0708.google.com with SMTP id d40so742521and.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WU15Mfq0S31ED1HHfml9gq11BLeFVCbvFVYPwRUW51I=;
        b=RX6kOq01Uk3RUb4iu0LjvvhWg6T6JmAkNnxfHhDstxyiT8cbNUc8IxVS8fyYUN3Q2D
         5DJidOC9wxaBuZFQANzm8ZAzSZKKhUhYoHBn0dqMnl0drpjM58wkjmuAU9VJnGCuizAU
         +oi0Q+ixh5LVK2H2VqX4e+8D/yHh9svzPivTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qKtG61F5XAAkMnJwlWlfvMuFCqFqizXJLBXoqlN3SdFnD2Cr2uI6QD2nH2mTGR81YE
         /C/j8HH4rE37zj6dLDN7eAyZuh70BB8cQvOLVrkcpB7wXQyv9fyJvRa+RcvLS2FcM3su
         kd6LpjBy6W1EsTgB3mhRwFprrL5dVEXlZnVaU=
Received: by 10.100.248.13 with SMTP id v13mr243730anh.123.1242208347127; Wed, 
	13 May 2009 02:52:27 -0700 (PDT)
In-Reply-To: <589ffd8942fd21b6f727163f78592381@mail.hotelhot.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119017>

On Wed, May 13, 2009 at 6:18 PM, Anders Melchiorsen
<mail@cup.kalibalik.dk> wrote:
> On Wed, 13 May 2009 16:51:33 +1000, Nguyen Thai Ngoc Duy
> <pclouds@gmail.com>
> wrote:
>
>> Could we unit the way to squash/edit commits in rebase? If I squash =
a
>> commit it, I need to to update the index and continue rebase. If I
>> edit a commit, I need to amend that commit. The problem is when I ha=
ve
>> a few edits/squashes in the same rebase, I easily get confused and d=
o
>> "commit --amend" on squash too.
>
> A squash does not leave you at the prompt, unless you abort the edito=
r
> with the concatenated commit messages. So where does your confusion
> come from?

Hmm.. I was confused even when writing mail :P No not squash, actually
conflicts.

> Anyway, here is a (fruitless) thread on the confusing UI of interacti=
ve
> rebase:
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/105738
>
> Maybe it answers your question in some way.

Yes, looks interesting.

--=20
Duy
