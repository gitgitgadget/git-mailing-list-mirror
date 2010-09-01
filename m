From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2010, #01; Wed, 1)
Date: Wed, 1 Sep 2010 14:54:45 -0600
Message-ID: <AANLkTi=ma8MLssD_1YeSju7iJucRN9NFzYESJ2rGhyjv@mail.gmail.com>
References: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 22:54:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquKb-0004F2-Q5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab0IAUyr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:54:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44398 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0IAUyr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 16:54:47 -0400
Received: by fxm13 with SMTP id 13so5088103fxm.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DpiHZK3VzFgt5ix/XpdJMntffbAt8s/jd9Y3toBfLok=;
        b=bThUWFIcO7VwWqgB9z1QEuAl5wL4OzJPF0luDyadWPxE3eKXcRBB9dRJ3v8cKUyogJ
         qhIB4lgXG85JLgoU8sTfn+x0lLL0lMFkse5+Sldwb2rhmuU2oxYAf5R/2PcY95QzSIB2
         zBTmReFXe4LqL/Kgr5PPFw+akQ5ys+PPMAc+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RD0v1cCxpRPnEntjQNQOLogXQA6ZKSl41gtSpeNnt5Z0+gk+iuZ3gF3M2HZdMY5MDy
         lgTlejgYPfOh2eQpNA23JapY5B12YCo00R5I2NLdbyNeJpuxNNW1kB2qIu9VSiMBximp
         nfNLrfDLcvp2R9khyR3AWqOJLaPMaanPdZTho=
Received: by 10.223.122.6 with SMTP id j6mr7553113far.78.1283374485739; Wed,
 01 Sep 2010 13:54:45 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Wed, 1 Sep 2010 13:54:45 -0700 (PDT)
In-Reply-To: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155092>

> * en/object-list-with-pathspec (2010-08-26) 2 commits
> =C2=A0- Make rev-list --objects work together with pathspecs
> =C2=A0- Add testcases showing how pathspecs are ignored with rev-list=
 --objects
>
> Heard that this is still broken?

Are you possibly remembering v1 of the series, which mis-used the
tree_entry_interesting() API, and was fixed by v2 including extra
testcases?  You merged the latter into pu, so there's no remaining
issue I know of.

However, if I've missed some email or other report about any other
breakage, let me know and I'll take a look.

> * en/tree-walk-optim (2010-08-26) 4 commits
> =C2=A0- diff_tree(): Skip skip_uninteresting() when all remaining pat=
hs interesting
> =C2=A0- tree_entry_interesting(): Make return value more specific
> =C2=A0- tree-walk: Correct bitrotted comment about tree_entry()
> =C2=A0- Document pre-condition for tree_entry_interesting
>
> I think the idea is sound. =C2=A0For a patch that touches fairly core=
 part of
> the system, it came a bit late in the cycle, though.

I agree, both this and the en/object-list-with-pathspec series
probably make sense to wait for 1.7.4.
