From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH] git submodule summary: add --files option
Date: Sat, 15 Aug 2009 10:40:42 +0200
Message-ID: <8c5c35580908150140q1d209664ic5e3816609365e24@mail.gmail.com>
References: <4A846A62.7010306@web.de> <7v8whmjhqh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 10:40:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McEoo-00026p-FA
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 10:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbZHOIkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Aug 2009 04:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbZHOIkn
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 04:40:43 -0400
Received: from mail-gx0-f205.google.com ([209.85.217.205]:43240 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbZHOIkm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2009 04:40:42 -0400
Received: by gxk1 with SMTP id 1so2711258gxk.17
        for <git@vger.kernel.org>; Sat, 15 Aug 2009 01:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+3jBKuZ11Dann5R73X+y6kZ8SvCS29oQJkFGCBy5loY=;
        b=B0Facq8g8+jRMP1T19xNGGt0MrHf8NMDzaKUdWiq2+noEdvaVW6c5Pt/JCrpAs2StH
         RexCvUfKg+AM1FWEg5doVRxt5OBJjLoKQPsY7iKrqLA8lxGb9+E7kbmRO0hbbL5m8g0A
         oUvcauJIAKU6edpoiG1oQwYpPTPfvl27EH1ww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b/FqZYlR0eTWisVfUcIeVS2OAuP67cUf103UFD+DJ6ryyDn1PGf/h58Jw1S/e1NO5m
         q46CdBm/j6YcyJpsIkvYKjgDv0rgJHPjhZ+r438P8zvtRmeL1nddxJwq2yu4EDQUKxFF
         o0XVaR0ND0QgJAEbbznuFsQ2DG1g1abvPdxPo=
Received: by 10.151.92.9 with SMTP id u9mr3364284ybl.158.1250325643013; Sat, 
	15 Aug 2009 01:40:43 -0700 (PDT)
In-Reply-To: <7v8whmjhqh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125985>

On Fri, Aug 14, 2009 at 21:52, Junio C Hamano<gitster@pobox.com> wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> git submodule summary is providing similar functionality for submodu=
les as
>> git diff-index does for a git project (including the meaning of --ca=
ched).
>> But the analogon to git diff-files is missing, so add a --files opti=
on to
>> summarize the differences between the index of the super project and=
 the
>> last commit checked out in the working tree of the submodule.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>
> Makes sense to me. =C2=A0Comments?

Acked-by: Lars Hjemli <hjemli@gmail.com> with a tiny fixup:

--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -129,7 +129,7 @@ summary::
        in the submodule between the given super project commit and the
        index or working tree (switched by --cached) are shown. If the =
option
        --files is given, show the series of commits in the submodule b=
etween
-       the index of super project the and the working tree of the subm=
odule
+       the index of the super project and the working tree of the subm=
odule
        (this option doesn't allow to use the --cached option or to pro=
vide an
        explicit commit).
