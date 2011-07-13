From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC] control, what refs are honored by core.logAllRefUpdates
Date: Wed, 13 Jul 2011 10:52:58 +0200
Message-ID: <CAKPyHN1GEkcyacQ_f4hhjaaZx4Fx4tmfz0qRSfTPXJDgUm8mow@mail.gmail.com>
References: <CAKPyHN3_br-ndQo9oMzCcU1yOVEbAxmzvHQkwF15LgwQx12KZA@mail.gmail.com>
	<7vaacj8jq7.fsf@alter.siamese.dyndns.org>
	<CAKPyHN0+BaPtrRMVrWCZQ2mbJQz_vxsOOsG4Z=Ksqc1RJvF1Ew@mail.gmail.com>
	<20110712182517.GA17787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 13 10:53:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgvBo-0002Hl-VX
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 10:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129Ab1GMIw7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 04:52:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44901 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965064Ab1GMIw6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 04:52:58 -0400
Received: by vws1 with SMTP id 1so4048679vws.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 01:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mZEeD+y7Cx54sbeTtA4g4dZfv0CUrA5597sNaBkxXPg=;
        b=In+4bKUh/f/hY7XCios9TZUQdA9w+qNNrFYGKIwfeO2iIFJmEgA6FSN/JoSBTG7KR3
         gEd3Oz8ars6IswChk+mc206iAfoeDb4HF1U2SvW70fKJ0ibHtXWynw+/RO77bFFLQkaz
         JZ111IkvoQfjCY4flgVzMVNWc6cLNjhQoJhyM=
Received: by 10.52.89.101 with SMTP id bn5mr909396vdb.329.1310547178269; Wed,
 13 Jul 2011 01:52:58 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Wed, 13 Jul 2011 01:52:58 -0700 (PDT)
In-Reply-To: <20110712182517.GA17787@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177017>

On Tue, Jul 12, 2011 at 20:25, Jeff King <peff@peff.net> wrote:
 [1] If we were starting from scratch, you could make that distinction
> with a new operator, like:
>
> =C2=A0[core]
> =C2=A0 =C2=A0autoLogRef =3D heads
> =C2=A0 =C2=A0autoLogRef +=3D remotes
> =C2=A0 =C2=A0autoLogRef +=3D notes
> =C2=A0 =C2=A0autoLogRef =3D heads
>
> which would be equivalent to what you wrote above. But because it
> switches the semantics of "=3D" to "replace" instead of "append" for
> multi-value keys, it would break all current config that uses multipl=
e
> "fetch" lines (for example).

Adding ! as a negator would also break config files read by old git ver=
sions.

Bert

>
