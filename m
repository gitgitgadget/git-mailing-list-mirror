From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add diffmerge as a pre-configured 
	mergetool option
Date: Wed, 9 Dec 2009 16:16:39 -0800
Message-ID: <76718490912091616n250a4b93h941c91b572c5be1c@mail.gmail.com>
References: <1260302477-49412-1-git-send-email-jaysoffian@gmail.com>
	 <7vaaxrn10o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 01:16:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIWi9-0007il-8h
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 01:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759106AbZLJAQg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 19:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759091AbZLJAQg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 19:16:36 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:63620 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758864AbZLJAQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 19:16:35 -0500
Received: by iwn1 with SMTP id 1so4997323iwn.33
        for <git@vger.kernel.org>; Wed, 09 Dec 2009 16:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3wi1YBlXIDrUtsdynrtc6DREvDiMOwpnfE6aVIcGf54=;
        b=H1suDHltGaz6QekGqaPdn8Zo1zOxzQbJX35oPdrpybcI4zqBdn1gw/DbQCNTL1QEfk
         oSbsBTObpYrzpcr79u7P0aSktjn7OIDs1LIki7czX2Z/1wJZJHQq4IAI0PxioUXasu77
         7+UHqBwd4xSo5FxUK5q49X4P/fLhm2viuvDCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=A0UzEDF87qshq68TFSMgz73I+GdgXKsr95M4wZRqTridMLOrNf7whsJ/Uj3Pn57ysh
         97HMuGEpmo/LqcNiiu24L80uJR74/Us2z9idKREB3l1QWEpTFRbigTjQIOF7EjTmjKfw
         ftFyaIEaZCG7iEYYJztAIEBIcBRBHXqmgaEig=
Received: by 10.231.167.65 with SMTP id p1mr264013iby.20.1260404199323; Wed, 
	09 Dec 2009 16:16:39 -0800 (PST)
In-Reply-To: <7vaaxrn10o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135007>

On Wed, Dec 9, 2009 at 4:08 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Perhaps it is a better approach to first eject bulk of code for the
> backends we currently support under these case statements into separa=
te
> files, one per backend, move them to mergetool/ subdirectory in the s=
ource
> tree, install them as "$(share)/git-core/mergetool/$toolname", and at
> runtime source them? =C2=A0That way, a patch to add a new backend can=
 be as
> simple as adding a new file in mergetool/ and doing nothing else. =C2=
=A0Also an
> end user can privately add support to a new backend much more easily.
>
> Anybody want to try that approach?

Sure. There may also be value in emulating the mercurial approach:

  http://mercurial.selenic.com/wiki/MergeToolConfiguration

I'll give both a shot.

j.
