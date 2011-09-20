From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH] git-mergetool: check return value from read
Date: Tue, 20 Sep 2011 11:20:22 +1000
Message-ID: <CAH5451mt9mhRDQBYhUn=dO-SMyyhDNcv7nXfdsk-HKY3pMj77Q@mail.gmail.com>
References: <7vaaa09skn.fsf@alter.siamese.dyndns.org> <1316475652-35188-1-git-send-email-jaysoffian@gmail.com>
 <7vboug82qk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 03:20:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5p14-00045D-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 03:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403Ab1ITBUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Sep 2011 21:20:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48908 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab1ITBUo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2011 21:20:44 -0400
Received: by fxe4 with SMTP id 4so48159fxe.19
        for <git@vger.kernel.org>; Mon, 19 Sep 2011 18:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RYw8S9EKMQ8bYNZBuGHacxjH59xz7hG0hzI5GFlZkT0=;
        b=xIGECu2mvQYwZsbZ3riAI67ka9PsThBbtz7JJ6RgpeUdcvSW8aUEHMoxwMQQI79LBH
         kMzicDycLKrW5bjVEUyW89kAkhxGh8l0/KqSoKOSYCM5cWzFXkmn8iSlRbGoyd39NpPt
         El1XcS1y+F1SG39OcF50S28s7p4At30pBJa9Q=
Received: by 10.223.49.139 with SMTP id v11mr350367faf.21.1316481642270; Mon,
 19 Sep 2011 18:20:42 -0700 (PDT)
Received: by 10.152.37.66 with HTTP; Mon, 19 Sep 2011 18:20:22 -0700 (PDT)
In-Reply-To: <7vboug82qk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181728>

On 20 September 2011 10:41, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>>> I suspect that it would be more consistent with 6b44577 (mergetool:=
 check
>>> return value from read, 2011-07-01), which this patch is a follow-u=
p to,
>>> to do:
>>>
>>> =C2=A0 =C2=A0 =C2=A0read answer || return 1
>>>
>>> here.
>>
>> Thanks, sorry I missed that.
>
> Thank _you_ for spotting these unchecked "read"s. =C2=A0Will queue.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

I got hit by the ctrl+c bug while using mergetool just the other day.
Thanks for the fix :)
