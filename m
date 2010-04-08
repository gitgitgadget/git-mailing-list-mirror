From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: (resend v2) Re: [RFC PATCH 1/4] Document the HTTP transport 
	protocol
Date: Thu, 8 Apr 2010 09:47:28 +0800
Message-ID: <r2ibe6fef0d1004071847mc1b25e35q6e2db59f89ec15ee@mail.gmail.com>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
	 <1255065768-10428-2-git-send-email-spearce@spearce.org>
	 <7vskdss3ei.fsf@alter.siamese.dyndns.org>
	 <20100408031159.00006ec7@unknown>
	 <7v1verca7d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 03:47:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzgqF-0004PL-Un
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 03:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758279Ab0DHBrb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 21:47:31 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:58570 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab0DHBra convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 21:47:30 -0400
Received: by gxk9 with SMTP id 9so1033920gxk.8
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 18:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FHAtO9m/WHkE3QHbv6VFNBviwY141/I1D6Xxk61R0LU=;
        b=Jk97bt4iDoj1TTR334tfd5lbhA0Zqbb3ILoevUlrwctyORWFC0kYEgn0ickITPZ3c3
         guBGx19VfXsGOslmH+3WAf75xXwWIY+eQs7majCVfx01XtDS6XTmbzhfqleIYxsbm3XD
         1T61ANMDBQ5qDhQLLEwKnFLGHg7nyLrgmf5VA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SIfzII20dwKTYes/P1f1EIcZxCbqAiZb0nMiWAG4A5b27yGsLTjaoIJQ0UwuJa4jSG
         bB+cjfypPeHy8C7mWc2CzQ+7XPb4QO8WQzVKUd8lb2hCGrukCdaxqwFwbLg3H9J426O4
         TsQiebDijd+NGSfrRKV/hZ1OzPVeo6pPTsaps=
Received: by 10.231.10.65 with HTTP; Wed, 7 Apr 2010 18:47:28 -0700 (PDT)
In-Reply-To: <7v1verca7d.fsf@alter.siamese.dyndns.org>
Received: by 10.100.50.7 with SMTP id x7mr19260830anx.191.1270691248237; Wed, 
	07 Apr 2010 18:47:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144301>

Hi,

On Thu, Apr 8, 2010 at 3:51 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> (I'm reviving this thread to complete the document. What I have righ=
t
>> now is available at my github repo; you can see it at
>>
>> =A0 http://github.com/rctay/git/compare/git/next...feature/http-doc#=
files_bucket
>
> I looked at the above page; it was quite readable. =A0You seem to hav=
e
> picked up Shawn's non-patch responses to reviews quite well.

Thanks.

> By the way, aren't there a better way than visiting:
>
> =A0 =A0http://github.com/rctay/git/commits/feature/http-doc/Documenta=
tion/technical/http-protocol.txt

to view just the blob - yeah, but I'm so used to using github's
"Compare view", it's the first thing I do.

> and then repeat (click each commit, go back)
>
> to get a moral equivalent of "git log -p feature/http-doc -- $that_pa=
th"?

The Compare view let's you select a range of revisions, so it's not equ=
ivalent.

--=20
Cheers,
Ray Chuan
