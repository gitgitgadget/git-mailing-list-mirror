From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Composing git repositories
Date: Wed, 3 Apr 2013 00:05:54 +0530
Message-ID: <CALkWK0nVax9HtM-M2zo-KH6U2jWznaUH9yBn4y1wqDW8f-mfOg@mail.gmail.com>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org> <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 <7vvc8comj5.fsf@alter.siamese.dyndns.org> <CALkWK0nARWAtC-D3UiNLccuaSwjR6meJb+Cu590N=8Ti8O7OMg@mail.gmail.com>
 <51537A7B.7050206@web.de> <CALkWK0nfNCu775MBB-Y28=V93RkV24kbTLTDKWO2dZ-0yxX=Sw@mail.gmail.com>
 <5154AACC.7050006@web.de> <CALkWK0k=g3iFjmpUQA1VkuH2kZsVX1_Hpo=LZ7CuotwHz_1++g@mail.gmail.com>
 <CABURp0q9mV+-tEtHGpE4mh9cdbhkA8fr4i7XpBtK0fpfSYg-+A@mail.gmail.com> <51597A37.1010301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 20:37:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN64v-0004IZ-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 20:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762158Ab3DBSgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 14:36:35 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:35837 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762152Ab3DBSgf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 14:36:35 -0400
Received: by mail-ia0-f172.google.com with SMTP id l29so583827iag.31
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 11:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XHHF0Gcldw+eY/udh39XH68lRG1lSBhch7E/FbDnQYw=;
        b=wNMielNTHetO7QPWH5L2R4sLk+Jmr4ow3vzd2twO94jYZBM9FsZeGokPvR45EIwt0t
         ite/Gp46Wg4ko7mNUIP8UMOLqbX37rEx8vc7faviVy8No0I58Ssrzz9SnahEdu3oUsMy
         zz33M1hY7wy8UxCTczqBBRsrM9ZcZpi3h5WB2tuDpfJEj4tDfWKz1O9z1gWClRZbeKcC
         MozdUOiAVD9br60JTF62O2trCMm9xa+73p28K6iM34TKdqabQ5I+oV47su/IkyEYUSVm
         RDtjeZxZlb0XLjqE+fE7CIlfq9PopADUKNj5ZPINEFqVTbEyjqgU3ePtKltJpaMGtyFS
         K7HQ==
X-Received: by 10.43.9.68 with SMTP id ov4mr7009163icb.22.1364927794681; Tue,
 02 Apr 2013 11:36:34 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Tue, 2 Apr 2013 11:35:54 -0700 (PDT)
In-Reply-To: <51597A37.1010301@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219826>

Jens Lehmann wrote:
> But I think we recently learned to support that use case with
> submodules. I think there are two floating models:
>
> - Tracked:
> [...]
>
> - Untracked:
>   Some people just want "the newest" tip of a branch checked out in
>   the submodule and update that from time to time (I suspect this
>   is because they are used to SVN externals, which I believe work
>   that way). You throw away reproducibility, which I think is not
>   good and not the way I expect Git to work.
> [...]

Nope, it has nothing to do with SVN externals; I've never used them.
And no, all repositories aren't created equal.  I should be able to
add in magit.git into my dotfiles repository without worrying about
which commits the other repositories were at a particular commit.  If
my project depends on the bleeding edge of poppler and girarra, I
should always be able to tell what commits in each subproject the
build was passing in.  In other words, I should be able to freely
mixed floating and fixed submodules.  There's no reason for one to be
Right, and the other to be a shunned second-class citizen.
