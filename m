From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker 
	when options are patch and a stat
Date: Wed, 4 Nov 2009 08:00:58 +0100
Message-ID: <6672d0160911032300w1a2dfdbck5b1db98f2059639b@mail.gmail.com>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com>
	 <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:01:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Zs8-0007d5-CO
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbZKDHAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 02:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbZKDHAz
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:00:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:23306 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZKDHAy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 02:00:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so116571fgg.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 23:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ngqCVQKartNJb7bcTqKAeDHWIxaleRBYnxNC+/26skw=;
        b=ovwYgjwmT+NC3ylwfUn/sIHL//vZ/34WL8HTR1a1j7z88DdFU/Y09OxmWAGhc8O2GF
         Zj4ceekTiQi9iaA5K6EmzRxRag4NUbW/FtL446sg7WRrnyG9+5PCeqDtCrRyScM9TI//
         AdaWs3JPBU7x2Coe7Xh4hGCWsoFJJUpmtIq5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Lr4B1SKkxC4FG1cap/nB8H5Tgm0lzETtnsdQs5p6QSeXOb4ez//AI3oddWiXomvu3o
         ST5qg7Wo7K6SNIPS+PSz5bp3yEMTzw7T6LnMK7wPS5usU8JTKncp1cvzKo0nabvBLJ9f
         3TE415ki6SCDVPzy6plzHBSYavhBJVkb1jPTE=
Received: by 10.204.156.201 with SMTP id y9mr955571bkw.204.1257318058633; Tue, 
	03 Nov 2009 23:00:58 -0800 (PST)
In-Reply-To: <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132047>

2009/11/4 Junio C Hamano <gitster@pobox.com>:

> In an ideal world, I would probably say:
>
> =C2=A0* format-patch should have three-dash after the commit message,=
 no matter
> =C2=A0 what format the patch is asked for, and it always will give pa=
tch text.

I agree.

> =C2=A0* format-patch -p should be reinstated as a way to ask for "jus=
t patch
> =C2=A0 text, no diffstat". =C2=A0Introducing a new option --no-stat _=
in addition_
> =C2=A0 to improve the UI is Ok.

Since -p has been broken for 14 months, is really necessary to reinstat=
e
it? (Or has the breakage not been reported because the people who care
still use a git version older than 14 months?)

Why not just add a new --no-stat option?

> =C2=A0* format-patch -U<n> should not be mistaken as a request to sup=
press
> =C2=A0 diffstat; what 68daa64 _tried_ to do was worthy.

I agree.

/Bj=C3=B6rn

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
