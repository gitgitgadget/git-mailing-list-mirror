From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Subject: Re: Support of '^' as alias for 'HEAD^'
Date: Sat, 14 Jul 2012 23:49:11 +0300
Message-ID: <CAAa3hFOv39DhuEDTyJUm1pzB-X1gBiV8FXuqW6TidOtQw9CUng@mail.gmail.com>
References: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com>
	<loom.20120714T114718-783@post.gmane.org>
	<7vzk725c86.fsf@alter.siamese.dyndns.org>
	<7vr4se5bg4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 22:49:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq9HC-0007KB-4v
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 22:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab2GNUtO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jul 2012 16:49:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35627 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159Ab2GNUtM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jul 2012 16:49:12 -0400
Received: by pbbrp8 with SMTP id rp8so7615209pbb.19
        for <git@vger.kernel.org>; Sat, 14 Jul 2012 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SYItHuajD9SzKIC/YzPA92yux7zLtAWei8Go8mRkqAM=;
        b=WXncUd94gABRNaIZsnAGlO3Ot+i5liwJJBZE/xjZtlSZR8HzsCQSGL/s4tPXA8C9+R
         Oog+1TBKIg3/d+8CZgc98dPauBEnoqNFmx3QUfDOVNWj05VFHbQq4UTYjjS7uR93fgLi
         8AtV+t2XYmnPnBCUt87geY+GIrvqNGpkpkxpSj6u6Lf4/vzy7t6zRIDyeE7yaaBXZIm9
         6CVPTsOQUIr6q64DlZTvcy2Ys+T+VI+taQTZAecMJfP4JZcwI1SHfSPA/zv3HrTjmvu1
         /N3P05R8iTy0KZpKxnHwFSWft4+eGwKYg0SBc2kMD3x5xfivL8MRvfrq48TTISGzbnK5
         FJoA==
Received: by 10.68.239.103 with SMTP id vr7mr13699503pbc.0.1342298951485; Sat,
 14 Jul 2012 13:49:11 -0700 (PDT)
Received: by 10.68.231.33 with HTTP; Sat, 14 Jul 2012 13:49:11 -0700 (PDT)
In-Reply-To: <7vr4se5bg4.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: jlvg4ALtbBBcUqBiq6DVPglf_iw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201455>

On Sat, Jul 14, 2012 at 11:34 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan N=C3=A4we <stefan.naewe@gmail.com> writes:
>>
>>> Zeeshan Ali (Khattak <zeeshanak <at> gnome.org> writes:
>>>>
>>>> Many times I want to refer to 'HEAD^', 'HEAD^^' and sometimes even
>>>> further up the tree. It would be really nice if I didn't have to t=
ype
>>>> 'HEAD^' but could only type '^'. Bash completion make things easie=
r
>>>> but it automatically inserts a space immediately after HEAD so you
>>>> have to hit backspace. I think this change would be good in genera=
l
>>>> anyway.
>>>
>>> Or even '~1', '~3'.
>>
>> "^" has a problem when used with other things (does "log ^^2
>> origin" mean "log HEAD^2..origin"?  Or "log HEAD^^2 origin"), so I
>> do not think it would never fly as an abbreviated syntax.

What about '^' and '^^' that I suggested?

>> While I see your "~<N>" much distasteful compared to "^", you still
>
> s/dist/less dist/; sorry ;-)

Why?

>> need to be a bit more careful when analysing the benefit of such an
>> abbreviation.  To shells used by many people, these mean tilde
>> expansion ~<N> to refer to elements on the dirstack and you need to
>> quote, perhaps like \~3.

That would kinda beat the purpose I think, would be nice to just type
1 key rather than 3 to refer to HEAD (2 keys would still be good
enough IMHO).

--=20
Regards,

Zeeshan Ali (Khattak)
=46SF member#5124
