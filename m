From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: format-patch on permission change gives empty patch
Date: Thu, 7 Oct 2010 10:15:49 +0200
Message-ID: <AANLkTimA4jrDXmfJp2em34fj6b1sj9kdEyZ_xPTzqcEN@mail.gmail.com>
References: <20101006.173714.245380201.davem@davemloft.net>
 <20101006.174008.70175671.davem@davemloft.net> <7vtykyy70w.fsf@alter.siamese.dyndns.org>
 <7vocb6y5sq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Miller <davem@davemloft.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 10:16:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3leN-0003LO-FE
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 10:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139Ab0JGIQM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 04:16:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:37933 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759436Ab0JGIQJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 04:16:09 -0400
Received: by gwj17 with SMTP id 17so179214gwj.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9gkUKSsKCOh92brKCHLlfcUK/xNPl04SI9ZIg7GzSYY=;
        b=ksD65KiaiS4SvYPtWu4vcs98ZmZtyzib2ILqgsNz5FJv4P3qJmnv/DyUBTBsZr6vaI
         M9LP1dpJ9MYBhTByzWYPfvMfmNNh/OWIMmDjlrFrHon+kDpUDshOylc9r7pt+NmpLXDa
         tkOh3JHIhILD+/xMocK/X7CvC9bTCAg4mbBDk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VNfC73HfSgBPTT435eJac7yu+Uu7VDrRdNI9xeDb818ysLbmQaJrprjNYoUtFWGLxf
         ThO80nvmAy3H+YyJzxS0ct8b/I1TcmtUoCduAq4rORcwSKTIfVCnrppcccCFuTk8qcBi
         2aaL/oTGAOjIgAjyMe9MwS/RF266Li+RZkDdY=
Received: by 10.150.201.18 with SMTP id y18mr595475ybf.329.1286439369266; Thu,
 07 Oct 2010 01:16:09 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 01:15:49 -0700 (PDT)
In-Reply-To: <7vocb6y5sq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158384>

Heya,

On Thu, Oct 7, 2010 at 06:40, Junio C Hamano <gitster@pobox.com> wrote:
> =C2=A0(2) Treat "rebase" as a way to reproduce history faithfully, ev=
en an
> =C2=A0 =C2=A0 unreasonable one. =C2=A0We could teach "--allow-empty" =
to "am", and
> =C2=A0 =C2=A0 rewrite the pipeline as "format-patch --always | am --a=
llow-empty" to
> =C2=A0 =C2=A0 implement it.

Wouldn't we then have to keep adding options for other corner cases?
Perhaps a '--plumbing' flag that makes format-patch behave sanely
(e.g., also do stuff like, turn off color and whatnot) and that makes
'git am' accept everything it knows how to understand?

--=20
Cheers,

Sverre Rabbelier
