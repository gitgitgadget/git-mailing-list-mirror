From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 04/19] teach remote-testgit to import non-HEAD refs
Date: Thu, 9 Jun 2011 08:23:23 +0200
Message-ID: <BANLkTi=puAfoPhuKxsHd9ayu0DHA6d1peA@mail.gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-5-git-send-email-srabbelier@gmail.com> <7vei3328c8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 08:24:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUYf3-0006zW-T6
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 08:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665Ab1FIGYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jun 2011 02:24:04 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42897 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341Ab1FIGYD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2011 02:24:03 -0400
Received: by qwk3 with SMTP id 3so563285qwk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=VvRWufbyFBTdsKe2dKTuDtVa9/LoSriu9GJpc3jQMgE=;
        b=MSmX6AZIYChOev8OQ3vFLEqY+DU1+7IiWdafhgWdcnBFtzk3ApJFs1YffXqXE7BE56
         IWiiuGGULdLxZAQdulzK0NNI+37vW7JTt6LnjT6yv6PxbcuWZMe3+f2JvmjvvKn9UnGf
         wTLcYjfFaSu/MPWf2KVQ9DeZlVqCV7RnW7ULk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BLPYaVe3RqLyzxZJCbgaX3ucBJIMxy42o1KOJzUNFb3LtUQJ8l4QykujL4PwGc20we
         FAVD9zv5y86rxNIffKyjDcNZKtE/obofTbmnQRn/EUeScC2ZTHFfWKUPUmYcd57SMv6u
         CzB6Hl4zHj5fm+WTFQB/2woiKwlAsVdl7ft1s=
Received: by 10.229.127.99 with SMTP id f35mr245141qcs.91.1307600643181; Wed,
 08 Jun 2011 23:24:03 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Wed, 8 Jun 2011 23:23:23 -0700 (PDT)
In-Reply-To: <7vei3328c8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175492>

Heya,

On Thu, Jun 9, 2011 at 01:48, Junio C Hamano <gitster@pobox.com> wrote:
> This seems to be slightly different from what was sent to the list,
> though. =C2=A0Using refs=3DNone as default and assigning ["HEAD"] is =
more in line
> with the standard Python practice, so the implementation is better.

Ah, yes, I fixed the style nits suggested in my own review.

> But "do we still append HEAD after --import-marks?" still stands.

=46ixed locally. Sharp eyes :)

--=20
Cheers,

Sverre Rabbelier
