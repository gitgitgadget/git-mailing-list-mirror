From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] warn use of "git diff A..B"
Date: Sun, 27 Mar 2011 22:03:11 +0200
Message-ID: <AANLkTikQB_2bapZXOyANrO1fsKGs4r6HP1TOuisZXfnr@mail.gmail.com>
References: <7voc51cydw.fsf@alter.siamese.dyndns.org> <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 22:03:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3wBh-00041z-Kz
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 22:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab1C0UDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2011 16:03:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56452 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab1C0UDc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2011 16:03:32 -0400
Received: by bwz15 with SMTP id 15so1989148bwz.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=n5KG+l1omgbFSNKcBECgobbzLNVEJT7J9fF6G/yrg64=;
        b=sAzA98XxLe5gb1GKM6M7VJGxN7Id3QwuX8rdkglMUTRqbHziSjcV4hNFKvVI9blU8d
         k1urUS+gqq/w3p4dnhEbQFMRb6+DfRMkd7O5570xkG+wqk6UoVYHwcYb7vy5U5ANpQDw
         5JFTIiSa0DuATv0PWtnpgsmUnRlSZAKYzAwk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qV6g4P2sUqpj4XkYs3g8d34wx0USnOUICX+SYrNO7dl8Ihcr+N0XghrE009FFQ2ITk
         qBSVvx/Mun2JdRsj5+6b3qRDyd4Q7CzHuU3Je4uiskR0mB3UaPMcXfP3UWzrmBmE2Hx3
         5t+mygRR/TIIAMquAfg2qIXQSiZEQbLwN0RRM=
Received: by 10.204.84.166 with SMTP id j38mr2896597bkl.84.1301256211127; Sun,
 27 Mar 2011 13:03:31 -0700 (PDT)
Received: by 10.204.29.2 with HTTP; Sun, 27 Mar 2011 13:03:11 -0700 (PDT)
In-Reply-To: <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170087>

On Wed, Mar 23, 2011 at 22:45, Junio C Hamano <gitster@pobox.com> wrote=
:
> "git diff" (and "diff-tree") accepts a range notation "A..B" from the
> command line to specify the two endpoints to be compared; the right w=
ay to
> spell this would be "git diff A B". =C2=A0This is merely a historical=
 accident
> that comes from the fact that "git log" family of commands and "git d=
iff"
> happens to share some code in their command line parsers.
>
> It was fine for people who are used to seeing "git diff A..B" and sil=
ently
> translating it to "git diff A B" in their head, but it made things ha=
rd
> for new people. =C2=A0It is easy to mistakenly think that "git diff A=
=2E.B" has
> some similarity with "git log A..B" (there isn't).

I like the dot-dot notation a lot.
