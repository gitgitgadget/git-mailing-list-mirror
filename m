From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase -i: remove undocumented '--verify' flag
Date: Tue, 23 Nov 2010 20:09:06 -0500
Message-ID: <AANLkTinF8kTRS+MoxLhnVNNN2+jdev5N9cRM-TwHv9np@mail.gmail.com>
References: <1290408504-14639-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<vpqoc9hsemy.fsf@bauges.imag.fr>
	<201011221414.15982.trast@student.ethz.ch>
	<vpq8w0lqyf7.fsf@bauges.imag.fr>
	<alpine.DEB.1.10.1011222103290.17721@debian>
	<7vfwurvluh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 24 02:09:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL3rH-0007EB-9a
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 02:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab0KXBJJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 20:09:09 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47951 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab0KXBJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 20:09:07 -0500
Received: by qyk12 with SMTP id 12so3153831qyk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 17:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e2BJwJ+qOMfLJ3HQUs0U3JdZt5BpEd5jrsjFBsnSgQM=;
        b=LTF6y/Q6ggnk9L6JPJH6GgfOiTCDI6aLs83HX9RI+OYnWwlGIN1C2YYd7DNfVJPT2N
         9ohtGdyRzryLwTs0KeoceZHyuXAUIbZUfGEcNzCs4bRq5vavRfFZ4sdokbWqfE7MhsFy
         yZJ5wOkZkmDL157XCOc/xRLWuQ7oxnKk0ip28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RDNjqDB8p9lZtvGPp+VLHonzlkHMvqHb5Le5OsbeevXVX9SHifW4ddd/6maEN3hHDs
         g+lnqDTjoeKBzNXBvaT6iWoVL/3f8mr3YVySXmy9gxzsyPJLzlauyrY5G1xwMghZO6B1
         noezNjYWW/b9juUm4pumJ/0CG9i3cbBLPIHVI=
Received: by 10.224.11.67 with SMTP id s3mr5782899qas.144.1290560946038; Tue,
 23 Nov 2010 17:09:06 -0800 (PST)
Received: by 10.224.200.138 with HTTP; Tue, 23 Nov 2010 17:09:06 -0800 (PST)
In-Reply-To: <7vfwurvluh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162039>

On Tue, Nov 23, 2010 at 3:14 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Somehow this patch seems severely whitespace mangled---please check y=
our
> MUA. =C2=A0I think I've seen Alpine send patches sanely; there should=
 be a way
> to tell it to behave.

Hmm... It must be the format=3Dflowed stuff, which should be turned off
according to SubmittingPatches. It is apparently on by default in
Alpine. I have now turned it off, so it will hopefully look
better next time. I tried sending the patch to myself, but I couldn't
see any difference either in Gmail or in Alpine. As far as I can
understand, this option only affects the presentation. I didn't see
anything wrong with the raw message.

Sorry about the inconvenience :-(.

> No need to resend; I can unmunge this patch by hand.

Thanks.
