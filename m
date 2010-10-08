From: Pat Notz <patnotz@gmail.com>
Subject: Re: [RFC PATCH v5 0/3] git-remote-fd & git-remote-ext
Date: Fri, 8 Oct 2010 14:07:22 -0600
Message-ID: <AANLkTik3SC5p2nvPMoj5-MWk0HnJ1WNTtEwPK4L8Hrae@mail.gmail.com>
References: <1286563200-7270-1-git-send-email-ilari.liusvaara@elisanet.fi> <7vtykwv4os.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 22:07:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4JEM-0006zq-SC
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 22:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765Ab0JHUHo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 16:07:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65122 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757006Ab0JHUHn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Oct 2010 16:07:43 -0400
Received: by fxm14 with SMTP id 14so715720fxm.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nqnH5FK7G98yuiGkxBulvhwTKNY9t+BuR1Bl2Awj6KU=;
        b=vLAZTY8qlvNEAWXI/c5uiaj32NpfQRLwUHCTxd3HApCwFAhU8wQV05FqfM/j9dBbNd
         lSVJ5MHrvwh/2h4yy13pG8h0K2jBylUFK3MJn4VUBZh71BMsV5J2Q/z3z6019QVy6NBU
         3iQliIhcs5/kqnG9HThaaYAY4F+9YMtRPLelM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jHO9pwbVMK0e+nAFtV07xRE0ebcR2N1qY0XJvfiOq1I3dAe46keNtCGrad+SoPQe6j
         xdRBJm6QnHLahlDLm+t+sz2WSr/6dPpHE1AMtiJ1lDtVVcKj83BgIwpd9+lI4iWOFUT6
         QAL2gmaA+uuYsS+y7LgBsxQdzYzK+NuEkHoy4=
Received: by 10.239.165.72 with SMTP id w8mr185889hbd.79.1286568462275; Fri,
 08 Oct 2010 13:07:42 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Fri, 8 Oct 2010 13:07:22 -0700 (PDT)
In-Reply-To: <7vtykwv4os.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158534>

On Fri, Oct 8, 2010 at 1:56 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
[snip]
> Could you fix these up at your end please?
>
> ERROR: space required before the open parenthesis '('
> #216: FILE: transport-helper.c:990:
> + =A0 =A0 =A0 while(t->state !=3D SSTATE_FINISHED) {
>
[snip]


Please forgive my newness. What are you using to do the style check?
I'd love to run that myself, preferably in a pre-commit hook or
something.  Maybe we can use astyle to help with this too.

Thanks ~ Pat
