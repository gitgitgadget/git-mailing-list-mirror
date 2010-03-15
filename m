From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: FEATURE REQUEST: Cherry pick in not checked out branch
Date: Mon, 15 Mar 2010 10:43:14 +0100
Message-ID: <fabb9a1e1003150243o21bab937y122ac61d65777d5f@mail.gmail.com>
References: <be8f531d1003150139p7cc99700m807ab21bddf8fbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Maxim Treskin <zerthurd@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 10:43:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr6pn-0006xh-UH
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 10:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936023Ab0COJnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 05:43:35 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:33883 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934484Ab0COJne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 05:43:34 -0400
Received: by pxi36 with SMTP id 36so1750375pxi.21
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=buDH5ea29B0aeUEKeV81TjgPJqxC7uT7hyC3Grn2H7g=;
        b=uZvVSOWReMh0eXIFFp+4Sy0CiZKt/kbQqD1kl6vVW/OMhI6YUjaOn0+XXh/jw0PV2w
         QvBLeERCou+85lhss05fBH/xNm0MFUQxlBnoZJUNJaZN4e9hV7k2EPJaHpRCZqPM+ihX
         i5bWOPWT/ioYPVltwMot2bYGgtsII39K0S26Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=JBA+ndHcr8JbSU4BdHXZ09s5x/YuEiccxpT9q6KWX7MnL2QM3VyUOW0XMndVijr6IZ
         FywTNK6LT/Ahl9GmoJIo9av1Q16jmoVbjuUpLD7TEYlYWmyof98ZNWbYYVZLBeTa3B3K
         PCNAZTsWdFlCI8C12g00siPmTnQI8UMDbWjn0=
Received: by 10.143.129.2 with SMTP id g2mr1319087wfn.273.1268646214127; Mon, 
	15 Mar 2010 02:43:34 -0700 (PDT)
In-Reply-To: <be8f531d1003150139p7cc99700m807ab21bddf8fbb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142199>

Heya,

On Mon, Mar 15, 2010 at 09:39, Maxim Treskin <zerthurd@gmail.com> wrote:
> git cherry-pick applies the change introduced by specified commit only
> to currently checked out branch. Why this requirement exists? Is it
> possible to apply changes to not checked out branch, like:

Because you need a working directory to resolve conflicts.

-- 
Cheers,

Sverre Rabbelier
