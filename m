From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] commit: turn commit.ignoreIntentToAdd to true by default
Date: Tue, 7 Feb 2012 08:03:13 +0700
Message-ID: <CACsJy8BrieY3btxbQLiRtm2bxtN3ECaFEs5QVEi=bBOFofbkgA@mail.gmail.com>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-4-git-send-email-pclouds@gmail.com> <7v8vkf7mrn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 02:03:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuZTJ-0001Vu-AG
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 02:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518Ab2BGBDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 20:03:45 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59475 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab2BGBDo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 20:03:44 -0500
Received: by wics10 with SMTP id s10so4574941wic.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 17:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=YCRdReHg2ow6RwO9mdD8wgWBH6sJmEN555axurJN3EE=;
        b=F8OI3c7+188rCIC8wZrYho/nfxOq2L7ieR5U34Tgt+pHG7SuKv9AS6LLhT4kt7QIDf
         tf+x6MAFWlIXt5GK6L9Jg9Fk38QV5qhDnjiV7EhtBUynl7fHyeBpmtHHvrWmCDHehyfS
         dZJVBPTSdxthosqRrG5YNnD9s+f87ZLxrcAP4=
Received: by 10.180.19.97 with SMTP id d1mr30882587wie.12.1328576623368; Mon,
 06 Feb 2012 17:03:43 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Mon, 6 Feb 2012 17:03:13 -0800 (PST)
In-Reply-To: <7v8vkf7mrn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190128>

2012/2/7 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!set_commit_ignorein=
tenttoadd) {
>
> Now no warning() is associated with testing of this flag, which means=
 that
> people who didn't get around to read the doc and react to the warning=
s in
> the earlier releases will get _nothing_ when the real change hits the=
m?
>
> That sounds strangely bad. =C2=A0What am I missing?

Well if they stumble upon this case during the previous deprecation
phase, they ought to set commit.ignoreIntentToAdd. If it's not set,
they probably do not have prior experience with this feature. With
their fresh mind, they hopefully learn the new default behavior via
to-be-updated git-add.txt so no warnings for them.
--=20
Duy
