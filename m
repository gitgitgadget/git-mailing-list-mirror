From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 09/48] t6036: criss-cross with weird content can fool git
 into clean merge
Date: Mon, 8 Aug 2011 12:02:05 -0600
Message-ID: <CABPp-BHbXt=FJ4-wx6ci+xOAo0Ud_dwBpSkoaKvUVuSxhkjotg@mail.gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
	<1307518278-23814-10-git-send-email-newren@gmail.com>
	<7vaacbdus4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 20:02:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqU9V-0003fM-QA
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 20:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab1HHSCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 14:02:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58837 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab1HHSCG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 14:02:06 -0400
Received: by fxh19 with SMTP id 19so5607449fxh.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jJ+b4fgy7odTfevhCz4Wn4csOzEBQzd8tgIxLAiNVHM=;
        b=hgzhcKIbrgQ600VJfWB2wabb7PkGGCJzmYKzoOjlXYo+8VQGTZjH8lCQ4oaQrZ5k5O
         T3sK5KcDZTZCg8//ZajZMuIkuVZiARp2QqyFh7uzhI6u4wEXMazR+XvEusQZeXFqYL30
         +tG1SUgzQqCnrnUUKFzpMKXehlXFEeUkqs5DU=
Received: by 10.204.156.91 with SMTP id v27mr600604bkw.293.1312826525376; Mon,
 08 Aug 2011 11:02:05 -0700 (PDT)
Received: by 10.204.50.143 with HTTP; Mon, 8 Aug 2011 11:02:05 -0700 (PDT)
In-Reply-To: <7vaacbdus4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178967>

On Mon, Jul 18, 2011 at 5:38 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Elijah Newren <newren@gmail.com> writes:
>
>> +# =C2=A0 Commit E: file with contents:
>> +# =C2=A0 =C2=A0 =C2=A0<<<<<<< Temporary merge branch 1
>> +# =C2=A0 =C2=A0 =C2=A0C
>> +# =C2=A0 =C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D
>> +# =C2=A0 =C2=A0 =C2=A0B
>> +# =C2=A0 =C2=A0 =C2=A0>>>>>>> Temporary merge branch 2
>> +#
>> +# Now, when we merge commits D & E, does git detect the conflict?
>
> This is way too artificial that I personally feel not worth worrying
> about.

I wasn't going to try to do anything to fix it.  Should I drop this
patch from the series or is it worth keeping around for completeness?
