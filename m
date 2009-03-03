From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] git-clone.txt: document that pushing from a shallow clone 
	may work
Date: Tue, 3 Mar 2009 14:27:29 -0500
Message-ID: <76718490903031127v7fcec124je7292c4c465208b8@mail.gmail.com>
References: <237967ef0902160200r2320687ai71e62047c3ead9ad@mail.gmail.com>
	 <1236080017-13987-1-git-send-email-dato@net.com.org.es>
	 <49AD1B22.6050201@viscovery.net>
	 <20090303120856.GB15003@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	gitster@pobox.com, Mikael Magnusson <mikachu@gmail.com>,
	Joey Hess <joey@kitenet.net>
To: =?UTF-8?Q?Adeodato_Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:29:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeaIV-000643-FM
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbZCCT1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 14:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbZCCT1b
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:27:31 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:11262 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbZCCT1b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 14:27:31 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2923936rvb.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 11:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PzzZwgJcQOw+FfmF5xY8JfLERiQpIC1CmDSYV9BSobA=;
        b=DCZ/ViDdW+ABFtCVCkXmXEfOzzTKTKSMbOOceAII1sbmjh3yL0NPTNs4Nwj3itrRsd
         TITvOv2FlnyDnACbQ5UlWKFQighKwhJFC+6XmzoMUEJ+1urjz1mWyRKR7ydfUttKIGNM
         IelalGeksX1gGQ4y157Gu79WbXjrYmBHQFwcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q/tEqF+vDcg/6ka8UF4DnqVoD/nnpr7bVRJ1VZmfZokKW9txiQ3ejpm/yx2O2krNDx
         OnZP0ieV2FD3qJ8fNhERHXud7Z7DW1IEtem2YkoAkvSJR1d9IR8IxVWcDBLA3KcDF5Su
         g8RnjLaPQpAt3AOkt3ybEYIW4rdTNUD2A50aQ=
Received: by 10.141.212.5 with SMTP id o5mr3704990rvq.11.1236108449285; Tue, 
	03 Mar 2009 11:27:29 -0800 (PST)
In-Reply-To: <20090303120856.GB15003@chistera.yi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112152>

On Tue, Mar 3, 2009 at 7:08 AM, Adeodato Sim=C3=B3 <dato@net.com.org.es=
> wrote:
> Well, I don't know if the set of cases where it'll work can be define=
d
> in detail to a point where it is useful. If it is, then sure, let's d=
o
> it.
>
> My point is that if it will work in some cases, then the documentatio=
n
> should *acknowledge that fact*, because else people will assume the
> documentation is wrong, and believe it is intended to work, which is =
not
> the case.

Wy not just say "pushing into a shallow repository is not supported"
instead of "pushing into a shallow repository won't work."

j.
