From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 0/3] Update advice in commit/status output
Date: Sat, 12 Dec 2009 17:06:07 -0500
Message-ID: <76718490912121406q31ddcd12s3d813659d5096a22@mail.gmail.com>
References: <7vk4wtysyu.fsf@alter.siamese.dyndns.org>
	 <1260608523-15579-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJdgE-00040b-BY
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:55:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933414AbZLMBxt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Dec 2009 20:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933354AbZLMBxr
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:53:47 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:42071 "HELO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933140AbZLMBxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Dec 2009 20:53:45 -0500
Received: by iwn1 with SMTP id 1so1261065iwn.33
        for <git@vger.kernel.org>; Sat, 12 Dec 2009 17:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PwsP1SpE9L5+mSBARg+aVytz8iHAHI0fQ0xxOvYQarE=;
        b=eS6Yl0VVv+99GkenUuUIYKRThjVlnzK2O8FmMYPwAAgH5hXcY+YwdafCQglHwNJlVF
         pMU5xErksz3qJvouB+0/BjCAFFfXnkq798aNulPWRYoHeuMCwBktHNlU+8v7V4AGnR8m
         wJ8//VLbzErZuRFTRp8sUjeiOGyvQze8i11sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WZ5KAZghi1iY352vrNNpGrqcXkb8ujyFwGQE+QLwMIeO20f4rQyueNeLjkFhWATwDE
         9oxyZ9dAZn7YFBtch20KOQhs1wIZWkF9E6t5J8PBhUwzKfMzgRuoOv8nJyhyotChGNpN
         ISkGzuwIFCvwEEA0CzCFUS3+3m1kOIJl+fqtI=
Received: by 10.231.9.218 with SMTP id m26mr3217816ibm.29.1260655567599; Sat, 
	12 Dec 2009 14:06:07 -0800 (PST)
In-Reply-To: <1260608523-15579-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135146>

On Sat, Dec 12, 2009 at 4:02 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jay Soffian noticed that we give "git reset HEAD <path>" as an instru=
ction
> to get rid of the local change that has already been added to the ind=
ex
> even when <path> is unmerged, or it is merged and we are about to com=
mit a
> merge.
>
> In neither case, "git reset HEAD <path>" is absolutely a wrong thing =
to do
> while merging.
>
> This miniseries updates the advices given in status/commit. =C2=A0It =
applies on
> top of the jk/1.7.0-status topic, and has trivial conflicts in wt-sta=
tus.c
> with the jk/unwanted-advices topic that has already graduated to 'mai=
nt'.

Series looks good to me after the spelling correction. Thank you.

j.
