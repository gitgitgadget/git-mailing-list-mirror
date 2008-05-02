From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH 0/2] Show committer ident in some cases
Date: Sat, 3 May 2008 00:07:44 +0200
Message-ID: <8aa486160805021507s44d7946ejc48ac8a4af08e8cc@mail.gmail.com>
References: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
	 <7vwsmcwfcn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Js3R5-0004Yd-LG
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 00:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbYEBWHs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2008 18:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbYEBWHs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 18:07:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:16640 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965030AbYEBWHr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2008 18:07:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so29361ywe.1
        for <git@vger.kernel.org>; Fri, 02 May 2008 15:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ksxWqObBirAa4RPQU0VVa28UTJSfOtaAtKDlBAG7fqc=;
        b=jTTaeCGf3b60RFxBoJREfXilRDA1zPtEMqfl0LcF29u+CHnBKbNV4qTl0CsRe3hprnhBvNRKfc9wZx7BlroP42Zi6Xuk3fH33OMOv968XQOIu71beeRpmesqCZxUlmI2LOyoOUlMrIeYuF8DZYJ9ZEUsTR4b5abI8SYd8bRCI74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b0kKwiqkZVbvAQjcA52LQc9GK6yBIacRXzCRi+JhqLgLSxH43Pc5w+lu2/XEBqvkxPeEbAmxPfLoA/c5A30er0dnVAcVhw6FlEzzBfSymliO7O/hw/QT7A+OaRj9rvJ0hdTeWa+fxKv3+qhDsO4nylWlL6yTte5tyYhZMz+gTOw=
Received: by 10.150.11.2 with SMTP id 2mr4064365ybk.12.1209766064681;
        Fri, 02 May 2008 15:07:44 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Fri, 2 May 2008 15:07:44 -0700 (PDT)
In-Reply-To: <7vwsmcwfcn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81038>

On Fri, May 2, 2008 at 11:44 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
>  > The definition of "wrong committer" could be:
>  >
>  > 1) user.{name,email} or GIT_COMMITTER_{NAME,EMAIL} is not a wrong =
committer.
>  > 2) automatic without a domain name (user@hostname.(none)) is a wro=
ng committer.
>  >    (not handled with this patch series)
>  > 3) automatic or partially set ident:
>  >    a) wrong committer for some users
>  >    b) right committer for others
>
>  Define "partially set".

one of user.{name,email} is not set.

>
>  > Santi B=C3(c)jar (2):
>
>  ???

the MIME stuff was not written for the cover letter.

Santi

>
