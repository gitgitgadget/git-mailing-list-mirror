From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: new 'add-envelope' option
Date: Sun, 22 Nov 2009 14:03:01 +0200
Message-ID: <94a0d4530911220403w7238dab7saf18830a89f2add5@mail.gmail.com>
References: <1258825410-28592-1-git-send-email-felipe.contreras@gmail.com>
	 <20091121193600.GA3296@coredump.intra.peff.net>
	 <94a0d4530911211159l1fadad0ldb0d760439ceb57@mail.gmail.com>
	 <7v1vjrmfjw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 13:03:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCBA7-0000p8-LF
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 13:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbZKVMDL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Nov 2009 07:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbZKVMDC
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 07:03:02 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:40620 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbZKVMC4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Nov 2009 07:02:56 -0500
Received: by yxe17 with SMTP id 17so4050735yxe.33
        for <git@vger.kernel.org>; Sun, 22 Nov 2009 04:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/5Wk9ZT6jD3jj5O4eFOidRDYDMOyW6/d7zQzOvMLCy4=;
        b=lG9xbnt9tcH+Xz/et8j+35DF9FjZbuTKNrO1LhmbWqD5Pu647pPvhqy/+B9oKxVo44
         mMFdtWshKdAx/ia813kfr5DWGyjtuBiUDT6bIexcpA+fAHX6r1iZ5Mp0wPL3TSqeqnsP
         fM3RESOG29kOsgkO52TCyRzyxLv93EYrqZOBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CNdJ3ioxIu81E2/OEbgc271PUqFSJDK8nR5MWWEWGeWjblnv0vp6GQb/rOKFrhKXKy
         K69cNiy52jO+HSyDL76Ve9Yuf/t+4rR1pqUdm5b69C/QTGGc7RTG0T31ckSVZPhC43pJ
         SP6SoqiyExcVLheIqlFc4E29sXbc3wwFllH2M=
Received: by 10.231.40.216 with SMTP id l24mr794835ibe.40.1258891381998; Sun, 
	22 Nov 2009 04:03:01 -0800 (PST)
In-Reply-To: <7v1vjrmfjw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133430>

On Sun, Nov 22, 2009 at 4:58 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> There are no tests for 'envelope-sender', so I don't think it should
>> be a requirement for this patch to do so....
>
> The fact that the lack of test was pointed out as a problem makes it =
a
> requirement. =C2=A0Others' earlier mistakes are not an excuse for you=
 to do a
> poor job.

Maybe I should wait until somebody adds the tests to --envelope-sender
before pushing this patch.

> I do use --envelope-sender when sending patches out via msmtp. =C2=A0=
What
> wonderful things this patch adds am I missing in my current setup?

You need to specify your mail address when setting the variable,
right? I use multiple email addresses, so that when I change it
($EMAIL or user.email) the right one will be used in the envelope. If
I use 'sendemail.envelopesender' I would
 need to change it as well.

Another option is to do something like 'sendemail.envelopesender=3Dauto=
'.

--=20
=46elipe Contreras
