From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH v2] Docs: git checkout --orphan: `root commit' and `branch head'
Date: Tue, 27 Sep 2011 16:13:35 +0000
Message-ID: <CAMOZ1Buf5KxbN59o8QK_dMmF_SEY_Ckuz4DALorZpwuL9gx-Pg@mail.gmail.com>
References: <1316960136073-6829212.post@n2.nabble.com> <1316961212.4388.5.camel@centaur.lab.cmartin.tk>
 <7vaa9r2jii.fsf@alter.siamese.dyndns.org> <1317073309.5579.9.camel@centaur.lab.cmartin.tk>
 <vpq39fi9gf5.fsf@bauges.imag.fr> <69d6fb3199bc4f74b25dae7992a9f132-mfwitten@gmail.com>
 <vpqsjni6kkk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	vra5107 <venkatram.akkineni@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 27 18:14:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8aIO-0007B9-Q4
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 18:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372Ab1I0QOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Sep 2011 12:14:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46329 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1I0QOF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2011 12:14:05 -0400
Received: by iaqq3 with SMTP id q3so5867767iaq.19
        for <git@vger.kernel.org>; Tue, 27 Sep 2011 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WxitEYufqtifGTrmU6doKTScb+Rf1729+AQ69IHEy5w=;
        b=nZfWdts4jMnYlLuLUlaGkgt4KNBVXKpAcTsCi77EPEhKui3zOoIjoeieCYxE62l84n
         xJp2ijcn4L4kBjO2RFNCuGs7g+g7aI0j5ySDXw60YIN18WTo5U6CnVrmdsI3BiGEgWp6
         a+OqHoUh4Jxz5OYzgI918KdzNAx2usMdg6EqQ=
Received: by 10.42.95.8 with SMTP id d8mr9994826icn.106.1317140045316; Tue, 27
 Sep 2011 09:14:05 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Tue, 27 Sep 2011 09:13:35 -0700 (PDT)
In-Reply-To: <vpqsjni6kkk.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182248>

On Tue, Sep 27, 2011 at 16:01, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> -This can be useful when you want to publish the tree from a commit
>> -without exposing its full history. You might want to do this to pub=
lish
>> -an open source branch of a project whose current tree is "clean", b=
ut
>> -whose full history contains proprietary or otherwise encumbered bit=
s of
>> -code.
>
> This part used to be just this in v1:
>
> -This can be useful when you want to publish the tree from a commit
> -without exposing its full history. You might want to do this to publ=
ish
> +This can be useful when you want to publish a tree without exposing =
its
> +full history; for instance, you might want to do this to publish
> =C2=A0an open source branch of a project whose current tree is "clean=
", but
> =C2=A0whose full history contains proprietary or otherwise encumbered=
 bits of
> =C2=A0code.
>
> is it intentionnal that you discarded completely the paragraph? If so=
,
> then I disagree, the paragraph was one of the main motivation for
> someone to use --orphan, without it, someone may understand _what_ it
> does, but not _why_ it is useful.

It was intentional; I was finding it difficult to express that
paragraph succintly in a way that is consistent with correct
terminology. Then I realized it's fairly redundant, anyway.

I think that the last paragraph provides enough context to understand
its usefulness. Also, anybody who ever independently decided to carve
out proprietary bits in that way would immediately recognize the need
for creating a commit without parents, a notion which would lead him
or her pretty quickly to this documentation or jog his or her memory
about it based on the text of v2.

If everyone else is quite set on keeping that paragraph, though, I'll
take the challenge; however, I think that would be a waste of time.
