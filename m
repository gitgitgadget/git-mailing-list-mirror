From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v2] git-merge: ignore space support
Date: Tue, 24 Aug 2010 22:01:26 +0200
Message-ID: <AANLkTint_aF2ZZue5PeSnaAVFa7v+b1diqm3xyvCQsVJ@mail.gmail.com>
References: <20100823205915.GA4484@ns1.cockos.com>
	<20100824022820.GE17406@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Justin Frankel <justin@cockos.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 22:01:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onzgb-00020I-M0
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 22:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094Ab0HXUB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 16:01:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50015 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab0HXUB1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 16:01:27 -0400
Received: by yxg6 with SMTP id 6so2672794yxg.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U2fDudWfynYsUdcYbOirAoYONQ2x3ErESmFhJNNg5bg=;
        b=fCodlWXBKHBYrfVW9mQjDwOQybV66hJg6njRKlUR7JWFi92sLTfYirr5pZGmgUW1am
         ieKiGCpSnWYSuVwIlXd3wiiWUjKwOAYLU6iRrffyzyBhSFauIZMN3TIiJzeMHsafgQpM
         3wlCiejA23AhMSS9F3qLs5HosdpXsk2Pu2wVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QxXIJJtzLzutrrjsQbTbhW+AgKz8ThBbGN9GvHzZTaL9n+Xc9cFiMKjFl8lpn5UPyl
         Ft2lP9rkKzsXdVIa3PHlHaOYlUD/vasGQKAH7SeB/b+53kpC6yH/446N24gXVVGJdvvZ
         kTwNl5qroxxLF3YEUg0eQj/rcK2Ss9hx8Iw3w=
Received: by 10.101.153.33 with SMTP id f33mr7877935ano.92.1282680086443; Tue,
 24 Aug 2010 13:01:26 -0700 (PDT)
Received: by 10.231.161.67 with HTTP; Tue, 24 Aug 2010 13:01:26 -0700 (PDT)
In-Reply-To: <20100824022820.GE17406@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154341>

Hi,

On Tue, Aug 24, 2010 at 04:28, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Subject: ll-merge: replace flag argument with options struct
>
> Keeping track of the flag bits is proving more trouble than it's
> worth. =C2=A0Instead, use a pointer to an options struct like most si=
milar
> APIs do.
>
> Callers with no special requests can pass NULL to request the default
> options.

thanks for doing this. But is there any prior art for using NULL as
'use the default flags' in the project? For what I know, I can't think
of an example. But my inside knowledge into git drifts slowly away.

Regards,
Bert

>
> Cc: Bert Wesarg <bert.wesarg@googlemail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
